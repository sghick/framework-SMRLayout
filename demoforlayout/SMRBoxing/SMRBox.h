//
//  SMRBox.h
//  demoforlayout
//
//  Created by Tinswin on 2020/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

struct SMRFloat {
    BOOL isAuto;
    CGFloat value;
};
typedef struct CG_BOXABLE SMRFloat SMRFloat;

struct SMROrigin {
    struct SMRFloat x;
    struct SMRFloat y;
};
typedef struct CG_BOXABLE SMROrigin SMROrigin;

struct SMRSize {
    struct SMRFloat width;
    struct SMRFloat height;
};
typedef struct CG_BOXABLE SMRSize SMRSize;

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

@interface SMRLayout : NSObject

@property (assign, nonatomic, readonly) BOOL dirty;

+ (instancetype)layout:(void (^)(__kindof SMRLayout *set))setting;

- (void)setState;

- (CGSize)sizeThatFit;
- (CGRect)boundsThatFit;

- (CGSize)layoutWithinBounds:(CGRect)bounds;

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

NS_ASSUME_NONNULL_END
