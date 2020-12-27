//
//  SMRLayout.h
//  demoforlayout
//
//  Created by Tinswin on 2020/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SMRAlign) {
    SMRAlignTopLeft,
    SMRAlignTopCenter,
    SMRAlignTopRight,
    SMRAlignCenterLeft,
    SMRAlignCenter,
    SMRAlignCenterRight,
    SMRAlignBottomLeft,
    SMRAlignBottomCenter,
    SMRAlignBottomRight,
};

typedef NS_ENUM(NSInteger, SMRMainAlign) {
    SMRMainAlignStart,
    SMRMainAlignEnd,
    SMRMainAlignCenter,
};

typedef NS_ENUM(NSInteger, SMRCrossAlign) {
    SMRCrossAlignStart,
    SMRCrossAlignEnd,
    SMRCrossAlignCenter,
};

UIKIT_STATIC_INLINE CGFloat SMRMainAlignOffset(CGFloat x1, CGFloat x2, SMRMainAlign mainAlign) {
    switch (mainAlign) {
        case SMRMainAlignStart:
            return 0;
        case SMRMainAlignEnd:
            return (x2 - x1);
        default: break;
    }
    return (x2 - x1)/2;
}

UIKIT_STATIC_INLINE CGFloat SMRCrossAlignOffset(CGFloat x1, CGFloat x2, SMRCrossAlign crossAlign) {
    switch (crossAlign) {
        case SMRCrossAlignStart:
            return 0;
        case SMRCrossAlignEnd:
            return (x2 - x1);
        default: break;
    }
    return (x2 - x1)/2;
}

@interface SMRLayout : NSObject

@property (assign, nonatomic, readonly) BOOL dirty;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)layout:(void (^)(__kindof SMRLayout *set))setting;

- (void)setState;

- (CGSize)sizeThatFit;
- (CGRect)boundsThatFit;

- (CGSize)layoutWithinBounds:(CGRect)bounds;

@end

/** 必须继承,不能单独使用 */
@interface SMRCombination : SMRLayout

/** 子类重写返回一个代理Layout */
- (SMRLayout *)mainLayoutAfterInit;

@end

@interface SMRBox : SMRLayout

@property (strong, nonatomic) UIView *view;

@property (assign, nonatomic) SMRAlign align;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) UIEdgeInsets padding;

@property (strong, nonatomic) SMRLayout *child;

@end

@interface SMRRow : SMRLayout

@property (assign, nonatomic) SMRMainAlign mainAlign;
@property (assign, nonatomic) SMRCrossAlign crossAlign;
@property (assign, nonatomic) UIEdgeInsets padding;

@property (copy  , nonatomic) NSArray<SMRLayout *> *children;

@end

@interface SMRColumn : SMRLayout

@property (assign, nonatomic) SMRMainAlign mainAlign;
@property (assign, nonatomic) SMRCrossAlign crossAlign;
@property (assign, nonatomic) UIEdgeInsets padding;

@property (copy  , nonatomic) NSArray<SMRLayout *> *children;

@end

UIKIT_STATIC_INLINE SMRBox * Box(void (^ _Nullable block)(SMRBox *set)) {
    return [SMRBox layout:block];
}

UIKIT_STATIC_INLINE SMRRow * Row(void (^ _Nullable block)(SMRRow *set)) {
    return [SMRRow layout:block];
}

UIKIT_STATIC_INLINE SMRColumn * Column(void (^ _Nullable block)(SMRColumn *set)) {
    return [SMRColumn layout:block];
}

NS_ASSUME_NONNULL_END
