//
//  BBGLoginRequest.h
//  Common
//
//  Created by Damon on 15/4/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGLoginRequest : BBGRequest
/*!
 *  @author Damon, 15-04-22 16:04:47
 *
 *  客户端IP
 */
@property (nonatomic, strong) NSString * clientIp;

/*!
 *  @author Damon, 15-04-22 16:04:21
 *
 *  会话ID
 */
@property (nonatomic, strong) NSString * sessionId;

/*!
 *  @author Damon, 15-04-22 16:04:55
 *
 *  第三方登录返回的openId
 */
@property (nonatomic, strong) NSString * openId;

/*!
 *  @author Damon, 15-04-22 16:04:24
 *
 *  第三方访问令牌
 */
@property (nonatomic, strong) NSString * thirdAccessToken;

/*!
 *  @author Damon, 15-04-22 17:04:11
 *
 *  登录名称
 */
@property (nonatomic, strong) NSString * loginName;

/*!
 *  @author Damon, 15-04-22 17:04:33
 *
 *  密码
 */
@property (nonatomic, strong) NSString * password;

/*!
 *  @author Damon, 15-04-22 17:04:54
 *
 *  验证码
 */
@property (nonatomic, strong) NSString * captcha;

/*!
 *  微信unionId
 */
@property (nonatomic, strong) NSString * unionId;

@property (nonatomic, assign) NSInteger type;

/**
 *  @author holyjoy, 15-06-10 15:06:19
 *
 *  手机号
 */
@property (nonatomic, strong) NSString *mobile;

/**
 *  @author holyjoy, 15-06-10 15:06:28
 *
 *  短信验证码
 */
@property (nonatomic, strong) NSString *verifyCode;

/**
 *  @author holyjoy, 15-06-10 15:06:50
 *
 *  图片验证码
 */
@property (nonatomic, strong) NSString *captchaCode;


- (id)initWithType:(BBGLoginType)type;
@end
