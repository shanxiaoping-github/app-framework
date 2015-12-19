//
//  BBGUserCancelRequest.m
//  Common
//
//  Created by 彭腾 on 15/6/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserCancelRequest.h"
#import "BBGSettlementResponse.h"

@implementation BBGUserCancelRequest

- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:BBGPLATFORM forKey:@"source"];
    [parameters addParameter:self.shopId forKey:@"shopId"];
    [parameters addParameter:self.buyType forKey:@"buyType"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser{
    return YES;
}

- (BOOL)needTimestamp{
    return YES;
}

- (Class)responseClass{
    return [BBGSettlementResponse class];
}

@end
