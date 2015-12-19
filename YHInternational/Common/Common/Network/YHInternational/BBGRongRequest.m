//
//  BBGRongRequest.m
//  Common
//
//  Created by Damon on 15/7/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRongRequest.h"
#import "BBGRongResponse.h"

@implementation BBGRongRequest
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:self.memberId forKey:@"memberId"];
    if (!self.userName) {
        self.userName = @"用户";
    }
    [parameters addParameter:self.userName forKey:@"userName"];
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGRongResponse class];
}

@end