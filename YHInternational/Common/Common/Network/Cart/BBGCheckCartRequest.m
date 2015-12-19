//
//  BBGCheckCartRequest.m
//  Common
//
//  Created by yangjie on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCheckCartRequest.h"
#import "BBGCheckCartResponse.h"

@implementation BBGCheckCartRequest

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
    return [BBGCheckCartResponse class];
}

@end
