//
//  SMRScaffod.h
//  demoforlayout
//
//  Created by Tinswin on 2020/12/26.
//

#import "SMRLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMRCombination : SMRLayout

@end

@interface SMRAppBar : SMRCombination

@property (strong, nonatomic) NSArray<SMRLayout *> *leadings;
@property (strong, nonatomic) NSArray<SMRLayout *> *actions;
@property (strong, nonatomic) SMRLayout *title;

@end

@interface SMRScaffod : SMRCombination

@property (strong, nonatomic) UIView *view;

@property (strong, nonatomic) SMRAppBar *appBar;
@property (strong, nonatomic) SMRLayout *body;

@end

UIKIT_STATIC_INLINE SMRAppBar * AppBar(void (^ _Nullable block)(SMRAppBar *set)) {
    return [SMRAppBar layout:block];
}

UIKIT_STATIC_INLINE SMRScaffod * Scaffod(void (^ _Nullable block)(SMRScaffod *set)) {
    return [SMRScaffod layout:block];
}

NS_ASSUME_NONNULL_END
