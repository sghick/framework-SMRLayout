//
//  SMRScaffod.m
//  demoforlayout
//
//  Created by Tinswin on 2020/12/26.
//

#import "SMRScaffod.h"

@implementation SMRContainer

- (SMRLayout *)mainLayoutAfterInit {
    return self.view.viewBox;
}

@end

@implementation SMRAppBar

- (SMRLayout *)mainLayoutAfterInit {
    return Box(^(SMRBox * _Nonnull set) {
        set.width = [UIScreen mainScreen].bounds.size.width;
        set.height = StatusBarHeight() + 44;
        set.view = self.view;
    });
}

@end

@implementation SMRScaffod

- (SMRLayout *)mainLayoutAfterInit {
    NSMutableArray *children = [NSMutableArray array];
    if (self.appBar.view) {
        [self.view addSubview:self.appBar.view];
        [children addObject:self.appBar];
    }
    if (self.body.view) {
        [self.view addSubview:self.body.view];
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

@implementation UIView (SMRCombination)

- (SMRContainer *)viewContainer {
    return Container(^(SMRContainer * _Nonnull set) {
        set.view = self;
    });
}

@end
