//
//  SMRAppBarView.m
//  SMRLayoutsDemo
//
//  Created by Tinswin on 2020/12/27.
//

#import "SMRAppBarView.h"
#import "SMRLayout.h"

@implementation SMRAppBarView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UILabel *view = [[UILabel alloc] init];
    view.backgroundColor = [UIColor yellowColor];
    view.text = @"你好啊";
    view.textAlignment = NSTextAlignmentCenter;
    [view sizeToFit];
    [self addSubview:view];
    
    UILabel *view2 = [[UILabel alloc] init];
    view2.backgroundColor = [UIColor yellowColor];
    view2.textAlignment = NSTextAlignmentCenter;
    view2.text = @"返回";
    [view2 sizeToFit];
    [self addSubview:view2];
    
    UILabel *view3 = [[UILabel alloc] init];
    view3.backgroundColor = [UIColor blueColor];
    view3.textAlignment = NSTextAlignmentCenter;
    view3.text = @"关闭";
    [view3 sizeToFit];
    [self addSubview:view3];
    
    
    UILabel *view4 = [[UILabel alloc] init];
    view4.backgroundColor = [UIColor purpleColor];
    view4.textAlignment = NSTextAlignmentCenter;
    view4.text = @"返回";
    [view4 sizeToFit];
    [self addSubview:view4];
    
    UILabel *view5 = [[UILabel alloc] init];
    view5.backgroundColor = [UIColor blueColor];
    view5.textAlignment = NSTextAlignmentCenter;
    view5.text = @"关闭";
    [view5 sizeToFit];
    [self addSubview:view5];
    
    UILabel *view6 = [[UILabel alloc] init];
    view6.backgroundColor = [UIColor yellowColor];
    view6.textAlignment = NSTextAlignmentCenter;
    view6.text = @"分享";
    [view6 sizeToFit];
    [self addSubview:view6];
    
    
    SMRLayout *layout =
    Box(^(SMRBox * _Nonnull set) {
        set.view = self;
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.children = @[
                Box(^(SMRBox * _Nonnull set) {
                    set.height = StatusBarHeight();
                }),
                Row(^(SMRRow * _Nonnull set) {
                    set.children = @[
                        Row(^(SMRRow * _Nonnull set) {
                            set.children = @[
                                view2.viewBox,
                                view3.viewBox,
                                Box(nil),
                            ];
                            
                            view3.frame = CGRectMake(0, 0, view3.frame.size.width, 0);
                        }),
                        view.viewBox,
                        Row(^(SMRRow * _Nonnull set) {
                            set.children = @[
                                Box(nil),
                                view4.viewBox,
                                view5.viewBox,
                                view6.viewBox,
                            ];
                            view4.frame = CGRectMake(0, 0, view4.frame.size.width, 0);
                            view5.frame = CGRectMake(0, 0, view5.frame.size.width, 0);
                            view6.frame = CGRectMake(0, 0, view6.frame.size.width, 0);
                        }),
                    ];
                    view.frame = CGRectMake(0, 0, view.frame.size.width, 0);
                }),
            ];
        });
    });
    [layout setState];
}

#pragma mark - Getters

@end

@implementation SMRNavigationBar


@end
