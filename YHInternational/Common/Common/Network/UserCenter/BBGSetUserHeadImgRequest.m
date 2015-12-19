//
//  BBGSetUserHeadImgRequest.m
//  Common
//
//  Created by yangjie on 15/4/29.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSetUserHeadImgRequest.h"
#import "BBGSetUserHeadImgResponse.h"

@implementation BBGSetUserHeadImgRequest

- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:_headImg forKey:@"headImg"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass{
    return [BBGSetUserHeadImgResponse class];
}

@end
