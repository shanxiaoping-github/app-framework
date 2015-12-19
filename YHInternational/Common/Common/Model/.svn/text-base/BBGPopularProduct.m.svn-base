//
//  BBGPopularProduct.m
//  Common
//  爆款品牌下爆款商品
//  Created by OuyangTimmy on 15/7/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPopularProduct.h"

@implementation BBGPopularProduct

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.productId, @"productId")
        STRING_FOR_KEY(self.productName, @"productName")
        FLOAT_FOR_KEY(self.price, @"price")
        STRING_FOR_KEY(self.imageUrl, @"imageUrl")
        FLOAT_FOR_KEY(self.payPrice, @"payPrice")
        STRING_FOR_KEY(self.brandId, @"brandId")
        STRING_FOR_KEY(self.bn, @"bn")
        STRING_FOR_KEY(self.barCode, @"barCode")
        BOOL_FOR_KEY(self.marketable, @"marketable")
        FLOAT_FOR_KEY(self.mkPrice, @"mkPrice")
        STRING_FOR_KEY(self.activityId, @"activityId")
        STRING_FOR_KEY(self.activityStartTime, @"activityStartTime")
        STRING_FOR_KEY(self.activityEndTime, @"activityEndTime")
        STRING_FOR_KEY(self.secKillActivityId, @"secKillActivityId")
        FLOAT_FOR_KEY(self.crossedPrice, @"crossedPrice")
        FLOAT_FOR_KEY(self.unCrosedPrice, @"unCrosedPrice")
        INTEGER_FOR_KEY(self.store, @"store")
        STRING_FOR_KEY(self.activityName, @"activityName")
        INTEGER_FOR_KEY(self.productType, @"productType")
        
    }
    return self;
}

@end
