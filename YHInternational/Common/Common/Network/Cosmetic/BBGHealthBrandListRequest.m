//
//  BBGHealthBrandListRequest.m
//  Common
//
//  Created by 刘薇 on 15/10/8.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGHealthBrandListRequest.h"
#import "BBGCosmeticBrandListResponse.h"
#import "BBGSession.h"
@implementation BBGHealthBrandListRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    
    return [BBGSession sharedInstance].isLogin;
}

- (Class)responseClass {
    
    return [BBGCosmeticBrandListResponse class];
}

@end
