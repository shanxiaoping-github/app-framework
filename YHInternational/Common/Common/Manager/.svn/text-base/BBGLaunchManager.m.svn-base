//
//  BBGLaunchManager.m
//  Common
//
//  Created by Damon on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLaunchManager.h"
#import "BBGConfigureRequest.h"
#import "BBGCache.h"
#import "SDWebImageDownloader.h"
#import "BBGViewController.h"
#import "HMGLTransitionHeader.h"


#define DEFAULTTIMEINTERVAL 2.0

@interface BBGLaunchManager ()
@property (nonatomic, assign) BOOL didBeginTask;
@property (nonatomic, strong) BBGConfigureRequest * request;
@end

@implementation BBGLaunchManager

DECLARE_SINGLETON(BBGLaunchManager)

- (id)init{
    self = [super init];
    if (self) {
        _launchQueue = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginLaunchTask:) name:@"beginLaunchTask" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failedLaunchTask:) name:@"failedLaunchTask" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedLaunchTask:) name:@"finishedLaunchTask" object:nil];
    }
    return self;
}

- (void)addTask:(id<BBGLaunchTask>)task {
    if (_didBeginTask) {
        [_launchQueue removeAllObjects];
    }
    [_launchQueue addObject:task];
}

- (void)removeTask:(id<BBGLaunchTask>)task {
    [_launchQueue removeObject:task];
}

- (void)launchNextTask {
    id<BBGLaunchTask> task = [_launchQueue count] > 0  ? [_launchQueue firstObject] : nil;
    if (task) {
        __weak BBGLaunchManager *weakself = self;
        [task launchTask:^(BOOL successful) {
            if (successful) {
                [weakself removeTask:task];
                if ([weakself.launchQueue count] == 0) {
                    weakself.didBeginTask = NO;
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"finishedLaunchTask" object:nil];
                }else{
                    weakself.didBeginTask = YES;
                    [weakself launchNextTask];
                }
            }else{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"failedLaunchTask" object:task userInfo:nil];
            }
        }];
    }else{
    }
}

#pragma mark - Notification Methods
- (void)beginLaunchTask:(NSNotification *)notification
{
    
}

- (void)failedLaunchTask:(NSNotification *)notification{
    [self dismissDefaultView];
    BBGViewController *con = (BBGViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;

    if ([con isKindOfClass:[BBGViewController class]]) {
        _taskError = YES;
        [con showDefaultViewWithStampImage:[UIImage imageNamed:@"network_error"] tips:@"服务器错误，请重试" target:self actionTitle:@"重试" action:@selector(reLaunchNextTask) WithResponseResult:BBGResponseNotData];
        
        [BBGAlertView showWithTitle:@"" message:@"服务器错误，请重试" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [[BBGLoadingTips sharedInstance] showLoading:@""];
                [self launchNextTask];
            }
        } buttonTitles:@"是", nil];
    }
}

- (void)reLaunchNextTask{
    [[BBGLoadingTips sharedInstance] showLoading:@""];
    [self launchNextTask];
}

- (void)finishedLaunchTask:(NSNotification *)notification{
    float timeGap = [[NSDate new] timeIntervalSince1970] - [[BBGLaunchManager sharedInstance].date timeIntervalSince1970];
    //默认图最少显示两秒
    if (timeGap >= 2.0) {
        [self finishedLaunchTaskHideDefaultView];
    }else{
        [self performSelector:@selector(finishedLaunchTaskHideDefaultView) withObject:nil afterDelay:2.0];
    }
}


- (void)finishedLaunchTaskHideDefaultView{
    if (self.launchQueue.count == 0) {
        
        
        [self dismissDefaultView];
        [BBGLaunchManager sharedInstance].date = nil;
        
        BBGViewController *con = (BBGViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
        /**
         *  默认页dissmiss
         */
        if ([con isKindOfClass:[BBGViewController class]]) {
            if (_taskError) {
                [[BBGLoadingTips sharedInstance] hideTips];
            }
            [con dismissDefaultView];
        }
    }
}

- (void)launch{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"beginLaunchTask" object:nil];
    [_launchQueue insertObject:self atIndex:0];
    _didBeginTask = YES;
    [self launchNextTask];
}

#pragma mark - BBGLaunchTask Methods
- (void)launchTask:(BBGLaunchTaskFinished)finished {
    self.taskFinished = finished;

    [self startup];
}

-(void)startup{
    /*!
     *  启动参数请求
     */
    __weak BBGLaunchManager * weakSelf = self;
    _request = [[BBGConfigureRequest alloc] init];
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        if (!responseData.isError) {
            BBGConfigureResponse * response = (BBGConfigureResponse *)responseData;
            //下载启动图片
            if ([BBGCache queryCache:KEYLAUNCHINFO]) {
                BBGLaunchModel * model = [BBGCache queryCache:KEYLAUNCHINFO];
                if (![model.adImg isEqualToString:response.launchModel.adImg]) {
                    
                    if (!response.launchModel.adImg) {
                        /**
                         *  活动已结束
                         */
                        [BBGCache removeCacheForKey:KEYLAUNCHINFO];
                        response.launchModel.image = [UIImage imageNamed:@"LaunchImage"];
                    }else{
                        /**
                         *  活动图变更
                         */
                        SDWebImageDownloader * downloader = [SDWebImageDownloader sharedDownloader];
                        [downloader downloadImageWithURL:[NSURL URLWithString:response.launchModel.adImg] options:SDWebImageDownloaderLowPriority|SDWebImageDownloaderContinueInBackground|SDWebImageDownloaderIgnoreCachedResponse progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            
                        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                            [BBGCache removeCacheForKey:KEYLAUNCHINFO];
                            response.launchModel.image = image;
                            [BBGCache addCache:KEYLAUNCHINFO obj:response.launchModel];
                            
                        }];
                    }
                    
                    
                }
            }else{
                if (response.launchModel.adImg) {
                    SDWebImageDownloader * downloader = [SDWebImageDownloader sharedDownloader];
                    [downloader downloadImageWithURL:[NSURL URLWithString:response.launchModel.adImg] options:SDWebImageDownloaderLowPriority|SDWebImageDownloaderContinueInBackground|SDWebImageDownloaderIgnoreCachedResponse progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        
                    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                        response.launchModel.image = image;
                        [BBGCache addCache:KEYLAUNCHINFO obj:response.launchModel];
                        
                    }];
                }else{
                    response.launchModel.image = [UIImage imageNamed:@"LaunchImage"];
                }
                
                
            }
            
            weakSelf.rongToken = response.token;
            weakSelf.rongCloudId = response.rongCloudId;
            weakSelf.payBeniftSwitch = response.payBenifitSwitch;
            weakSelf.firstBenifitSwitch = response.firstBenifitSwitch;
            weakSelf.areaVersion = [NSString stringWithFormat:@"%ld",(long)response.areaVersion];
            weakSelf.openUpdateSwitch = response.openUpdateSwitch;
            weakSelf.contactURL = response.contactURL;
            weakSelf.isOpenContactURL = response.isOpenContactURL;
            weakSelf.diaperAreaURL = response.diaperAreaURL;
            weakSelf.milkPowderAreaURL = response.milkPowderAreaURL;
            weakSelf.domesticSalesURL = response.domesticSalesURL;
            weakSelf.freeSaleURL = response.freeSaleURL;
            weakSelf.genuineGuaranteeURL = response.genuineGuaranteeURL;
            weakSelf.globalDirectMiningURL = response.globalDirectMiningURL;
            weakSelf.telecomFlowURL = response.telecomFlowURL;
            weakSelf.themeName = response.themeName;
            if ([@"Root" isEqualToString:weakSelf.themeName]) {
                [BBGConfiguration sharedInstance].theme = weakSelf.themeName;
            }
            weakSelf.payActivitySwitch = response.payActivitySwitch;
            weakSelf.payActivityTitle = response.payActivityTitle;
            weakSelf.payActivityURL = response.payActivityURL;
            weakSelf.payActivityImage = response.payActivityImage;
            weakSelf.urlDoorSwitch = response.urlDoorSwitch;
            weakSelf.urlDoorTitle = response.urlDoorTitle;
            weakSelf.URL_DOOR = response.URL_DOOR;
            weakSelf.urlDoorImage = response.urlDoorImage;
            weakSelf.searchText = response.searchText;
            
            [BBGConfiguration sharedInstance].URL_DOOR = response.URL_DOOR;
            [[NSNotificationCenter defaultCenter] postNotificationName:BMMS_FINISH_NOTIFICATION object:nil];
            if (weakSelf.taskFinished) {
                weakSelf.taskFinished(YES);
            }
        }else{
            //基础数据失败
            NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
            weakSelf.rongCloudId = [NSString stringWithFormat:@"%f",date.timeIntervalSinceNow * 1000];
            weakSelf.payBeniftSwitch = NO;
            weakSelf.firstBenifitSwitch = NO;
            weakSelf.areaVersion = @"1";
            weakSelf.openUpdateSwitch = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:BMMS_FINISH_NOTIFICATION object:nil];

            if (weakSelf.taskFinished) {
                weakSelf.taskFinished(NO);
            }

        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        //基础数据失败
        NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
        weakSelf.rongCloudId = [NSString stringWithFormat:@"%f",date.timeIntervalSinceNow * 1000];
        weakSelf.payBeniftSwitch = NO;
        weakSelf.firstBenifitSwitch = NO;
        weakSelf.areaVersion = @"1";
        weakSelf.openUpdateSwitch = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:BMMS_FINISH_NOTIFICATION object:nil];

        if (weakSelf.taskFinished) {
            weakSelf.taskFinished(NO);
        }
    }];
}

- (NSString *)taskName {
    return @"启动任务";
}

- (void)dismissDefaultView{
    
    //首页放大并消失效果
    [UIView animateWithDuration:0.7 animations:^{
        [BBGLaunchManager sharedInstance].launchImageView.transform = CGAffineTransformMakeScale(2, 2);
        [BBGLaunchManager sharedInstance].launchImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [[BBGLaunchManager sharedInstance].launchImageView removeFromSuperview];
        [BBGLaunchManager sharedInstance].launchImageView = nil;
    }];
    
//    if ([BBGLaunchManager sharedInstance].launchImageView) {
//        UIView * containerView = [UIApplication sharedApplication].keyWindow;
//        
//        DoorsTransition * transition = [[DoorsTransition alloc]init];
//        
//        [[HMGLTransitionManager sharedTransitionManager]setTransition:transition];
//        [[HMGLTransitionManager sharedTransitionManager]beginTransition:containerView];
//        [BBGLaunchManager sharedInstance].mainView.frame = [BBGLaunchManager sharedInstance].launchImageView.frame;
//        [[BBGLaunchManager sharedInstance].launchImageView removeFromSuperview];
//        [BBGLaunchManager sharedInstance].launchImageView = nil;
//        
//        
//        [[HMGLTransitionManager sharedTransitionManager] commitTransition];
//    }else{
//        [UIView animateWithDuration:0.7 animations:^{
//            
//            [BBGLaunchManager sharedInstance].launchImageView.transform = CGAffineTransformMakeScale(2, 2);
//            [BBGLaunchManager sharedInstance].launchImageView.alpha = 0.0;
//            
//        } completion:^(BOOL finished) {
//            [[BBGLaunchManager sharedInstance].launchImageView removeFromSuperview];
//            [BBGLaunchManager sharedInstance].launchImageView = nil;
//        }];
//
//    }
    
    

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"beginLaunchTask" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"failedLaunchTask" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"finishedLaunchTask" object:nil];
    self.areaVersion = nil;
}
@end
