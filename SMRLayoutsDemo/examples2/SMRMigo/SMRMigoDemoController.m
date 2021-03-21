//
//  SMRMigoDemoController.m
//  SMRLayoutsDemo
//
//  Created by Tinswin on 2021/3/20.
//

#import "SMRMigoDemoController.h"
#import "SMRMigo.h"

@interface SMRMigoDemoController ()

@end

@implementation SMRMigoDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SMRMigo *migo = [[SMRMigo alloc] init];
    [self.view addSubview:migo.child];
    
    
}

@end
