//
//  BBGProduct.m
//  Common
//
//  Created by calvin on 14-5-8.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGProduct.h"


@implementation BBGProduct

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        STRING_FOR_KEY(self.productID, @"productId")
        STRING_FOR_KEY(self.goodsID, @"goodsId")
        STRING_FOR_KEY(self.productImageURL, @"goodsImageUrl")
        STRING_FOR_KEY(self.productName, @"goodsName")
        STRING_FOR_KEY(self.productBN, @"bn")
        FLOAT_FOR_KEY(self.marketPrice, @"mktPrice")
        STRING_FOR_KEY(self.shopId, @"shopId")
        FLOAT_FOR_KEY(self.promotionPrice, @"umpPrice")
        FLOAT_FOR_KEY(self.salePrice, @"salePrice")
        STRING_FOR_KEY(self.shopName, @"shopName")
        STRING_FOR_KEY(self.goodsExplain, @"goodsExplain")
        STRING_FOR_KEY(self.countryFlag, @"countryFlag")
        STRING_FOR_KEY(self.produceCountry, @"produceCountry")
        INTEGER_FOR_KEY(self.commentCount, @"commentCount")
        INTEGER_FOR_KEY(self.praiseCount, @"praiseCount")
        BOOL_FOR_KEY(self.isSecKill, @"secKill")

        if (self.promotionPrice > 0) {
            self.finalPrice = self.promotionPrice;
        }else {
            self.finalPrice = self.salePrice;
        }
        //首页栏目商品的price字段为数组
        if ([self.responseData typeForKey:@"payPrice"] == ResponseDataNumber) {
            NSString * salePrice;
            STRING_FOR_KEY(salePrice, @"payPrice")
            self.salePrice = salePrice.floatValue;
        }
        
        INTEGER_FOR_KEY(self.store, @"store")
        INTEGER_FOR_KEY(self.realStore, @"realStore")
        INTEGER_FOR_KEY(self.goodsStatus, @"goodsStatus");
        BOOL_FOR_KEY(self.marketable, @"marketable")
        
    }
    return self;
}


@end
