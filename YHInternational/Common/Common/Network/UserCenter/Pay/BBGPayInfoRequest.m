//
//  BBGPayInfoRequest.m
//  Common
//
//  Created by elvis.peng on 15-5-18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayInfoRequest.h"
#import "BBGPayInfoResponse.h"
@implementation BBGPayInfoRequest
- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:_orderIds forKey:@"orderIds"];
    [parameters addParameter:@(_payment) forKey:@"paymentMethod"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass{
    return [BBGPayInfoResponse class];
}
@end
