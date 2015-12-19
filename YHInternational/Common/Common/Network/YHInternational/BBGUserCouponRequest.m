//
//  BBGUserCouponRequest.m
//  Common
//
//  Created by Damon on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserCouponRequest.h"
#import "BBGUserCouponResponse.h"
@implementation BBGUserCouponRequest

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:BBGPLATFORM forKey:@"source"];
    [parameters addParameter:self.shopId forKey:@"shopId"];
    [parameters addParameter:self.buyType forKey:@"buyType"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser{
    return YES;
}

- (BOOL)needTimestamp{
    return YES;
}

- (Class)responseClass{
    return [BBGUserCouponResponse class];
}

@end
