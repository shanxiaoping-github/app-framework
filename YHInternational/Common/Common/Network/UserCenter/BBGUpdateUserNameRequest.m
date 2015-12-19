//
//  BBGUpdateUserNameRequest.m
//  Common
//
//  Created by yangjie on 15/4/28.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUpdateUserNameRequest.h"
#import "BBGUpdateUserNameResponse.h"

@implementation BBGUpdateUserNameRequest

- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:_nickName forKey:@"nickName"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass{
    return [BBGUpdateUserNameResponse class];
}

@end
