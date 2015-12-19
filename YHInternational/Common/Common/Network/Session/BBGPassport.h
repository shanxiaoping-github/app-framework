//
//  BBGPassport.h
//  Common
//
//  Created by calvin on 14-4-23.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BBGPassportType) {
    BBGPassportVip,       //普通会员登录
    BBGPassportQQ,        //QQ登录
    BBGPassportMembership,//会员卡登录
};

@class BBGPassport;

@protocol BBGPassportDelegate <NSObject>

//登录成功
- (void)passportLoginSuccessful:(BBGPassport *)passport;
//登录失败
- (void)passportLoginFailed:(BBGPassport *)passport error:(NSError *)error;
//注册成功
- (void)passportRegisterSuccessful:(BBGPassport *)passport;
//注册失败
- (void)passportRegisterFailed:(BBGPassport *)passport error:(NSError *)error;
//需要图形验证码验证
- (void)passportNeedVerificationCode:(BBGPassport *)passport error:(NSError *)error;
//图形验证码成功
- (void)passportNeedVerificationCodeSuccess:(BBGPassport *)passport;
//注销成功
- (void)passportLogoutSuccessful:(BBGPassport *)passport;
//注销失败
- (void)passportLogoutFailed:(BBGPassport *)passport error:(NSError *)error;
//获取验证码成功
- (void)passportGetAuthCodeSuccessful:(BBGPassport *)passport nextAuthCodeSeconds:(NSInteger)seconds seq:(NSString *)seq;
//获取验证码失败
- (void)passportGetAuthCodeFailed:(BBGPassport *)passport error:(NSError *)error;
//短信验证成功
- (void)passportAuthSuccessful:(BBGPassport *)passport;
//短信验证失败
- (void)passportAuthFailed:(BBGPassport *)passport error:(NSError *)error;
//请求授权验证
- (void)passportRequestAuthorizationSuccessful:(BBGPassport *)passport;
//请求授权验证失败
- (void)passportRequestAuthorizationFailed:(BBGPassport *)passport error:(NSError *)error;
//注册用户信息成功
- (void)passportRegisterUserInfoSuccessful:(BBGPassport *)passport;
//注册用户信息失败
- (void)passportRegisterUserInfoFailed:(BBGPassport *)passport error:(NSError *)error;
@end

@interface BBGPassport : NSObject <NSCoding>

/*!
 * 登录帐号
 */
@property (nonatomic, strong, readonly) NSString *loginID;

/*!
 * 帐户ID
 */
@property (nonatomic, strong, readonly) NSString *memberID;
/**
 *  会员类型
 */
@property (nonatomic, assign, readonly) BBGPassportType type;
/*!
 * usertoken
 */
@property (nonatomic, strong, readonly) NSString *usertoken;

/*!
 * usersecret
 */
@property (nonatomic, strong, readonly) NSString *usersecret;

/*!
 * 是否新用户
 */
@property (nonatomic, assign, readonly) BOOL newUser;

/*!
 * delegate
 */
@property (nonatomic, weak) id<BBGPassportDelegate> delegate;
/**
 *  授权URL
 */
@property (nonatomic, strong, readonly) NSString *authURL;

//登录
- (void)doLogin;
//获取短信验证码
- (void)getAuthCode;
//短信验证
- (void)doVerify;
//注册
- (void)doRegister;
//注销
- (void)doLogout;
//注册用户信息
- (void)doRegisterUserInfo;

@end
