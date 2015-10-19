//
//  SXPAppDelegate.m
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/7/16.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

#import "SXPAppDelegate.h"
#import "appliacation_attribute.h"
@implementation SXPAppDelegate

-(instancetype)init{
    self = [super init];
    if (self) {
        self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;

}
/*获得代理的单例*/
+(instancetype)shareInstance{
    return (SXPAppDelegate*)[[UIApplication sharedApplication]delegate];;
}
/*跳转控制器*/
-(void)jumpUIViewController:(UIViewController *)controller{
    SXPAppDelegate* delegate =  [SXPAppDelegate shareInstance];
    delegate.window.rootViewController = controller;
}
@end
