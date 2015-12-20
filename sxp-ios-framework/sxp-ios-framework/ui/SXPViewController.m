//
//  SXPViewController.m
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/7/15.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

#import "SXPViewController.h"
#import "appliacation_attribute.h"
#import "MBProgressHUDManager.h"
@interface SXPViewController (){
    UIActivityIndicatorView* activityIndicator;
    MBProgressHUD* hud;
    
}
@end
@implementation SXPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    //[self.navigationController.navigationBar setBarTintColor:[self navigationColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];      // Do any additional setup after loading the view.
}
/*菊花圆圈*/
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

/*提示message*/
-(void)showMessage:(NSString *)message{
    [MBProgressHUDManager showMessage:message view:self.view];
}
-(void)showLoadDialog:(NSString *)message{
    hud = [MBProgressHUDManager showLoad:message view:self.view];
}
-(void)stopLoadDialog{
    if (hud) {
        hud.hidden = YES;
    }
}

-(UIColor*)navigationColor{
    return [UIColor greenColor];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}
@end
