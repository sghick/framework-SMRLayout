//
//  SMRScaffodDemoController.m
//  SMRLayoutsDemo
//
//  Created by Tinswin on 2021/1/3.
//

#import "SMRScaffodDemoController.h"

@interface SMRScaffodDemoController ()

@end

@implementation SMRScaffodDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label1 = [self createLabelWithTitle:@"这是一个不太长的标题" color:[UIColor blueColor]];
    UILabel *label2 = [self createLabelWithTitle:@"label2" color:[UIColor yellowColor]];
    UILabel *label3 = [self createLabelWithTitle:@"label3" color:[UIColor brownColor]];
    UILabel *label4 = [self createLabelWithTitle:@"label4" color:[UIColor purpleColor]];
    UILabel *label5 = [self createLabelWithTitle:@"label5" color:[UIColor cyanColor]];
    UILabel *label6 = [self createLabelWithTitle:@"label6" color:[UIColor redColor]];
    
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
    [self.view addSubview:label4];
    [self.view addSubview:label5];
    [self.view addSubview:label6];
    
    [label4 sizeToFit];
    NSArray *leadings = @[label1, label2];
    NSArray *actions = @[label3];
    
    SMRLayout *layout = Box(^(SMRBox * _Nonnull set) {
        set.view = self.view;
        set.padding = UIEdgeInsetsMake(47 + 44, 20, 20, 20);
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.children = @[
                Column(^(SMRColumn * _Nonnull set) {
                    set.children = @[
                        Box(^(SMRBox * _Nonnull set) {
                            set.height = StatusBarHeight();
                        }),
                        Box(^(SMRBox * _Nonnull set) {
                            set.height = 44;
                            set.child = Row(^(SMRRow * _Nonnull set) {
                                set.children = @[
                                    Box(^(SMRBox * _Nonnull set) {
                                        set.child = Row(^(SMRRow * _Nonnull set) {
                                            set.crossAlign = SMRCrossAlignCenter;
                                            set.children = leadings.viewBoxes;
                                        });
                                    }),
                                    Box(^(SMRBox * _Nonnull set) {
                                        set.align = SMRAlignCenter;
                                        set.child = label4.viewBox;
                                    }),
                                    Box(^(SMRBox * _Nonnull set) {
                                        set.child = Row(^(SMRRow * _Nonnull set) {
                                            set.mainAlign = SMRMainAlignEnd;
                                            set.crossAlign = SMRCrossAlignCenter;
                                            set.children = actions.viewBoxes.reverseObjectEnumerator.allObjects;
                                        });
                                    }),
                                ];
                            });
                        }),
                    ];
                }),
                label6.viewBox,
            ];
        });
    });
    [layout setState];
}

- (UILabel *)createLabelWithTitle:(NSString *)title color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.backgroundColor = color;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
