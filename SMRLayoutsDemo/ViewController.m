//
//  ViewController.m
//  demoforlayout
//
//  Created by Tinswin on 2020/10/24.
//

#import "ViewController.h"
#import "SMRLayouts.h"
#import "SMRViews.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIButton *back = [[UIButton alloc] init];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back setTitle:@"<返回" forState:UIControlStateNormal];
    [back sizeToFit];
    
    UIButton *share = [[UIButton alloc] init];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [share setTitle:@"分享" forState:UIControlStateNormal];
    [share sizeToFit];
    
    SMRNavigationView *navigationView = [[SMRNavigationView alloc] init];
    navigationView.leadings = @[back];
    navigationView.actions = @[share];
    navigationView.title = @"你好老板这是一个超级长的标题啊咱们自己";
    
    UIView *bodyView = [[UIView alloc] init];
    bodyView.backgroundColor = [UIColor blueColor];
    
    UIView *testView = [[UIView alloc] init];
    testView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:navigationView];
    [self.view addSubview:bodyView];
    [self.view addSubview:testView];
    
    SMRLayout *layout =
    Box(^(SMRBox * _Nonnull set) {
        set.view = self.view;
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.padding = UIEdgeInsetsMakeAll(20);
            set.children = @[
                Row(^(SMRRow * _Nonnull set) {
                    set.children = @[
                        Box(^(SMRBox * _Nonnull set) {
                            set.view = bodyView;
                        }),
                        Box(^(SMRBox * _Nonnull set) {
                            set.view = testView;
                        }),
                    ];
                }),
//                Row(^(SMRRow * _Nonnull set) {
//                    set.children = @[
//                        Box(^(SMRBox * _Nonnull set) {
//                            set.width = 88;
//                            set.height = 88;
//                            set.view = navigationView;
//                        }),
//                        Box(^(SMRBox * _Nonnull set) {
//                            set.width = 88;
//                            set.height = 88;
//                            set.view = bodyView;
//                        }),
//                        Box(^(SMRBox * _Nonnull set) {
//                            set.width = 88;
//                            set.height = 88;
//                            set.view = testView;
//                        }),
//                    ];
//                }),
            ];
        });
    });
    [layout setState];
    
//    SMRLayout *layout =
//    Scaffod(^(SMRScaffod * _Nonnull set) {
//        set.view = self.view;
//        set.navigation = navigationView.viewLayout;
//        set.body = bodyView.viewBox;
//    });
//    [layout setState];
    
    
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
    
    
//    [Box(^(SMRBox * _Nonnull set) {
//        set.view = self.view;
//        set.width = self.view.frame.size.width;
//        set.height = self.view.frame.size.height;
//        set.padding = UIEdgeInsetsMakeAll(20);
//        set.child = Box(^(SMRBox * _Nonnull set) {
//            set.view = view1;
//            set.padding = UIEdgeInsetsMakeAll(10);
//            set.child = Box(^(SMRBox * _Nonnull set) {
//                set.view = view2;
//                set.width = 100;
//                set.height = 100;
//            });
//        });
//    }) setState];
    
//    NSArray *arr = @[view1, view2, view3, view4, view5, view6, view7, view8, view9];
//
//    for (int i = 0; i < 9; i++) {
//        [Box(^(SMRBox *set) {
//            set.view = self.view;
//            set.width = self.view.frame.size.width;
//            set.height = self.view.frame.size.height;
//            set.padding = UIEdgeInsetsMakeAll(20);
//            set.align = i;
//            set.child = Box(^(SMRBox *set) {
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
//    Box(^(SMRBox * _Nonnull set) {
//        set.view = self.view;
//        set.width = self.view.frame.size.width;
//        set.height = self.view.frame.size.height;
//        set.padding = UIEdgeInsetsMakeAll(10);
//        set.child = Box(^(SMRBox *set) {
//            set.view = view1;
//            set.padding = UIEdgeInsetsMakeAll(10);
//            set.child = Box(^(SMRBox *set) {
//                set.view = view2;
//                set.padding = UIEdgeInsetsMakeAll(10);
//                set.child = Column(^(SMRColumn *set) {
//                    set.mainAlign = SMRMainAlignCenter;
//                    set.crossAlign = SMRCrossAlignCenter;
//                    set.children = @[
//                        Box(^(SMRBox *set) {
//                            set.view = view5;
//                            set.width = 130;
//                            set.height = 80;
//                        }),
//                        Box(^(SMRBox *set) {
//                            set.width = 10;
//                            set.height = 10;
//                        }),
//                        Box(^(SMRBox *set) {
//                            set.view = view6;
//                            set.width = 70;
//                            set.height = 80;
//                        }),
//                        Box(^(SMRBox *set) {
//                            set.view = view7;
//                            set.width = 20;
//                            set.height = 150;
//                        }),
//                        Box(^(SMRBox *set) {
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
//    Box(^(SMRBox * _Nonnull set) {
//        set.view = self.view;
//        set.width = self.view.frame.size.width;
//        set.height = self.view.frame.size.height;
//        set.padding = UIEdgeInsetsMakeAll(10);
//        set.child = Box(^(SMRBox *set) {
//            set.view = view1;
//            set.padding = UIEdgeInsetsMakeAll(10);
//            set.child = Box(^(SMRBox *set) {
//                set.view = view2;
//                set.padding = UIEdgeInsetsMakeAll(10);
//                set.child = Row(^(SMRRow *set) {
//                    set.mainAlign = SMRMainAlignCenter;
//                    set.crossAlign = SMRCrossAlignCenter;
//                    set.children = @[
//                        Box(^(SMRBox *set) {
//                            set.view = view5;
//                            set.width = 130;
//                            set.height = 80;
//                        }),
//                        Box(^(SMRBox *set) {
//                            set.width = 10;
//                            set.height = 10;
//                        }),
//                        Box(^(SMRBox *set) {
//                            set.view = view6;
//                            set.width = 70;
//                            set.height = 80;
//                        }),
//                        Box(^(SMRBox *set) {
//                            set.view = view7;
//                            set.width = 20;
//                            set.height = 150;
//                        }),
//                        Box(^(SMRBox *set) {
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
