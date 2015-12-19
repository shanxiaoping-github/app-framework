//
//  BBGSelectedAddressRequest.m
//  Common
//
//  Created by Timmy OuYang on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSelectedAddressRequest.h"
#import "BBGSelectedAddressResponse.h"

@implementation BBGSelectedAddressRequest

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
    [parameters addParameter:@"normal" forKey:@"buyType"];
    [parameters addParameter:BBGPLATFORM forKey:@"source"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {

    return YES;
}

- (Class)responseClass {

    return [BBGSelectedAddressResponse class];
}
@end
