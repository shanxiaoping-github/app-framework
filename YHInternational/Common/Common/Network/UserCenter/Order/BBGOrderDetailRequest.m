//
//  BBGOrderDetailRequest.m
//  Common
//
//  Created by elvis.peng on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailRequest.h"
#import "BBGOrderDetailResponse.h"
@implementation BBGOrderDetailRequest
- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    
    [parameters addParameter:_orderId forKey:@"orderId"];
    [parameters addParameter:_shopId forKey:@"shopId"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass{
    return [BBGOrderDetailResponse class];
}
@end
