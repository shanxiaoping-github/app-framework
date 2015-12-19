//
//  BBGGetCommentDetailRequest.m
//  Common
//
//  Created by yangjie on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGetCommentDetailRequest.h"
#import "BBGGetCommentDetailResponse.h"

@implementation BBGGetCommentDetailRequest

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
    return [BBGGetCommentDetailResponse class];
}

@end