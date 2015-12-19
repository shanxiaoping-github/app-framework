//
//  BBGSessionViewController_iPhone.m
//  YHInternational
//
//  Created by Damon on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSessionViewController_iPhone.h"

#import "BBGLoginViewController_iPhone.h"


@interface BBGSessionViewController_iPhone ()

@end

@implementation BBGSessionViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)initialize{
    self.isClearNavBar = YES;
    __weak BBGSessionViewController_iPhone * weakSelf = self;
    BBGLoginViewController_iPhone * loginViewController = [[BBGLoginViewController_iPhone alloc]init];
    [loginViewController setCallback:^(BOOL successful) {
        weakSelf.callback(successful);
    }];
    
    self.viewControllers = @[loginViewController];
}


@end
