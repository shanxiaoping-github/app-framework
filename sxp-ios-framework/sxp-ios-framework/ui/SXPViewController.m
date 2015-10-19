//
//  SXPViewController.m
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/7/15.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

#import "SXPViewController.h"
#import "appliacation_attribute.h"

@interface SXPViewController (){
    UIActivityIndicatorView* activityIndicator;
}

@end

@implementation SXPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showIndicatorView{
    [self showIndicatorViewPointX:screenWidth/2 pointY:screenHeight/2];
}
-(void)showIndicatorViewPointX:(CGFloat)x pointY:(CGFloat)y{
    if(!activityIndicator){
        activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }else{
       [activityIndicator removeFromSuperview];
    }
    activityIndicator.center = CGPointMake(x,y);
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

-(void)stopIndicatorView{
    if (activityIndicator){
        [activityIndicator stopAnimating];
        [activityIndicator setHidesWhenStopped:YES];
    }
}
@end
