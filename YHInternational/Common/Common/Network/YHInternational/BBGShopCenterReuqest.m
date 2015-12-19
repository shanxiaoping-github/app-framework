//
//  BBGShopCenterReuqest.m
//  Common
//
//  Created by Damon on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShopCenterReuqest.h"
#import "BBGShopCenterResponse.h"
@implementation BBGShopCenterReuqest
- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGShopCenterResponse class];
}
@end
