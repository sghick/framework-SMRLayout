//
//  SMRBox.m
//  demoforlayout
//
//  Created by Tinswin on 2020/12/21.
//

#import "SMRBox.h"
#import "SMRGeometry.h"

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
    CGRect limit = CGRectInPadding(bounds, _padding);
    CGSize autoSize = limit.size;
    if (_child) {
        CGSize csize = [_child sizeThatFit];
        if (bounds.size.width && (csize.width > limit.size.width)) {
            NSLog(@"warning:%@超出父布局限定宽, in:%@", _child, self);
        }
        if (bounds.size.height && (csize.height > limit.size.height)) {
            NSLog(@"warning:%@超出父布局限定宽, in:%@", _child, self);
        }
        
        CGSize useSize = CGSizeNoZero(csize, limit.size);
        CGRect frame = {limit.origin, useSize};
        CGPoint alignOffset = [self p_alignOffsetWithSize:useSize inSize:limit.size];
        frame = CGRectOffset(frame, alignOffset.x, alignOffset.y);
        autoSize = [_child layoutWithinBounds:frame];
    }
    
    if (_view) {
        CGSize viewSize = CGSizeNoZero(bounds.size, autoSize);
        CGRect frame = {bounds.origin, viewSize};
        _view.frame = frame;
    }
    return autoSize;
}

- (CGPoint)p_alignOffsetWithSize:(CGSize)size inSize:(CGSize)inSize {
    CGSize subtract = CGSizeSubtract(inSize, size);
    CGPoint mulitPoint = [self p_mulitPointWithAlign:_align];
    CGSize mulitSize = CGSizeMultiply(subtract, mulitPoint);
    return CGPointMake(mulitSize.width, mulitSize.height);
}

- (CGPoint)p_mulitPointWithAlign:(SMRAlign)align {
    switch (align) {
        case SMRAlignTopLeft:
            return CGPointMake(0, 0);
        case SMRAlignTopCenter:
            return CGPointMake(0.5, 0);
        case SMRAlignTopRight:
            return CGPointMake(1, 0);
        case SMRAlignCenterLeft:
            return CGPointMake(0, 0.5);
        case SMRAlignCenter:
            return CGPointMake(0.5, 0.5);
        case SMRAlignCenterRight:
            return CGPointMake(1, 0.5);
        case SMRAlignBottomLeft:
            return CGPointMake(0, 1);
        case SMRAlignBottomCenter:
            return CGPointMake(0.5, 1);
        case SMRAlignBottomRight:
            return CGPointMake(1, 1);
        default: break;
    }
    return CGPointZero;
}

@end

@implementation SMRRow

- (CGSize)layoutWithinBounds:(CGRect)bounds {
    CGRect limit = CGRectInPadding(bounds, _padding);
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
        if (fixChildWidth > limit.size.width) {
            NSLog(@"warning:%@超出父布局限定宽, in:%@", child, self);
        }
        maxHeight = MAX(maxHeight, csize.height);
    }
    if (expendCount) {
        expendWidth = (limit.size.width - fixChildWidth)/expendCount;
    }
    NSMutableArray<NSValue *> *preframes = [NSMutableArray array];
    CGFloat offsetX = limit.origin.x;
    CGFloat fixdWidth = 0;
    for (int idx = 0; idx < _children.count; idx++) {
        CGSize csize = fixSizes[idx].CGSizeValue;
        CGSize useSize = CGSizeNoZero(csize, CGSizeMake(expendWidth, limit.size.height));
        CGFloat offsetY = limit.origin.y + SMRMainAlignOffset(useSize.height, maxHeight, _mainAlign);
        CGRect frame = {{offsetX, offsetY}, useSize};
        offsetX += frame.size.width;
        fixdWidth += frame.size.width;
        [preframes addObject:[NSValue valueWithCGRect:frame]];
    }
    CGFloat fixdOffsetX = SMRCrossAlignOffset(fixdWidth, limit.size.width, _crossAlign);
    for (int idx = 0; idx < _children.count; idx++) {
        SMRLayout *child = _children[idx];
        CGRect frame = CGRectOffset(preframes[idx].CGRectValue, fixdOffsetX, 0);
        [child layoutWithinBounds:frame];
    }
    
    return bounds.size;
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
