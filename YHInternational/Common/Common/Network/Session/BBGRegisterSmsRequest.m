//
//  BBGRegisterSmsRequest.m
//  Common
//
//  Created by Damon on 15/4/28.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegisterSmsRequest.h"
#import "BBGRegisterSmsResponse.h"
@implementation BBGRegisterSmsRequest
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:self.sessionId forKey:@"sessionId"];
    [parameters addParameter:self.mobile forKey:@"mobile"];
    [parameters addParameter:self.captcha forKey:@"captcha"];
    //用来区分正常登录注册和快捷登录
    if (_isFromFastLoginCtrl) {
        [parameters addParameter:@"2" forKey:@"version"];
    }else{
        [parameters addParameter:@"1" forKey:@"version"];

    }
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGRegisterSmsResponse class];
}

@end
