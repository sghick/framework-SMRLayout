//
//  SMRMigo.m
//  SMRLayoutsDemo
//
//  Created by Tinswin on 2021/3/20.
//

#import "SMRMigo.h"

@implementation SMRMigo

- (UIView *)child {
    if (!_child) {
        _child = [[UIView alloc] init];
    }
    return _child;
}

@end
