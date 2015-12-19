//
//  BBGUseCouponRequest.m
//  Common
//
//  Created by Damon on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUseCouponRequest.h"
#import "BBGSettlementResponse.h"
@implementation BBGUseCouponRequest

- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:self.couponCode forKey:@"code"];
    [parameters addParameter:self.shopId forKey:@"shopId"];
    [parameters addParameter:self.buyType forKey:@"buyType"];
    [parameters addParameter:self.couponType forKey:@"couponType"];
    [parameters addParameter:@"ios" forKey:@"source"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser{
    return YES;
}

- (BOOL)needTimestamp{
    return YES;
}

- (Class)responseClass{
    return [BBGSettlementResponse class];
}

@end