//
//  SMRNavigationView.h
//  SMRLayoutsDemo
//
//  Created by Tinswin on 2020/12/27.
//

#import <UIKit/UIKit.h>
#import "SMRLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMRNavigationBar : UIView<SMRViewLayout>

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) NSArray<UIView *> *leadings;
@property (strong, nonatomic) NSArray<UIView *> *actions;
@property (strong, nonatomic) UIView *titleView;

@end

@interface SMRNavigationView : SMRNavigationBar

@property (strong, nonatomic) NSString *title;

@end

NS_ASSUME_NONNULL_END
