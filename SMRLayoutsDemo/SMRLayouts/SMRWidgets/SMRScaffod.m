//
//  SMRScaffod.m
//  demoforlayout
//
//  Created by Tinswin on 2020/12/26.
//

#import "SMRScaffod.h"

@interface SMRCombination ()

@property (strong, nonatomic) SMRLayout *main;

@end

@implementation SMRCombination

- (void)setState {
    [self.main setState];
}

- (CGSize)sizeThatFit {
    return [self.main sizeThatFit];
}
- (CGRect)boundsThatFit {
    return [self.main boundsThatFit];
}

- (CGSize)layoutWithinBounds:(CGRect)bounds {
    return [self.main layoutWithinBounds:bounds];
}

@end

@implementation SMRAppBar

+ (instancetype)layout:(void (^)(__kindof SMRLayout * _Nonnull))setting {
    SMRAppBar *this = [super layout:setting];
    
    NSMutableArray *bars = [NSMutableArray array];
    if (this.leadings.count) {
        [bars addObject:Row(^(SMRRow * _Nonnull set) {
            set.children = this.leadings;
        })];
    }
    if (this.title) {
        [bars addObject:this.title];
    }
    if (this.actions.count) {
        NSMutableArray *acts = [this.actions mutableCopy];
        [acts addObject:Box(nil)];
        [bars addObject:Row(^(SMRRow * _Nonnull set) {
            set.children = [acts.reverseObjectEnumerator.allObjects copy];
        })];
    }
    
    NSMutableArray *children = [NSMutableArray array];
    [children addObject:Box(^(SMRBox * _Nonnull set) {
        set.height = 24 + 20;
    })];
    [children addObject:Box(^(SMRBox * _Nonnull set) {
        set.height = 44;
        set.child = Row(^(SMRRow * _Nonnull set) {
            set.crossAlign = SMRCrossAlignCenter;
            set.children = bars;
        });
    })];
    
    this.main = Box(^(SMRBox * _Nonnull set) {
        set.width = [UIScreen mainScreen].bounds.size.width;
        set.height = 24 + 20 + 44;
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.children = children;
        });
    });
    return this;
}

@end

@implementation SMRScaffod

+ (instancetype)layout:(void (^)(__kindof SMRLayout * _Nonnull))setting {
    SMRScaffod *this = [super layout:setting];
    NSMutableArray *children = [NSMutableArray array];
    if (this.appBar) {
        [children addObject:this.appBar];
    }
    if (this.body) {
        [children addObject:this.body];
    }
    
    this.main = Box(^(SMRBox * _Nonnull set) {
        set.view = this.view;
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.children = children;
        });
    });
    return this;
}

@end
