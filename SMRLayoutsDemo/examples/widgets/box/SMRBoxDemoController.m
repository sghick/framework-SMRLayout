//
//  SMRBoxDemoController.m
//  SMRLayoutsDemo
//
//  Created by Tinswin on 2021/1/2.
//

#import "SMRBoxDemoController.h"

@interface SMRBoxDemoController ()

@end

@implementation SMRBoxDemoController

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
        set.padding = UIEdgeInsetsMakeAll(20);
        set.child = Box(^(SMRBox * _Nonnull set) {
            set.view = label1;
            set.padding = UIEdgeInsetsMakeAll(20);
            set.child = Box(^(SMRBox * _Nonnull set) {
                set.view = label2;
                set.padding = UIEdgeInsetsMakeAll(20);
                set.child = Box(^(SMRBox * _Nonnull set) {
                    set.view = label3;
                    set.padding = UIEdgeInsetsMakeAll(20);
                    set.child = Box(^(SMRBox * _Nonnull set) {
                        set.view = label4;
                    });
                });
            });
        });
    });
    [layout setState];
}

- (UILabel *)createLabelWithTitle:(NSString *)title color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.backgroundColor = color;
    label.textColor = [UIColor blackColor];
    return label;
}

@end
