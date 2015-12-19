//
//  BBGBeautyEffectRequest.m
//  Common
//
//  Created by 彭腾 on 15/7/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBeautyEffectRequest.h"
#import "BBGBeautyEffectResponse.h"

@implementation BBGBeautyEffectRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGBeautyEffectResponse class];
}


@end
