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
    UILabel *label1 = [self createLabelWithTitle:@"label1" color:[UIColor blueColor]];
    UILabel *label2 = [self createLabelWithTitle:@"label2" color:[UIColor yellowColor]];
    UILabel *label3 = [self createLabelWithTitle:@"label3" color:[UIColor brownColor]];
    UILabel *label4 = [self createLabelWithTitle:@"label4" color:[UIColor purpleColor]];
    
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
    [self.view addSubview:label4];
    
    SMRLayout *layout = Box(^(SMRBox * _Nonnull set) {
        set.view = self.view;
        set.padding = UIEdgeInsetsMake(47 + 44 + 20, 20, 20, 20);
        set.child = Column(^(SMRColumn * _Nonnull set) {
            set.children = @[
                Row(^(SMRRow * _Nonnull set) {
                    set.children = @[
                        Box(^(SMRBox * _Nonnull set) {
                            set.height = 47 + 44;
                            set.view = label1;
                        }),
                    ];
                }),
                Row(^(SMRRow * _Nonnull set) {
                    set.children = @[
                        Box(^(SMRBox * _Nonnull set) {
                            set.height = 50;
                            set.view = label2;
                        }),
                    ];
                }),
                label4.viewBox,
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
