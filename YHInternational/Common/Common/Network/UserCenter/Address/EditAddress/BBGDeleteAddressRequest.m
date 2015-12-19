//
//  BBGDeleteAddressRequest.m
//  Common
//
//  Created by yangjie on 15/5/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGDeleteAddressRequest.h"
#import "BBGDeleteAddressResponse.h"

@implementation BBGDeleteAddressRequest

- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    [parameters addParameter:_addrId forKey:@"addrId"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass{
    return [BBGDeleteAddressResponse class];
}

@end
