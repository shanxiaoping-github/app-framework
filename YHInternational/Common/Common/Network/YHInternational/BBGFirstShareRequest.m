//
//  BBGFirstShareRequest.m
//  Common
//
//  Created by 彭腾 on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFirstShareRequest.h"
#import "BBGFirstShareResponse.h"
#import "BBGConfiguration.h"

@implementation BBGFirstShareRequest

- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
        self.ecode = [BBGConfiguration sharedInstance].eCode ;
        self.ucode = [BBGConfiguration sharedInstance].uCode ;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:BBGPLATFORM forKey:@"source"] ;
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGFirstShareResponse class];
}

- (BOOL)needAuthUser {
    return YES;
}

@end
