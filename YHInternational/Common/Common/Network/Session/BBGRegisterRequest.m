//
//  BBGRegisterRequest.m
//  Common
//
//  Created by Damon on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegisterRequest.h"
#import "BBGRegisterResponse.h"
@implementation BBGRegisterRequest

- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
        
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:self.captcha forKey:@"captcha"];
    [parameters addParameter:self.sessionId forKey:@"sessionId"];
    [parameters addParameter:self.password forKey:@"password"];
    [parameters addParameter:self.imageCaptcha forKey:@"imageCaptcha"];
    [parameters addParameter:self.smsCaptcha forKey:@"smsCaptcha"];
    [parameters addParameter:self.mobile forKey:@"mobile"];
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGRegisterResponse class];
}
@end
