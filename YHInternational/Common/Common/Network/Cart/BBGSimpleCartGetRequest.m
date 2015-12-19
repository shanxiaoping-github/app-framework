//
//  BBGSimpleCartGetRequest.m
//  Common
//
//  Created by yangjie on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSimpleCartGetRequest.h"
#import "BBGSimpleCartGetResponse.h"

@implementation BBGSimpleCartGetRequest
- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    [parameters addParameter:BBGPLATFORM forKey:@"source"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass {
    return [BBGSimpleCartGetResponse class];
}

@end
