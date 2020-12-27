//
//  SMRScaffod.m
//  demoforlayout
//
//  Created by Tinswin on 2020/12/26.
//

#import "SMRScaffod.h"

@implementation SMRAppBar

- (SMRLayout *)mainLayoutAfterInit {
    NSMutableArray *bars = [NSMutableArray array];
    if (self.leadings.count) {
        [bars addObject:Row(^(SMRRow * _Nonnull set) {
            set.children = self.leadings;
        })];
    }
    if (self.title) {
        [bars addObject:self.title];
    }
    if (self.actions.count) {
        NSMutableArray *acts = [self.actions mutableCopy];
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
    
    return Box(^(SMRBox * _Nonnull set) {
        set.width = [UIScreen mainScreen].bounds.size.width;
        set.height = 24 + 20 + 44;
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.children = children;
        });
    });
}

@end

@implementation SMRScaffod

- (SMRLayout *)mainLayoutAfterInit {
    NSMutableArray *children = [NSMutableArray array];
    if (self.appBar) {
        [children addObject:self.appBar];
    }
    if (self.body) {
        [children addObject:self.body];
    }
    
    return Box(^(SMRBox * _Nonnull set) {
        set.view = self.view;
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.children = children;
        });
    });
}

@end
