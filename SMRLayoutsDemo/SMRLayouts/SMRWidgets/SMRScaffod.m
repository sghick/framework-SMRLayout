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

@end

@implementation SMRScaffod

+ (instancetype)layout:(void (^)(__kindof SMRLayout * _Nonnull))setting {
    SMRScaffod *scaffod = [super layout:setting];
    NSMutableArray *children = [NSMutableArray array];
    if (scaffod.appBar) {
        [children addObject:scaffod.appBar];
    }
    if (scaffod.body) {
        [children addObject:scaffod.body];
    }
    
    scaffod.main = Box(^(SMRBox * _Nonnull set) {
        set.view = scaffod.view;
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.children = children;
        });
    });
    return scaffod;
}

@end
