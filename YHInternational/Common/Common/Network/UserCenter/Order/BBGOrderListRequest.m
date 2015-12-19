//
//  BBGOrderListRequest.m
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderListRequest.h"
#import "BBGOrderListResponse.h"
#import "Common.h"

@implementation BBGOrderListRequest
- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:@(_pageNo) forKey:@"pageNo"];
    [parameters addParameter:@(_pageSize) forKey:@"pageSize"];
    [parameters addParameter:@(_orderType) forKey:@"type"];
    
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass{
    return [BBGOrderListResponse class];
}
@end
