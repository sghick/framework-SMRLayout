//
//  SMRLayout.m
//  demoforlayout
//
//  Created by Tinswin on 2020/12/21.
//

#import "SMRLayout.h"
#import "SMRGeometry.h"

@implementation SMRLayout

+ (instancetype)layout:(void (^)(__kindof SMRLayout * _Nonnull))setting {
    id obj = [[super alloc] init];
    if (setting) {
        setting(obj);
    }
    return obj;
}

- (CGRect)setState {
    return [self boundsOfLayout];
}

- (CGSize)sizeOfLayout {
    return [self layoutThatFitSize:CGSizeZero];
}

- (CGRect)boundsOfLayout {
    CGRect bounds = {CGPointZero, [self sizeOfLayout]};
    return [self layoutThatFitBounds:bounds];
}

- (CGSize)layoutThatFitSize:(CGSize)fitSize {
    return fitSize;
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds {
    return fitBounds;
}

@end


@interface SMRCombination ()

@property (strong, nonatomic) SMRLayout *main;

@end

@implementation SMRCombination

+ (instancetype)layout:(void (^)(__kindof SMRLayout * _Nonnull))setting {
    SMRCombination *combination = [super layout:setting];
    combination.main = [combination mainLayoutAfterInit];
    return combination;
}

- (SMRLayout *)mainLayoutAfterInit {
    return nil;
}

- (CGRect)setState {
    return [self.main setState];
}

- (CGSize)sizeOfLayout {
    return [self.main sizeOfLayout];
}

- (CGRect)boundsOfLayout {
    return [self.main boundsOfLayout];
}

- (CGSize)layoutThatFitSize:(CGSize)fitSize {
    return [self.main layoutThatFitSize:fitSize];
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds {
    return [self.main layoutThatFitBounds:fitBounds];
}

@end

@implementation SMRBox

- (CGSize)layoutThatFitSize:(CGSize)fitSize {
    CGSize size = CGSizeMake(_width, _height);
    size = CGSizeNoZero(size, _view.frame.size);
    size = CGSizeNoZero(size, [_child layoutThatFitSize:fitSize]);
    return size;
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds {
    CGRect limit = CGRectInPadding(fitBounds, _padding);
    if (_child) {
        CGSize csize = [_child layoutThatFitSize:limit.size];
        if (fitBounds.size.width && (csize.width > limit.size.width)) {
            NSLog(@"warning:%@超出父布局限定宽:%@, in:%@", _child, @(limit.size.width), self);
        }
        if (fitBounds.size.height && (csize.height > limit.size.height)) {
            NSLog(@"warning:%@超出父布局限定宽:%@, in:%@", _child, @(limit.size.height), self);
        }
        
        CGSize useSize = CGSizeNoZero(csize, limit.size);
        CGRect frame = {limit.origin, useSize};
        CGPoint alignOffset = [self p_alignOffsetWithSize:useSize inSize:limit.size];
        frame = CGRectOffset(frame, alignOffset.x, alignOffset.y);
        limit = [_child layoutThatFitBounds:frame];
    }
    
    limit = CGRectAddPadding(limit, _padding);
    
    if (_view) {
        CGSize viewSize = CGSizeNoZero(fitBounds.size, limit.size);
        CGRect frame = {fitBounds.origin, viewSize};
        _view.frame = frame;
        if ([_view isKindOfClass:UILabel.class]) {
            NSLog(@"label:%@", ((UILabel *)_view).text);
        } else {
            NSLog(@"view:%@", _view);
        }
    }
    return limit;
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

@implementation SMRExpand

@end

@implementation SMRRow

- (CGSize)layoutThatFitSize:(CGSize)fitSize {
    CGSize size = CGSizeZero;
    for (SMRLayout *layout in _children) {
        size = CGSizeMaxSize(size, [layout layoutThatFitSize:fitSize]);
    }
    return size;
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds {
    CGRect limit = CGRectInPadding(fitBounds, _padding);
    NSMutableArray<NSValue *> *fixSizes = [NSMutableArray array];
    NSInteger expendCount = 0;
    CGFloat expendWidth = 0;
    CGFloat fixChildWidth = 0;
    for (int idx = 0; idx < _children.count; idx++) {
        SMRLayout *child = _children[idx];
        CGSize csize = [child layoutThatFitSize:limit.size];
        [fixSizes addObject:[NSValue valueWithCGSize:csize]];
        if (csize.width) {
            fixChildWidth += csize.width;
        } else {//if ([child isKindOfClass:SMRExpand.class]) {
            expendCount ++;
        }
        if (limit.size.width && (fixChildWidth > limit.size.width)) {
            NSLog(@"warning:%@超出父布局限定宽:%@, in:%@", child, @(limit.size.width), self);
        }
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
        CGFloat offsetY = limit.origin.y + SMRCrossAlignOffset(useSize.height, limit.size.height, _crossAlign);
        CGRect frame = {{offsetX, offsetY}, useSize};
        offsetX += frame.size.width;
        fixdWidth += frame.size.width;
        [preframes addObject:[NSValue valueWithCGRect:frame]];
    }
    CGFloat fixdOffsetX = SMRMainAlignOffset(fixdWidth, limit.size.width, _mainAlign);
    for (int idx = 0; idx < _children.count; idx++) {
        SMRLayout *child = _children[idx];
        CGRect frame = CGRectOffset(preframes[idx].CGRectValue, fixdOffsetX, 0);
        [child layoutThatFitBounds:frame];
    }
    return fitBounds;
}

@end

@implementation SMRColumn

- (CGSize)layoutThatFitSize:(CGSize)fitSize {
    CGSize size = CGSizeZero;
    for (SMRLayout *layout in _children) {
        size = CGSizeMaxSize(size, [layout layoutThatFitSize:size]);
    }
    return size;
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds {
    CGRect limit = CGRectInPadding(fitBounds, _padding);
    NSMutableArray<NSValue *> *fixSizes = [NSMutableArray array];
    NSInteger expendCount = 0;
    CGFloat expendHeight = 0;
    CGFloat fixChildHeight = 0;
    for (int idx = 0; idx < _children.count; idx++) {
        SMRLayout *child = _children[idx];
        CGSize csize =  [child layoutThatFitSize:fitBounds.size];
        [fixSizes addObject:[NSValue valueWithCGSize:csize]];
        if (csize.height) {
            fixChildHeight += csize.height;
        } else {//if ([child isKindOfClass:SMRExpand.class]) {
            expendCount ++;
        }
        if (limit.size.height && (fixChildHeight > limit.size.height)) {
            NSLog(@"warning:%@超出父布局限定高:%@, in:%@", child, @(limit.size.height), self);
        }
    }
    if (expendCount) {
        expendHeight = (limit.size.height - fixChildHeight)/expendCount;
    }
    NSMutableArray<NSValue *> *preframes = [NSMutableArray array];
    CGFloat offsetY = limit.origin.y;
    CGFloat fixdHeight = 0;
    for (int idx = 0; idx < _children.count; idx++) {
        CGSize csize = fixSizes[idx].CGSizeValue;
        CGSize useSize = CGSizeNoZero(csize, CGSizeMake(limit.size.width, expendHeight));
        CGFloat offsetX = limit.origin.x + SMRCrossAlignOffset(useSize.width, limit.size.width, _crossAlign);
        CGRect frame = {{offsetX, offsetY}, useSize};
        offsetY += frame.size.height;
        fixdHeight += frame.size.height;
        [preframes addObject:[NSValue valueWithCGRect:frame]];
    }
    CGFloat fixdOffsetY = SMRMainAlignOffset(fixdHeight, limit.size.height, _mainAlign);
    for (int idx = 0; idx < _children.count; idx++) {
        SMRLayout *child = _children[idx];
        CGRect frame = CGRectOffset(preframes[idx].CGRectValue, 0, fixdOffsetY);
        [child layoutThatFitBounds:frame];
    }
    return fitBounds;
}

@end

@implementation UIView (SMRLayout)

- (SMRBox *)viewBox {
    return Box(^(SMRBox * _Nonnull set) {
        set.view = self;
    });
}

@end

@implementation NSArray (SMRLayout)

- (NSArray<SMRBox *> *)viewBoxes {
    NSMutableArray *boxes = [NSMutableArray array];
    for (UIView *view in self) {
        if ([view isKindOfClass:UIView.class]) {
            [boxes addObject:view.viewBox];
        }
    }
    return boxes;
}

@end
