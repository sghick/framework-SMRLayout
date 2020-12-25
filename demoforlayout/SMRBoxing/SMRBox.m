//
//  SMRBox.m
//  demoforlayout
//
//  Created by Tinswin on 2020/12/21.
//

#import "SMRBox.h"

@implementation SMRLayout

+ (instancetype)layout:(void (^)(__kindof SMRLayout * _Nonnull))setting {
    id obj = [[self alloc] init];
    if (setting) {
        setting(obj);
    }
    return obj;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dirty = YES;
    }
    return self;
}

- (void)setState {
    [self layoutWithinBounds:[self boundsThatFit]];
    _dirty = NO;
}

- (CGSize)sizeThatFit {
    return CGSizeZero;
}

- (CGRect)boundsThatFit {
    CGRect bounds = {0, 0, [self sizeThatFit]};
    return bounds;
}

- (CGSize)layoutWithinBounds:(CGRect)bounds {
    return bounds.size;
}

@end

@implementation SMRBox

- (CGSize)sizeThatFit {
    return CGSizeMake(_width ?: _view.frame.size.width, _height ?: _view.frame.size.height);
}

- (CGSize)layoutWithinBounds:(CGRect)bounds {
    CGPoint limitOrigin = bounds.origin;
    CGSize limitSize = bounds.size;
    if (_child) {
        CGSize csize = [_child sizeThatFit];
        CGSize paddingSize = CGSizeMake(limitSize.width - _padding.left - _padding.right,
                                        limitSize.height - _padding.top - _padding.bottom);
        if (bounds.size.width && (csize.width > paddingSize.width)) {
            NSLog(@"warning:%@超出父布局限定宽, in:%@", _child, self);
        }
        if (bounds.size.height && (csize.height > paddingSize.height)) {
            NSLog(@"warning:%@超出父布局限定宽, in:%@", _child, self);
        }
        CGRect frame = CGRectMake(limitOrigin.x, limitOrigin.y,
                                  csize.width ?: paddingSize.width,
                                  csize.height ?: paddingSize.height);
        CGPoint alignOffset = [self p_offsetWithSize:frame.size maxSize:limitSize];
        frame = CGRectMake(frame.origin.x + _padding.left + alignOffset.x,
                           frame.origin.y + _padding.top + alignOffset.y,
                           frame.size.width, frame.size.height);
        limitSize = [_child layoutWithinBounds:frame];
    }
    
    if (_view) {
        CGRect frame = CGRectMake(limitOrigin.x, limitOrigin.y,
                                  bounds.size.width ?: limitSize.width,
                                  bounds.size.height ?: limitSize.height);
        _view.frame = frame;
    }
    return limitSize;
}

- (CGPoint)p_offsetWithSize:(CGSize)size maxSize:(CGSize)maxSize {
    switch (_align) {
        case SMRAlignTopLeft:
            return CGPointMake(0, 0);
        case SMRAlignTopCenter:
            return CGPointMake((maxSize.width - size.width)/2, 0);
        case SMRAlignTopRight:
            return CGPointMake((maxSize.width - size.width), 0);
        case SMRAlignCenterLeft:
            return CGPointMake((maxSize.width - size.width)/2, 0);
        case SMRAlignCenter:
            return CGPointMake((maxSize.width - size.width)/2, (maxSize.height - size.height)/2);
        case SMRAlignCenterRight:
            return CGPointMake((maxSize.width - size.width)/2, (maxSize.height - size.height));
        case SMRAlignBottomLeft:
            return CGPointMake(0, (maxSize.height - size.height));
        case SMRAlignBottomCenter:
            return CGPointMake((maxSize.width - size.width)/2, (maxSize.height - size.height));
        case SMRAlignBottomRight:
            return CGPointMake((maxSize.width - size.width), (maxSize.height - size.height));
        default: break;
    }
    return CGPointZero;
}

@end

@implementation SMRRow

- (CGSize)layoutWithinBounds:(CGRect)bounds {
    CGPoint limitOrigin = bounds.origin;
    CGSize limitSize = bounds.size;
    limitOrigin = CGPointMake(limitOrigin.x + _padding.left,
                              limitOrigin.y + _padding.top);
    limitSize = CGSizeMake(limitSize.width - _padding.left - _padding.right,
                           limitSize.height - _padding.top - _padding.bottom);
    
    NSMutableArray<NSValue *> *fixSizes = [NSMutableArray array];
    NSInteger expendCount = 0;
    CGFloat expendWidth = 0;
    CGFloat fixChildWidth = 0;
    CGFloat maxHeight = 0;
    for (int idx = 0; idx < _children.count; idx++) {
        SMRLayout *child = _children[idx];
        CGSize csize = [child sizeThatFit];
        [fixSizes addObject:[NSValue valueWithCGSize:csize]];
        if (csize.width) {
            fixChildWidth += csize.width;
        } else {
            expendCount ++;
        }
        if (fixChildWidth > limitSize.width) {
            NSLog(@"warning:%@超出父布局限定宽, in:%@", child, self);
        }
        maxHeight = MAX(maxHeight, csize.height);
    }
    if (expendCount) {
        expendWidth = (limitSize.width - fixChildWidth)/expendCount;
    }
    NSMutableArray<NSValue *> *preframes = [NSMutableArray array];
    CGFloat offsetX = limitOrigin.x;
    CGFloat fixdWidth = 0;
    for (int idx = 0; idx < _children.count; idx++) {
        CGSize csize = fixSizes[idx].CGSizeValue;
        
        CGSize dessize = CGSizeMake(csize.width ?: expendWidth,
                                    csize.height ?: limitSize.height);
        CGFloat offsetY = limitOrigin.y + [self p_offsetYWithHeight:dessize.height maxHeight:maxHeight];
        CGRect frame = CGRectMake(offsetX, offsetY, dessize.width, dessize.height);
        offsetX += frame.size.width;
        fixdWidth += frame.size.width;
        [preframes addObject:[NSValue valueWithCGRect:frame]];
    }
    CGFloat fixdOffsetX = [self p_fixdOffsetXWithWidth:fixdWidth maxWidth:limitSize.width];
    for (int idx = 0; idx < _children.count; idx++) {
        SMRLayout *child = _children[idx];
        CGRect frame = preframes[idx].CGRectValue;
        frame = CGRectMake(frame.origin.x + fixdOffsetX, frame.origin.y,
                           frame.size.width, frame.size.height);
        [child layoutWithinBounds:frame];
    }
    
    return bounds.size;
}

- (CGFloat)p_offsetYWithHeight:(CGFloat)height maxHeight:(CGFloat)maxHeight {
    switch (_crossAlign) {
        case SMRCrossAlignStart:
            return 0;
        case SMRCrossAlignEnd:
            return (maxHeight - height);
        default: break;
    }
    return (maxHeight - height)/2;
}

- (CGFloat)p_fixdOffsetXWithWidth:(CGFloat)width maxWidth:(CGFloat)maxWidth {
    switch (_mainAlign) {
        case SMRMainAlignStart:
            return 0;
        case SMRMainAlignEnd:
            return (maxWidth - width);
        default: break;
    }
    return (maxWidth - width)/2;
}

@end

@implementation SMRColumn

- (CGSize)layoutWithinBounds:(CGRect)bounds {
    CGPoint limitOrigin = bounds.origin;
    CGSize limitSize = bounds.size;
    
    NSMutableArray<NSValue *> *fixSizes = [NSMutableArray array];
    NSInteger expendCount = 0;
    CGFloat expendHeight = 0;
    CGFloat fixChildHeight = 0;
    CGFloat maxWidth = 0;
    for (int idx = 0; idx < _children.count; idx++) {
        SMRLayout *child = _children[idx];
        CGSize csize = [child sizeThatFit];
        [fixSizes addObject:[NSValue valueWithCGSize:csize]];
        if (csize.height) {
            fixChildHeight += csize.height;
        } else {
            expendCount ++;
        }
        if (fixChildHeight > limitSize.height) {
            NSLog(@"warning:%@超出父布局限定宽, in:%@", child, self);
        }
        maxWidth = MAX(maxWidth, csize.width);
    }
    if (expendCount) {
        expendHeight = (limitSize.height - fixChildHeight)/expendCount;
    }
    NSMutableArray<NSValue *> *preframes = [NSMutableArray array];
    CGFloat offsetY = limitOrigin.y;
    CGFloat fixdHeight = 0;
    for (int idx = 0; idx < _children.count; idx++) {
        CGSize csize = fixSizes[idx].CGSizeValue;
        
        CGSize dessize = CGSizeMake(csize.width ?: limitSize.width,
                                    csize.height ?: expendHeight);
        CGFloat offsetX = limitOrigin.x + [self p_offsetXWithWidth:dessize.width maxWidth:maxWidth];
        CGRect frame = CGRectMake(offsetX, offsetY, dessize.width, dessize.height);
        offsetY += frame.size.height;
        fixdHeight += frame.size.height;
        [preframes addObject:[NSValue valueWithCGRect:frame]];
    }
    CGFloat fixdOffsetY = [self p_fixdOffsetYWithHeight:fixdHeight maxHeight:limitSize.height];
    for (int idx = 0; idx < _children.count; idx++) {
        SMRLayout *child = _children[idx];
        CGRect frame = preframes[idx].CGRectValue;
        frame = CGRectMake(frame.origin.x, frame.origin.y + fixdOffsetY,
                           frame.size.width, frame.size.height);
        [child layoutWithinBounds:frame];
    }
    
    return bounds.size;
}

- (CGFloat)p_offsetXWithWidth:(CGFloat)width maxWidth:(CGFloat)maxWidth {
    switch (_crossAlign) {
        case SMRCrossAlignStart:
            return 0;
        case SMRCrossAlignEnd:
            return (maxWidth - width);
        default: break;
    }
    return (maxWidth - width)/2;
}

- (CGFloat)p_fixdOffsetYWithHeight:(CGFloat)height maxHeight:(CGFloat)maxHeight {
    switch (_mainAlign) {
        case SMRMainAlignStart:
            return 0;
        case SMRMainAlignEnd:
            return (maxHeight - height);
        default: break;
    }
    return (maxHeight - height)/2;
}

@end
