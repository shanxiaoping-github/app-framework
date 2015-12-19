//
//  BBGPayTypeRequest.m
//  Common
//
//  Created by elvis.peng on 15-5-18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayTypeRequest.h"
#import "BBGPayTypeResponse.h"
@implementation BBGPayTypeRequest
- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass{
    return [BBGPayTypeResponse class];
}
@end