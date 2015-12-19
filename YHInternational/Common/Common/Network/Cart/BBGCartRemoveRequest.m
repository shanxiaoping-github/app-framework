//
//  BBGCartRemoveRequest.m
//  Common
//
//  Created by yangjie on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCartRemoveRequest.h"
#import "BBGCartRemoveResponse.h"

@implementation BBGCartRemoveRequest

- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    [parameters addParameter:BBGPLATFORM forKey:@"source"];
    [parameters addParameter:_productIds forKey:@"productIds"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass {
    return [BBGCartRemoveResponse class];
}

@end