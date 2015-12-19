//
//  BBGUserInfoRequest.m
//  Common
//
//  Created by BubuGao on 15-4-23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserInfoRequest.h"
#import "BBGUserInfoResponse.h"
@implementation BBGUserInfoRequest
- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass {
    
    return [BBGUserInfoResponse class];
}

@end
