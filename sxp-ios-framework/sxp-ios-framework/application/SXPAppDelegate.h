//
//  SXPAppDelegate.h
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/7/16.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//
/*自定义程序代理类*/
#import <UIKit/UIKit.h>
@interface SXPAppDelegate : UIResponder<UIApplicationDelegate>
@property (strong,nonatomic)UIWindow *window;
/*获得单例*/
+(instancetype)shareInstance;
/*跳转控制器*/
-(void)jumpUIViewController:(UIViewController*)controller;

@end
