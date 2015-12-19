//
//  BBGAddPraiseRequest.m
//  Common
//
//  Created by yangjie on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAddPraiseRequest.h"
#import "BBGAddPraiseResponse.h"

@implementation BBGAddPraiseRequest
- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
//    [parameters addParameter:_goodsId forKey:@"goodsId"];
    [parameters addParameter:_productId forKey:@"productId"];

    [super buildParameters:parameters];
}


- (BOOL)needAuthUser{
    return YES;
}

- (Class)responseClass {
    
    return [BBGAddPraiseResponse class];
}

@end
