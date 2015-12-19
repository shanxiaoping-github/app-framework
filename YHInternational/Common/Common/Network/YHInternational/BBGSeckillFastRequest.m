//
//  BBGSeckillFastRequest.m
//  Common
//
//  Created by 彭腾 on 15/10/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSeckillFastRequest.h"
#import "BBGSeckillFastResponse.h"
#import "BBGSession.h"

@implementation BBGSeckillFastRequest

- (id)init {
    self = [super init] ;
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self ;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    [parameters addParameter:self.activityId forKey:@"activityId"];
    [parameters addParameter:self.productId forKey:@"productId"];
    [parameters addParameter:self.addrId forKey:@"addrId"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES ;
}

- (Class)responseClass {
    return [BBGSeckillFastResponse class];
}

@end
