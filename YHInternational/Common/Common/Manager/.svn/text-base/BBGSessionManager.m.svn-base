//
//  BBGSessionManager.m
//  Common
//
//  Created by Damon on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSessionManager.h"
#import "BBGSession.h"
#import "BBGUserInfoRequest.h"
#import "BBGWebViewController.h"
@interface BBGSessionManager()
@end

@implementation BBGSessionManager

DECLARE_SINGLETON(BBGSessionManager)

- (BOOL)isLogin{
    return [BBGSession sharedInstance].isLogin;
}

- (void)launchTask:(BBGLaunchTaskFinished)finished{
    //判断是否登录，如果登录获取个人信息
    finished(YES);
}



- (void)doLogin:(LoginCompletion)callback{
    if (!_handler) {
        callback(NO);
        return;
    }
    
    if ([self isLogin]) {
        callback(YES);
        return;
    }
    
    if (_handler.presentingViewController) {
        return;
    }
    
    __weak UIViewController<BBGSessionHandler> *handler = _handler;
    /*!
     *  @author Damon, 15-04-23 14:04:31
     *
     *  以后可能要用到
     */
//    __weak BBGSessionManager *weakSelf= self;
    
    [_handler initialize];
    
    [_handler setCallback:^(BOOL successful) {

        
        [handler dismissViewControllerAnimated:YES completion:nil];
        if (callback) {
            callback(successful);
        }
    }];
    if ([BBGSessionManager sharedInstance].currentViewController.navigationController.viewControllers.count == 1 || [[BBGSessionManager sharedInstance].currentViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav ;
        if ([[BBGSessionManager sharedInstance].currentViewController isKindOfClass:[UINavigationController class]]) {
            nav = (UINavigationController *)[BBGSessionManager sharedInstance].currentViewController;
        }
        
        if([nav.viewControllers[0] isKindOfClass:[BBGWebViewController class]]){
            [[BBGSessionManager sharedInstance].currentViewController presentViewController:_handler animated:YES completion:^{
                
            }];
        }else{
            if ([UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController) {

                if ([[BBGSessionManager sharedInstance].currentViewController isKindOfClass:[UINavigationController class]]) {
                    UINavigationController * nav = (UINavigationController *)[BBGSessionManager sharedInstance].currentViewController;

                    [nav.viewControllers[0] presentViewController:_handler animated:YES completion:^{
                        
                    }];
                    
                }else{
                    
                    if ([BBGSession sharedInstance].isLogin) {
                        [[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController presentViewController:_handler animated:YES completion:^{
                            
                        }];

                    }else{
                        [[BBGSessionManager sharedInstance].currentViewController presentViewController:_handler animated:YES completion:^{
                            
                        }];
                    }
                    
                    
                }
                
            }else
            {
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:_handler animated:YES completion:^{
            
                }];
            }
        }
    }else{
        [[BBGSessionManager sharedInstance].currentViewController presentViewController:_handler animated:YES completion:^{
            
        }];
    }
    
    
    
}

- (void)doLogout:(LoginCompletion)callback{
    if (![BBGSession sharedInstance].isLogin) {
        return;
    }
    [[BBGSession sharedInstance] logout];
    if (callback) {
        callback(YES);
    }
}

- (NSString *)taskName{
    return @"session管理启动";
}

- (void)dealloc{
    self.handler = nil;
}

@end
