//
//  BBGRedpaperManager.m
//  Common
//
//  Created by 彭腾 on 15/8/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRedpaperManager.h"
#import "BBGFirstShareRequest.h"
#import "BBGFirstShareResponse.h"
#import "BBGShareModel.h"
#import "BBGRedPaperView.h"

@interface BBGRedpaperManager ()
@property (nonatomic, strong) BBGFirstShareRequest *shareRequest;
@property (nonatomic,copy)BBGLaunchTaskFinished finished;
@end

@implementation BBGRedpaperManager
DECLARE_SINGLETON(BBGRedpaperManager)

#pragma mark - BBGLaunchTask
- (void)launchTask:(BBGLaunchTaskFinished)finished{
    if ([BBGSession sharedInstance].isLogin) {
        [self firstShareData:^(BOOL successful, id response) {
            if (successful) {
                BBGShareModel *model = [[BBGShareModel alloc]init];
                model = response;
//            model.overTime = @"600000";
//            model.shareUrl = @"www.baidu.com";
                if (model.shareUrl!=nil) {
                    [BBGRedPaperView showWithModel:model statue:NO];
                }
                self.regionTask = YES;
                if (finished) {
                    finished(self.regionTask);
                }
            }else {
                self.regionTask = YES;
                if (finished) {
                    finished(self.regionTask);
                }
            }
        }];
    }else {
        self.regionTask = YES;
        if (finished) {
            finished(self.regionTask);
        }
    }
}

- (NSString *)taskName{
    return @"红包管理";
}

- (void)firstShareData:(void (^)(BOOL successful,id response))callback {
    _shareRequest = [[BBGFirstShareRequest alloc] init];
    [_shareRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGFirstShareResponse *response = (BBGFirstShareResponse *)responseData;
        callback(YES,response.shareInfo) ;
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}

@end
