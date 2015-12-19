//
//  BBGGoodsDetailRequest.m
//  Common
//
//  Created by 彭腾 on 15-5-6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsDetailRequest.h"
#import "BBGGoodsDetailResponse.h"
#import "Common.h"
#import "BBGSession.h"
@implementation BBGGoodsDetailRequest

- (id)init {
    self = [super init] ;
    if (self) {
        self.method = BBGHttpMethodPost ;
    }
    return self ;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    NSMutableDictionary *shopInfo = [NSMutableDictionary dictionary] ;
    [shopInfo DICT_SET_VK(_barCode,@"barCode")] ;
    [shopInfo DICT_SET_VK(_bn,@"bn")] ;
    [shopInfo DICT_SET_VK(_city,@"city")] ;
    [shopInfo DICT_SET_VK(@(_commentPageSize),@"commentPageSize")] ;
    [shopInfo DICT_SET_VK(@(_praisePageSize),@"praisePageSize")] ;
    [shopInfo DICT_SET_VK(_productId,@"productId")] ;
    [shopInfo DICT_SET_VK(_provine,@"provine")] ;
    [shopInfo DICT_SET_VK(_shopId,@"shopId")] ;
    [shopInfo DICT_SET_VK(_township,@"township")] ;
    [shopInfo DICT_SET_VK(_goodsId,@"goodsId")] ;
    
    [parameters addParameter:shopInfo forKey:@"query"] ;
    [super buildParameters:parameters] ;
}

- (BOOL)needAuthUser {
    return [BBGSession sharedInstance].isLogin ;
}

- (Class)responseClass {
    return [BBGGoodsDetailResponse class];
}

@end
