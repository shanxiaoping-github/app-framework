//
//  BBGConfigureRequest.m
//  Common
//
//  Created by Damon on 15/5/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGConfigureRequest.h"
@implementation BBGConfigureRequest
- (id)init{
    self = [super init];
    if (self) {
        
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:@"2" forKey:@"sourceType"];
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGConfigureResponse class];
}

- (BOOL)needAuthUser{
    return NO;
}
@end
