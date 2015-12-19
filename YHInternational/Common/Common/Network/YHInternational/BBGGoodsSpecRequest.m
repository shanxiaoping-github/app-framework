//
//  BBGGoodsSpecRequest.m
//  Common
//
//  Created by 彭腾 on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsSpecRequest.h"
#import "BBGGoodsSpecResponse.h"

@implementation BBGGoodsSpecRequest

- (id)init {
    self = [super init] ;
    if (self) {
        self.method = BBGHttpMethodPost ;
    }
    return self ;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    
    [parameters addParameter:_goodsId forKey:@"goodsId"] ;
    [parameters addParameter:_filterText forKey:@"filterText"] ;
    [parameters addParameter:_provine forKey:@"provine"] ;
    [parameters addParameter:_city forKey:@"city"] ;
    [parameters addParameter:_township forKey:@"township"] ;
    
    [super buildParameters:parameters] ;
    
}

- (Class)responseClass {
    return [BBGGoodsSpecResponse class];
}

@end