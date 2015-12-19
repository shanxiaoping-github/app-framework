//
//  BBGFastMobileLoginViewController.h
//  Components
//
//  Created by Holyjoy on 15/6/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

typedef void (^FastLoginBlock)(BOOL successful,id response);

@interface BBGFastMobileLoginViewController : BBGViewController

@property (nonatomic, strong) BBGRegisterImageVertificationRequest * imageVertificationRequest;
@property (nonatomic, strong) BBGRegisterSmsRequest * smsRequest;

@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic, strong) NSString * imageUrl;


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

/**
 *  @author holyjoy, 15-06-16 15:06:23
 *
 *  快捷登陆接口
 *
 *  @param finished 完成回调
 */
- (void)fastMobileLoginFinish:(FastLoginBlock)finished;

/**
 *  @author holyjoy, 15-06-16 15:06:46
 *
 *  获取短信验证码
 *
 *  @param finished 回调
 */
- (void)getVertification:(FastLoginBlock)finished;

/**
 *  @author holyjoy, 15-06-16 15:06:02
 *
 *   获取图形验证码
 *
 *  @param finished 回调
 */
- (void)getImageVertification:(FastLoginBlock)finished;

@end
