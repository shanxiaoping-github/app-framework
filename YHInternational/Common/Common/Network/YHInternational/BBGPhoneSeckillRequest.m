//
//  BBGPhoneSeckillRequest.m
//  Common
//
//  Created by 彭腾 on 15/7/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneSeckillRequest.h"
#import "BBGPhoneSeckillResponse.h"

@implementation BBGPhoneSeckillRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] forKey:@"pageIndex"];
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGPhoneSeckillResponse class];
}


@end