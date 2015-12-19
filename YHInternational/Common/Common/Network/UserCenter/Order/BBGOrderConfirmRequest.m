//
//  BBGOrderConfirmRequest.m
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderConfirmRequest.h"
#import "BBGOrderConfirmResponse.h"
@implementation BBGOrderConfirmRequest
- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:_orderId forKey:@"orderId"];
    [parameters addParameter:_memberId forKey:@"memberId"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass{
    return [BBGOrderConfirmResponse class];
}
@end
