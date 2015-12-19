//
//  BBGBugFixManager.m
//  Common
//
//  Created by yangjie on 15/10/23.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGBugFixManager.h"
#import "BBGIndexUpdateIOSRequest.h"
#import "BBGIndexUpdateIOSResponse.h"
#import "BBGSecurityUtil.h"
#import "JPEngine.h"

@interface BBGBugFixManager ()
@property (nonatomic, strong) BBGIndexUpdateIOSRequest *request;
@property (nonatomic,copy)BBGLaunchTaskFinished finished;
@end

@implementation BBGBugFixManager
DECLARE_SINGLETON(BBGBugFixManager)

#pragma mark - BBGLaunchTask
- (void)launchTask:(BBGLaunchTaskFinished)finished{
    [self firstShareData:^(BOOL successful, id response) {
        if (successful) {
            if (finished) {
                finished(YES);
            }
        }else {
            if (finished) {
                finished(YES);
            }
        }
    }];
}

- (NSString *)taskName{
    return @"bug fix manager";
}

- (void)firstShareData:(void (^)(BOOL successful,id response))callback {
    _request = [[BBGIndexUpdateIOSRequest alloc] init];
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGIndexUpdateIOSResponse *response = (BBGIndexUpdateIOSResponse*)responseData;
        NSString *js = response.bbgScript;
        @try {
            if (![BBGTools checkStringIsBlank:js]) {
                [JPEngine startEngine];
                js = [BBGSecurityUtil rc4DecryptWithText:js theKey:@"b$bg%1%7bbg@#^&"];
                [JPEngine evaluateScript:js];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        callback(YES,nil) ;
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}


@end
