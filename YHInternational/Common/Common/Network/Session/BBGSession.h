//
//  BBGSession.h
//  Common
//
//  Created by calvin on 14-4-3.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGPassport.h"
#import "BBGCache.h"
#import "BBGMacro.h"
#import "BBGUserInfo.h"
#import "BBGUserDetailInfo.h"
#import "Common.h"

#define BBGSESSIONKEY @"BBGSESSIONKEY"
#define BBGUSERINFOKEY @"BBGUSERINFOKEY"


typedef void (^LoginBlock)(BOOL successful);
typedef void (^fastLoginBlock)(BOOL successful,id response);


@interface BBGSession : NSObject

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic,strong) BBGUserInfo * userInfo;
@property (nonatomic,strong) BBGUserDetailInfo *userDetailInfo;

@property (nonatomic,assign) BOOL loginImageCheck;

@property (nonatomic,strong) NSString * openId;

@property (nonatomic,strong) NSString * thirdAccessToken;

@property (nonatomic,strong) NSString * loginName;

@property (nonatomic,strong) NSString * password;
/*!
 *  @author Damon, 15-04-22 22:04:40
 *
 *  验证码
 */
@property (nonatomic,strong) NSString * captcha;

@property (nonatomic,strong) NSString * sessionId;


@property (nonatomic,strong) BBGResponse * response;

/**
 *  @author holyjoy, 15-06-10 15:06:16
 *
 *  手机号
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  @author holyjoy, 15-06-10 15:06:23
 *
 *  短信验证码
 */
@property (nonatomic, strong) NSString *verifyCode;
/**
 *  @author holyjoy, 15-06-10 15:06:34
 *
 *  图形验证码
 */
@property (nonatomic, strong) NSString *captchaCode;

- (void)dologin:(BBGLoginType)type finish:(LoginBlock)block controller:(UIViewController *)controller;
- (void)doFastLogin:(BBGLoginType)type finish:(fastLoginBlock)block controller:(UIViewController *)controller;

- (void)logout;

+ (BBGSession *)sharedInstance;

- (void)getUserDetailInfo:(LoginBlock)finished;

@end
