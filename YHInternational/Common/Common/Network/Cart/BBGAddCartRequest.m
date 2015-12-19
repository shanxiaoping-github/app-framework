//
//  BBGAddCartRequest.m
//  Common
//
//  Created by yangjie on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAddCartRequest.h"
#import "BBGAddCartResponse.h"

@implementation BBGAddCartRequest
- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    [parameters addParameter:BBGPLATFORM forKey:@"source"];
    [parameters addParameter:_productId forKey:@"productId"];
    [parameters addParameter:[NSString stringWithFormat:@"%ld",(long)_quantity] forKey:@"quantity"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass {
    return [BBGAddCartResponse class];
}

@end