//
//  ViewController.m
//  demoforlayout
//
//  Created by Tinswin on 2020/10/24.
//

#import "ViewController.h"
#import "SMRLayouts.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UILabel *view1 = [[UILabel alloc] init];
    view1.backgroundColor = [UIColor blueColor];
    UILabel *view2 = [[UILabel alloc] init];
    view2.backgroundColor = [UIColor redColor];
    UILabel *view3 = [[UILabel alloc] init];
    view3.backgroundColor = [UIColor yellowColor];
    UILabel *view4 = [[UILabel alloc] init];
    view4.backgroundColor = [UIColor cyanColor];
    UILabel *view5 = [[UILabel alloc] init];
    view5.backgroundColor = [UIColor brownColor];
    UILabel *view6 = [[UILabel alloc] init];
    view6.backgroundColor = [UIColor whiteColor];
    UILabel *view7 = [[UILabel alloc] init];
    view7.backgroundColor = [UIColor orangeColor];
    UILabel *view8 = [[UILabel alloc] init];
    view8.backgroundColor = [UIColor blackColor];
    UILabel *view9 = [[UILabel alloc] init];
    view9.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];
    [self.view addSubview:view5];
    [self.view addSubview:view6];
    [self.view addSubview:view7];
    [self.view addSubview:view8];
    [self.view addSubview:view9];
    
    
    SMRLayout *layout =
    Scaffod(^(SMRScaffod * _Nonnull set) {
        set.view = self.view;
        set.appBar = AppBar(^(SMRAppBar * _Nonnull set) {
            set.leadings = @[
                Box(^(SMRBox * _Nonnull set) {
                    set.view = view1;
                    view1.text = @"返回";
                    [view1 sizeToFit];
                }),
                Box(^(SMRBox * _Nonnull set) {
                    set.view = view2;
                    view2.text = @"关闭";
                    [view2 sizeToFit];
                }),
            ];
            set.actions = @[
                Box(^(SMRBox * _Nonnull set) {
                    set.view = view4;
                    view4.text = @"收藏";
                    [view4 sizeToFit];
                }),
                Box(^(SMRBox * _Nonnull set) {
                    set.view = view5;
                    view5.text = @"分享";
                    [view5 sizeToFit];
                }),
            ];
            set.title = Box(^(SMRBox * _Nonnull set) {
                set.align = SMRAlignCenter;
                set.view = view3;
                view3.text = @"爱的覅i看来是";
                [view3 sizeToFit];
            });
        });
        set.body = Box(^(SMRBox * _Nonnull set) {
            set.view = view7;
        });
    });
    [layout setState];
    
    
//    Box(^(SMRBox * _Nonnull set) {
//        set.view = self.view;
//        set.child = Column(^(SMRColumn * _Nonnull set) {
//            set.children = @[
//                Box(^(SMRBox * _Nonnull set) {
//                    set.height = 24;
//                }),
//                Box(^(SMRBox * _Nonnull set) {
//                    set.height = 20;
//                }),
//                Box(^(SMRBox * _Nonnull set) {
//                    set.height = 44;
//                    set.child = Row(^(SMRRow * _Nonnull set) {
//                        set.crossAlign = SMRCrossAlignCenter;
//                        set.children = @[
//                            Row(^(SMRRow * _Nonnull set) {
//                                set.children = @[
//                                    Box(^(SMRBox * _Nonnull set) {
//                                        set.view = view1;
//                                        view1.text = @"返回";
//                                        [view1 sizeToFit];
//                                    }),
//                                    Box(^(SMRBox * _Nonnull set) {
//                                        set.view = view2;
//                                        view2.text = @"关闭";
//                                        [view2 sizeToFit];
//                                    }),
//                                ];
//                            }),
//                            Box(^(SMRBox * _Nonnull set) {
//                                set.align = SMRAlignCenter;
//                                set.view = view3;
//                                view3.text = @"爱的覅i看来是";
//                                [view3 sizeToFit];
//                            }),
//                            Row(^(SMRRow * _Nonnull set) {
//                                set.children = @[
//                                    Box(nil),
//                                    Box(^(SMRBox * _Nonnull set) {
//                                        set.view = view4;
//                                        view4.text = @"收藏";
//                                        [view4 sizeToFit];
//                                    }),
//                                    Box(^(SMRBox * _Nonnull set) {
//                                        set.view = view5;
//                                        view5.text = @"分享";
//                                        [view5 sizeToFit];
//                                    }),
//                                ];
//                            }),
//                        ];
//                    });
//                }),
//                Box(^(SMRBox * _Nonnull set) {
//                    set.view = view6;
//                }),
//            ];
//        });
//    });
//    [layout setState];
    
    
//    [box(^(SMRBox * _Nonnull set) {
//        set.view = self.view;
//        set.width = self.view.frame.size.width;
//        set.height = self.view.frame.size.height;
//        set.padding = UIEdgeInsetsMakeAll(20);
//        set.child = box(^(SMRBox * _Nonnull set) {
//            set.view = view1;
//            set.padding = UIEdgeInsetsMakeAll(10);
//            set.child = box(^(SMRBox * _Nonnull set) {
//                set.view = view2;
//                set.width = 100;
//                set.height = 100;
//            });
//        });
//    }) setState];
    
//    NSArray *arr = @[view1, view2, view3, view4, view5, view6, view7, view8, view9];
//
//    for (int i = 0; i < 9; i++) {
//        [box(^(SMRBox *set) {
//            set.view = self.view;
//            set.width = self.view.frame.size.width;
//            set.height = self.view.frame.size.height;
//            set.padding = UIEdgeInsetsMakeAll(20);
//            set.align = i;
//            set.child = box(^(SMRBox *set) {
//                UILabel *label = arr[i];
//                label.textAlignment = NSTextAlignmentCenter;
//                label.textColor = [UIColor whiteColor];
//                label.text = @(i).stringValue;
//                set.view = label;
//                set.width = 100;
//                set.height = 100;
//            });
//        }) setState];
//    }
    
//    SMRLayout *layout1 =
//    box(^(SMRBox * _Nonnull set) {
//        set.view = self.view;
//        set.width = self.view.frame.size.width;
//        set.height = self.view.frame.size.height;
//        set.padding = UIEdgeInsetsMakeAll(10);
//        set.child = box(^(SMRBox *set) {
//            set.view = view1;
//            set.padding = UIEdgeInsetsMakeAll(10);
//            set.child = box(^(SMRBox *set) {
//                set.view = view2;
//                set.padding = UIEdgeInsetsMakeAll(10);
//                set.child = column(^(SMRColumn *set) {
//                    set.mainAlign = SMRMainAlignCenter;
//                    set.crossAlign = SMRCrossAlignCenter;
//                    set.children = @[
//                        box(^(SMRBox *set) {
//                            set.view = view5;
//                            set.width = 130;
//                            set.height = 80;
//                        }),
//                        box(^(SMRBox *set) {
//                            set.width = 10;
//                            set.height = 10;
//                        }),
//                        box(^(SMRBox *set) {
//                            set.view = view6;
//                            set.width = 70;
//                            set.height = 80;
//                        }),
//                        box(^(SMRBox *set) {
//                            set.view = view7;
//                            set.width = 20;
//                            set.height = 150;
//                        }),
//                        box(^(SMRBox *set) {
//                            set.view = view8;
//                            set.width = 30;
//                            set.height = 90;
//                        }),
//                    ];
//                });
//            });
//        });
//    });
//
//    SMRLayout *layout2 =
//    box(^(SMRBox * _Nonnull set) {
//        set.view = self.view;
//        set.width = self.view.frame.size.width;
//        set.height = self.view.frame.size.height;
//        set.padding = UIEdgeInsetsMakeAll(10);
//        set.child = box(^(SMRBox *set) {
//            set.view = view1;
//            set.padding = UIEdgeInsetsMakeAll(10);
//            set.child = box(^(SMRBox *set) {
//                set.view = view2;
//                set.padding = UIEdgeInsetsMakeAll(10);
//                set.child = row(^(SMRRow *set) {
//                    set.mainAlign = SMRMainAlignCenter;
//                    set.crossAlign = SMRCrossAlignCenter;
//                    set.children = @[
//                        box(^(SMRBox *set) {
//                            set.view = view5;
//                            set.width = 130;
//                            set.height = 80;
//                        }),
//                        box(^(SMRBox *set) {
//                            set.width = 10;
//                            set.height = 10;
//                        }),
//                        box(^(SMRBox *set) {
//                            set.view = view6;
//                            set.width = 70;
//                            set.height = 80;
//                        }),
//                        box(^(SMRBox *set) {
//                            set.view = view7;
//                            set.width = 20;
//                            set.height = 150;
//                        }),
//                        box(^(SMRBox *set) {
//                            set.view = view8;
//                            set.width = 30;
//                            set.height = 90;
//                        }),
//                    ];
//                });
//            });
//        });
//    });
//
//    [layout1 setState];
//    [UIView animateWithDuration:1.5 delay:1 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
//        [layout2 setState];
//    } completion:nil];
    
}


@end
