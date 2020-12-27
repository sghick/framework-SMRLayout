//
//  SMRScaffod.h
//  demoforlayout
//
//  Created by Tinswin on 2020/12/26.
//

#import "SMRLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMRContainer : SMRCombination

@end

@interface SMRNavigation : SMRCombination

@end

@interface SMRScaffod : SMRCombination

@property (strong, nonatomic) SMRLayout *navigation;
@property (strong, nonatomic) SMRLayout *body;

@end

@interface UIView (SMRCombination)

- (SMRContainer *)viewContainer;

@end

UIKIT_STATIC_INLINE SMRContainer * Container(void (^ _Nullable block)(SMRContainer *set)) {
    return [SMRContainer layout:block];
}

UIKIT_STATIC_INLINE SMRNavigation * Navigation(void (^ _Nullable block)(SMRNavigation *set)) {
    return [SMRNavigation layout:block];
}

UIKIT_STATIC_INLINE SMRScaffod * Scaffod(void (^ _Nullable block)(SMRScaffod *set)) {
    return [SMRScaffod layout:block];
}

NS_ASSUME_NONNULL_END
