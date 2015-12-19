//
//  BBGSettingViewController.m
//  Components
//
//  Created by yangjie on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettingViewController.h"

@interface BBGSettingViewController ()

@end

@implementation BBGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)requestUpgradeData:(RequestDataCallback)callBack{
    NSMutableURLRequest *request = [self getAsyncRequest];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != nil) {
            callBack(NO,nil);
        }else if (response != nil) {
            NSDictionary *dict = [data objectFromJSONData];
            callBack(YES,dict);
        }else{
            callBack(NO,nil);
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

@end
