//
//  ViewController.m
//  demoforlayout
//
//  Created by Tinswin on 2020/10/24.
//

#import "ViewController.h"
#import "SMRBoxing/SMRBoxing.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blueColor];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor redColor];
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor yellowColor];
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor cyanColor];
    UIView *view5 = [[UIView alloc] init];
    view5.backgroundColor = [UIColor brownColor];
    UIView *view6 = [[UIView alloc] init];
    view6.backgroundColor = [UIColor whiteColor];
    UIView *view7 = [[UIView alloc] init];
    view7.backgroundColor = [UIColor orangeColor];
    UIView *view8 = [[UIView alloc] init];
    view8.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];
    [self.view addSubview:view5];
    [self.view addSubview:view6];
    [self.view addSubview:view7];
    [self.view addSubview:view8];
    
    SMRLayout *layout1 =
    box(^(SMRBox * _Nonnull set) {
        set.view = self.view;
        set.width = self.view.frame.size.width;
        set.height = self.view.frame.size.height;
        set.padding = UIEdgeInsetsMakeAll(10);
        set.child = box(^(SMRBox *set) {
            set.view = view1;
            set.padding = UIEdgeInsetsMakeAll(10);
            set.child = box(^(SMRBox *set) {
                set.view = view2;
                set.padding = UIEdgeInsetsMakeAll(10);
                set.child = column(^(SMRColumn *set) {
                    set.mainAlign = SMRMainAlignCenter;
                    set.crossAlign = SMRCrossAlignCenter;
                    set.children = @[
                        box(^(SMRBox *set) {
                            set.view = view5;
                            set.width = 130;
                            set.height = 80;
                        }),
                        box(^(SMRBox *set) {
                            set.width = 10;
                            set.height = 10;
                        }),
                        box(^(SMRBox *set) {
                            set.view = view6;
                            set.width = 70;
                            set.height = 80;
                        }),
                        box(^(SMRBox *set) {
                            set.view = view7;
                            set.width = 20;
                            set.height = 150;
                        }),
                        box(^(SMRBox *set) {
                            set.view = view8;
                            set.width = 30;
                            set.height = 90;
                        }),
                    ];
                });
            });
        });
    });
    
    SMRLayout *layout2 =
    box(^(SMRBox * _Nonnull set) {
        set.view = self.view;
        set.width = self.view.frame.size.width;
        set.height = self.view.frame.size.height;
        set.padding = UIEdgeInsetsMakeAll(10);
        set.child = box(^(SMRBox *set) {
            set.view = view1;
            set.padding = UIEdgeInsetsMakeAll(10);
            set.child = box(^(SMRBox *set) {
                set.view = view2;
                set.padding = UIEdgeInsetsMakeAll(10);
                set.child = row(^(SMRRow *set) {
                    set.mainAlign = SMRMainAlignCenter;
                    set.crossAlign = SMRCrossAlignCenter;
                    set.children = @[
                        box(^(SMRBox *set) {
                            set.view = view5;
                            set.width = 130;
                            set.height = 80;
                        }),
                        box(^(SMRBox *set) {
                            set.width = 10;
                            set.height = 10;
                        }),
                        box(^(SMRBox *set) {
                            set.view = view6;
                            set.width = 70;
                            set.height = 80;
                        }),
                        box(^(SMRBox *set) {
                            set.view = view7;
                            set.width = 20;
                            set.height = 150;
                        }),
                        box(^(SMRBox *set) {
                            set.view = view8;
                            set.width = 30;
                            set.height = 90;
                        }),
                    ];
                });
            });
        });
    });
    
    [layout1 setState];
    [UIView animateWithDuration:1.5 delay:1 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
        [layout2 setState];
    } completion:nil];
    
}


@end