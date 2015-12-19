//
//  BBGOrderCancelRequest.m
//  Common
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderCancelRequest.h"
#import "BBGOrderCancelResponse.h"
@implementation BBGOrderCancelRequest
- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    
    [parameters addParameter:_orderId forKey:@"orderId"];
    [parameters addParameter:_cancelReason forKey:@"cancelReason"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass{
    return [BBGOrderCancelResponse class];
}
@end
