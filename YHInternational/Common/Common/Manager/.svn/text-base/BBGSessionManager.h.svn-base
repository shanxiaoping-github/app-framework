//
//  BBGSessionManager.h
//  Common
//
//  Created by Damon on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBGLaunchTask.h"
#import "BBGSessionHandler.h"

typedef void (^LoginCompletion)(BOOL successful);

@interface BBGSessionManager : NSObject<BBGLaunchTask>

+(BBGSessionManager *)sharedInstance;

@property (nonatomic, weak) UIViewController * currentViewController;

@property (nonatomic, strong) UIViewController<BBGSessionHandler> * handler;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, assign) BOOL isLoginViewController;

- (void)doLogin:(LoginCompletion)callback;

- (void)doLogout:(LoginCompletion)callback;

@end
