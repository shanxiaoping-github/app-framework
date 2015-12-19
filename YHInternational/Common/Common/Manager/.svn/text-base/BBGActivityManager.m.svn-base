//
//  BBGActivityManager.m
//  Common
//
//  Created by Damon on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGActivityManager.h"
#import "BBGFirstShareRequest.h"
#import "BBGFirstShareResponse.h"
#import "BBGLaunchManager.h"
@interface BBGActivityManager()
@property (nonatomic, strong) BBGFirstShareRequest * request;

@end

@implementation BBGActivityManager
DECLARE_SINGLETON(BBGActivityManager)

- (void)firstShareData:(void (^)(BOOL successful,id response))callback {
    _request = [[BBGFirstShareRequest alloc] init];
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGFirstShareResponse *response = (BBGFirstShareResponse *)responseData;
        callback(YES,response.shareInfo) ;
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}

- (void)dealloc{
    self.request = nil;
}

- (NSString *)taskName{
    return @"红包任务";
}


- (void)launchTask:(BBGLaunchTaskFinished)finished{

}

@end
