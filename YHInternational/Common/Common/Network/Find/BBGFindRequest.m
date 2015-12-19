//
//  BBGFindRequest.m
//  Common
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFindRequest.h"
#import "BBGFindResponse.h"

@implementation BBGFindRequest

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
    return NO;
}

- (Class)responseClass {
    return [BBGFindResponse class];
}


@end