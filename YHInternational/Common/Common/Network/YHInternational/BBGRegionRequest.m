//
//  BBGRegionRequest.m
//  Common
//
//  Created by Damon on 15/6/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegionRequest.h"
#import "BBGRegionResponse.h"
@implementation BBGRegionRequest

- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    if (!_version) {
        [parameters addParameter:@"0" forKey:@"version"];
    }else{
        [parameters addParameter:_version forKey:@"version"];
    }
    
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGRegionResponse class];
}

@end
