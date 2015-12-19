//
//  MBProgressHUDManager.m
//  mqsystem
//
//  Created by shanxiaoping on 15-2-1.
//  Copyright (c) 2015年 yicai. All rights reserved.
//

#import "MBProgressHUDManager.h"
#import "MBProgressHUD.h"

@implementation MBProgressHUDManager
/*文字提示框*/
+(void)showMessage:(NSString *)message delay:(NSTimeInterval)delay view:(UIView*)uiView{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:uiView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
    
}
+(void)showMessage:(NSString *)message view:(UIView*)uiView{
    [MBProgressHUDManager showMessage:message delay:1.5f view:uiView];
}
+(MBProgressHUD*)showLoad:(NSString *)loadMessage view:(UIView *)uiView{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:uiView];
    [uiView addSubview:HUD];
    HUD.labelText=loadMessage;
    HUD.dimBackground = YES;
    [HUD showWhileExecuting:nil onTarget:nil withObject:nil animated:YES isAutoHide:NO];
    return HUD;
}
+(MBProgressHUD*)showLoad:(UIView *)uiView{
    return[MBProgressHUDManager showLoad:nil view:uiView];
}
@end
