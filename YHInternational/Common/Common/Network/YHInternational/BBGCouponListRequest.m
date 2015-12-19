//
//  BBGCouponListRequest.m
//  Common
//
//  Created by Damon on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCouponListRequest.h"
#import "BBGCouponListResponse.h"
@implementation BBGCouponListRequest

- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:@(self.couponStatus) forKey:@"couponStatus"];
    [parameters addParameter:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    [parameters addParameter:[NSString stringWithFormat:@"%ld",(long)self.pageNumber] forKey:@"pageNumber"];
    [super buildParameters:parameters];
}

- (BOOL)needTimestamp{
    return YES;
}

- (BOOL)needAuthUser{
    return YES;
}

- (Class)responseClass{
    return [BBGCouponListResponse class];
}

@end
