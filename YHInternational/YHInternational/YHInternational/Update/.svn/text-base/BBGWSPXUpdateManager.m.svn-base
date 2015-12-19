//
//  BBGWSPXUpdateManager.m
//  YHInternational
//
//  Created by yangjie on 15/7/2.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGWSPXUpdateManager.h"
#import "BBGAlertView.h"

@implementation BBGWSPXUpdateManager

DECLARE_SINGLETON(BBGWSPXUpdateManager)

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)checkWSPXAppUpdate{
    NSMutableURLRequest *request = [self getAsyncRequest];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         if (response != nil) {
            NSDictionary *dict = [data objectFromJSONData];
            [self WSPXcheckUpdateAPP:dict];
        }
        
    }];
}

- (NSMutableURLRequest *)getAsyncRequest {
    NSString *urlStr = @"http://pms.server.matocloud.com/pms/is/app/upgrade";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *dataStr = [NSString stringWithFormat:@"sysType=%@&token=%@&app=%@&version=%@",@"1",@"e198b24b4b02f0f05d5bb647725c4c58",@"yunhouquanqiugou",APPOUTVERSION];
    
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:5.0];
    return request;
}




/**
 *  沃易玩检测更新
 *
 *  @param appUpdateInfo <#appUpdateInfo description#>
 */
- (void)WSPXcheckUpdateAPP:(NSDictionary *)appUpdateInfo{
    NSString *returnCode = [appUpdateInfo DICT_OBJ_FOR_K(@"returnCode")];
    if ([returnCode intValue] == 1) {
        NSDictionary *dict = [appUpdateInfo DICT_OBJ_FOR_K(@"content")];
        NSString *isUpdate = [dict DICT_OBJ_FOR_K(@"isUpdate")];
        
        if ([isUpdate intValue] == 1) {
            NSString *downloadUrl = [dict DICT_OBJ_FOR_K(@"downloadUrl")];
            NSString *strInstallUrl = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",downloadUrl];
            [BBGAlertView showWithTitle:@"" message:@"检测到有新版本，是否更新？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString : strInstallUrl]];
                }
            } buttonTitles:@"是", nil];
        }
    }
}

@end
