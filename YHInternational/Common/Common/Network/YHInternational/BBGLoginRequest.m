//
//  BBGLoginRequest.m
//  Common
//
//  Created by Damon on 15/4/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLoginRequest.h"
#import "BBGLoginResponse.h"
@implementation BBGLoginRequest
- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
        
    }
    return self;
}

- (id)initWithType:(BBGLoginType)type{
    self = [super init];
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:self.thirdAccessToken forKey:@"thirdAccessToken"];
    [parameters addParameter:@"ios" forKey:@"client"];
    [parameters addParameter:self.loginName forKey:@"loginname"];
    [parameters addParameter:self.clientIp forKey:@"clientIp"];
    [parameters addParameter:self.sessionId forKey:@"sessionId"];
    [parameters addParameter:self.openId forKey:@"openId"];
    [parameters addParameter:self.captcha forKey:@"captcha"];
    [parameters addParameter:self.password forKey:@"password"];
    [parameters addParameter:self.unionId forKey:@"unionId"];
    [parameters addParameter:self.mobile forKey:@"mobile"];
    [parameters addParameter:self.captchaCode forKey:@"captchaCode"];
    [parameters addParameter:self.verifyCode forKey:@"verifyCode"];
    switch (self.type) {
        case BBGLoginTypeFastMobile:
            //接口版本（1-老版本，2-发送手机号快捷登录的短信验证码）
            [parameters addParameter:@"2" forKey:@"version"];
            break;
            
        default:
            break;
    }
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGLoginResponse class];
}

@end
