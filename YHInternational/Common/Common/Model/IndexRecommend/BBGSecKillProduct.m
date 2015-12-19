
//
//  BBGRecommendProduct.m
//  Common
//
//  Created by 黄 灿 on 15/7/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSecKillProduct.h"

@implementation BBGSecKillProduct
-(id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.productId, @"productId")
        STRING_FOR_KEY(self.productName, @"productName")
        STRING_FOR_KEY(self.price, @"price")
        STRING_FOR_KEY(self.imageUrl, @"imageUrl")
        STRING_FOR_KEY(self.payPrice, @"payPrice")
        STRING_FOR_KEY(self.brandId, @"brandId")
        STRING_FOR_KEY(self.Bn, @"bn")
        
        STRING_FOR_KEY(self.barCode, @"barCode")
        STRING_FOR_KEY(self.marketable, @"marketable")
        STRING_FOR_KEY(self.mkPrice, @"mkPrice")
        STRING_FOR_KEY(self.activityId, @"activityId")
        STRING_FOR_KEY(self.activityStartTime, @"activityStartTime")
        STRING_FOR_KEY(self.activityEndTime, @"activityEndTime")
        STRING_FOR_KEY(self.secKillActivityId, @"secKillActivityId")
        
        STRING_FOR_KEY(self.crossedPrice, @"crossedPrice")
        STRING_FOR_KEY(self.unCrosedPrice, @"unCrosedPrice")
        STRING_FOR_KEY(self.store, @"store")
        STRING_FOR_KEY(self.realStore, @"realStore")
        STRING_FOR_KEY(self.activityName, @"activityName")
        STRING_FOR_KEY(self.productType, @"productType")
        
        INTEGER_FOR_KEY(self.goodsStatus, @"goodsStatus");
        BOOL_FOR_KEY(self.isSecKill, @"secKill")

    }
    return self;
}
@end