//
//  SMRAppBarView.h
//  SMRLayoutsDemo
//
//  Created by Tinswin on 2020/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMRAppBarView : UIView

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) NSArray<UIView *> *leadings;
@property (strong, nonatomic) NSArray<UIView *> *actions;
@property (strong, nonatomic) UIView *titleView;

@end

@interface SMRNavigationBar : SMRAppBarView

@property (strong, nonatomic) NSString *title;

@end

NS_ASSUME_NONNULL_END
