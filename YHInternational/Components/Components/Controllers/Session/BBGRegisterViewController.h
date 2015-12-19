//
//  BBGRegisterViewController.h
//  Components
//
//  Created by Damon on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

typedef void (^RegisterBlock)(BOOL successful,id response);

typedef void (^BBGSessionHandlerCallback) (BOOL successful);

@interface BBGRegisterViewController : BBGViewController

@property (nonatomic, copy) BBGSessionHandlerCallback callback;

@property (nonatomic, strong) NSString * mobile;

@property (nonatomic, strong) NSString * captcha;

@property (nonatomic, strong) NSString * sessionId;

@property (nonatomic, strong) NSString * imageUrl;

@property (nonatomic, strong) NSString * password;

@property (nonatomic, strong) NSString * imageCaptcha;

- (void)registerUser:(RegisterBlock)finished;

- (void)getVertification:(RegisterBlock)finished;

- (void)getImageVertification:(RegisterBlock)finished;
@end
