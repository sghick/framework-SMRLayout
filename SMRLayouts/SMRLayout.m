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
    CGSize lsize = [self sizeThatRequires];
    CGSize fsize = [self sizeThatLimitSize:lsize];
    CGRect fbounds = {0, 0, fsize};
    return [self layoutThatFitBounds:fbounds limitSize:lsize];
}

- (CGSize)sizeThatRequires {
    return CGSizeZero;
}

- (CGSize)sizeThatLimitSize:(CGSize)limitSize {
    return limitSize;
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds limitSize:(CGSize)limitSize {
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

- (CGSize)sizeThatRequires {
    return [self.main sizeThatRequires];
}

- (CGSize)sizeThatLimitSize:(CGSize)limitSize {
    return [self.main sizeThatLimitSize:limitSize];
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds limitSize:(CGSize)limitSize {
    return [self.main layoutThatFitBounds:fitBounds limitSize:limitSize];
}

@end

@implementation SMRBox

- (CGSize)sizeThatRequires {
    CGSize size = CGSizeMake(_width, _height);
    size = CGSizeNoZero(size, _view.frame.size);
    size = CGSizeNoZero(size, [_child sizeThatRequires]);
    return size;
}

- (CGSize)sizeThatLimitSize:(CGSize)limitSize {
    CGSize psize = CGSizeInPadding(limitSize, _padding);
    if (_child) {
        CGSize csize = [_child sizeThatLimitSize:psize];
        if (limitSize.width && (csize.width > limitSize.width)) {
            NSLog(@"warning:%@超出父布局限定宽:%@, in:%@", _child, @(limitSize.width), self);
        }
        if (limitSize.height && (csize.height > limitSize.height)) {
            NSLog(@"warning:%@超出父布局限定宽:%@, in:%@", _child, @(limitSize.height), self);
        }
    }
    return psize;
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds limitSize:(CGSize)limitSize {
    if (_child) {
        CGRect frame = fitBounds;
        CGPoint alignOffset = [self p_alignOffsetWithSize:fitBounds.size inSize:limitSize];
        frame = CGRectOffset(frame, alignOffset.x, alignOffset.y);
        [_child layoutThatFitBounds:frame limitSize:limitSize];
    }
    
    if (_view) {
        _view.frame = fitBounds;
        if ([_view isKindOfClass:UILabel.class]) {
            NSLog(@"label:%@", ((UILabel *)_view).text);
        } else {
            NSLog(@"view:%@", _view);
        }
    }
    return fitBounds;
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

- (CGSize)sizeThatRequires {
    CGFloat width = CGFLOAT_MAX;
    CGFloat height = 0;
    for (SMRLayout *layout in _children) {
        CGSize size = [layout sizeThatRequires];
        height = MAX(height, size.height);
    }
    return CGSizeMake(width, height);
}

- (CGSize)sizeThatFitSize:(CGSize)fitSize {
    return fitSize;
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds {
//    CGRect limit = CGRectInPadding(fitBounds, _padding);
//    NSMutableArray<NSValue *> *fixSizes = [NSMutableArray array];
//    NSInteger expendCount = 0;
//    CGFloat expendWidth = 0;
//    CGFloat fixChildWidth = 0;
//    for (int idx = 0; idx < _children.count; idx++) {
//        SMRLayout *child = _children[idx];
//        CGSize csize = [child layoutThatFitSize:limit.size];
//        [fixSizes addObject:[NSValue valueWithCGSize:csize]];
//        if (csize.width && ![child isKindOfClass:SMRExpand.class]) {
//            fixChildWidth += csize.width;
//        } else {
//            expendCount ++;
//        }
//        if (limit.size.width && (fixChildWidth > limit.size.width)) {
//            NSLog(@"warning:%@超出父布局限定宽:%@, in:%@", child, @(limit.size.width), self);
//        }
//    }
//    if (expendCount) {
//        expendWidth = (limit.size.width - fixChildWidth)/expendCount;
//    }
//    NSMutableArray<NSValue *> *preframes = [NSMutableArray array];
//    CGFloat offsetX = limit.origin.x;
//    CGFloat fixdWidth = 0;
//    for (int idx = 0; idx < _children.count; idx++) {
//        CGSize csize = fixSizes[idx].CGSizeValue;
//        CGSize useSize = CGSizeNoZero(csize, CGSizeMake(expendWidth, limit.size.height));
//        CGFloat offsetY = limit.origin.y + SMRCrossAlignOffset(useSize.height, limit.size.height, _crossAlign);
//        CGRect frame = {{offsetX, offsetY}, useSize};
//        offsetX += frame.size.width;
//        fixdWidth += frame.size.width;
//        [preframes addObject:[NSValue valueWithCGRect:frame]];
//    }
//    CGFloat fixdOffsetX = SMRMainAlignOffset(fixdWidth, limit.size.width, _mainAlign);
//    for (int idx = 0; idx < _children.count; idx++) {
//        SMRLayout *child = _children[idx];
//        CGRect frame = CGRectOffset(preframes[idx].CGRectValue, fixdOffsetX, 0);
//        [child layoutThatFitBounds:frame];
//    }
    return fitBounds;
}

@end

@implementation SMRColumn

- (CGSize)sizeThatRequires {
    CGFloat width = 0;
    CGFloat height = CGFLOAT_MAX;
    for (SMRLayout *layout in _children) {
        CGSize size = [layout sizeThatRequires];
        width = MAX(width, size.width);
    }
    return CGSizeMake(width, height);
}

- (CGSize)sizeThatFitSize:(CGSize)fitSize {
    return fitSize;
}

- (CGRect)layoutThatFitBounds:(CGRect)fitBounds {
//    CGRect limit = CGRectInPadding(fitBounds, _padding);
//    NSMutableArray<NSValue *> *fixSizes = [NSMutableArray array];
//    NSInteger expendCount = 0;
//    CGFloat expendHeight = 0;
//    CGFloat fixChildHeight = 0;
//    for (int idx = 0; idx < _children.count; idx++) {
//        SMRLayout *child = _children[idx];
//        CGSize csize =  [child layoutThatFitSize:fitBounds.size];
//        [fixSizes addObject:[NSValue valueWithCGSize:csize]];
//       if (csize.height && ![child isKindOfClass:SMRExpand.class]) {
//            fixChildHeight += csize.height;
//        } else {
//            expendCount ++;
//        }
//        if (limit.size.height && (fixChildHeight > limit.size.height)) {
//            NSLog(@"warning:%@超出父布局限定高:%@, in:%@", child, @(limit.size.height), self);
//        }
//    }
//    if (expendCount) {
//        expendHeight = (limit.size.height - fixChildHeight)/expendCount;
//    }
//    NSMutableArray<NSValue *> *preframes = [NSMutableArray array];
//    CGFloat offsetY = limit.origin.y;
//    CGFloat fixdHeight = 0;
//    for (int idx = 0; idx < _children.count; idx++) {
//        CGSize csize = fixSizes[idx].CGSizeValue;
//        CGSize useSize = CGSizeNoZero(csize, CGSizeMake(limit.size.width, expendHeight));
//        CGFloat offsetX = limit.origin.x + SMRCrossAlignOffset(useSize.width, limit.size.width, _crossAlign);
//        CGRect frame = {{offsetX, offsetY}, useSize};
//        offsetY += frame.size.height;
//        fixdHeight += frame.size.height;
//        [preframes addObject:[NSValue valueWithCGRect:frame]];
//    }
//    CGFloat fixdOffsetY = SMRMainAlignOffset(fixdHeight, limit.size.height, _mainAlign);
//    for (int idx = 0; idx < _children.count; idx++) {
//        SMRLayout *child = _children[idx];
//        CGRect frame = CGRectOffset(preframes[idx].CGRectValue, 0, fixdOffsetY);
//        [child layoutThatFitBounds:frame];
//    }
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
