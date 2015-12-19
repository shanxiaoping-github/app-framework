//
//  BBGGoodsSpecInfo.m
//  Common
//
//  Created by 彭腾 on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsSpecInfo.h"

@implementation BBGGoodsSpecInfo

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        
        STRING_FOR_KEY(_goodsId, @"goodsId")
        STRING_FOR_KEY(_goodsName, @"goodsName")
        STRING_FOR_KEY(_imageUrl, @"imageUrl")
        STRING_FOR_KEY(_payPrice, @"payPrice")
        STRING_FOR_KEY(_price, @"price")
        STRING_FOR_KEY(_productId, @"productId")
        STRING_FOR_KEY(_productName, @"productName")
        INTEGER_FOR_KEY(_store, @"store")
        INTEGER_FOR_KEY(_productType, @"productType")
    }
    return self ;
}

@end
