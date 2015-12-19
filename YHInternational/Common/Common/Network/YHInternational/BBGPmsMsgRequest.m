//
//  BBGPmsMsgRequest.m
//  Common
//
//  Created by elvis.peng on 15-5-19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPmsMsgRequest.h"
#import "BBGPmsMsgResponse.h"
@implementation BBGPmsMsgRequest
- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{

    [parameters addParameter:self.atType forKey:@"atType"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser{
    return YES;
}

- (Class)responseClass{
    return [BBGPmsMsgResponse class];
}
@end