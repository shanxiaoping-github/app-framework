//
//  BBGSetDefaultAddressRequest.m
//  Common
//
//  Created by yangjie on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSetDefaultAddressRequest.h"
#import "BBGSetDefaultAddressResponse.h"

@implementation BBGSetDefaultAddressRequest

- (instancetype)init
{
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
    return [BBGSetDefaultAddressResponse class];
}

@end
