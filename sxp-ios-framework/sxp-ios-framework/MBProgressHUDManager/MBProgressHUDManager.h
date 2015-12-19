//
//  MBProgressHUDManager.h
//  mqsystem
//
//  Created by shanxiaoping on 15-2-1.
//  Copyright (c) 2015年 yicai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
/*加载框管理*/
@interface MBProgressHUDManager : NSObject
/*文字提示框*/
+(void)showMessage:(NSString*)message delay:(NSTimeInterval)delay view:(UIView*)uiView;
+(void)showMessage:(NSString*)message view:(UIView*)uiView;
+(MBProgressHUD*)showLoad:(NSString*)loadMessage view:(UIView*)uiView;
+(MBProgressHUD*)showLoad:(UIView*)uiView;
@end
