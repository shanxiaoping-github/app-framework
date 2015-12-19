//
//  BBGLoginViewController.h
//  Components
//
//  Created by Damon on 15/4/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
@interface BBGLoginViewController : BBGViewController<BBGSessionHandler>

@property (nonatomic, copy) BBGSessionHandlerCallback callback;

@property (nonatomic, strong) NSString * loginStr;

@property (nonatomic, strong) NSString * password;

@property (nonatomic, strong) NSString * vertification;

@property (nonatomic, strong) NSString * imageUrl;

@property (nonatomic, strong) NSString * sessionId;

- (void)getCaptchaImage:(LoginBlock)finished;

- (void)qqLoginFinish:(LoginBlock)finished;

- (void)webCahtLoginFinish:(LoginBlock)finished;

- (void)sinaLoginFinish:(LoginBlock)finished;

- (void)mobileLoginFinish:(LoginBlock)finished;


@end
