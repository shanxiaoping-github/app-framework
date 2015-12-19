//
//  BBGSecondsKillProduct.m
//  Common
//
//  Created by 刘薇 on 15/7/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSecondsKillProduct.h"

@implementation BBGSecondsKillProduct
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        INTEGER_FOR_KEY(self.storechild, @"store")
        STRING_FOR_KEY(self.secKillActivityId,@"activityId")
        STRING_FOR_KEY(self.productID, @"productId")
        STRING_FOR_KEY(self.productName, @"productName")
        INTEGER_FOR_KEY(self.unCrosedPrice, @"unCrosedPrice")
        INTEGER_FOR_KEY(self.crossedPrice, @"crossedPrice")

        STRING_FOR_KEY(self.barCode, @"barCode")
        STRING_FOR_KEY(self.bn, @"bn")
        STRING_FOR_KEY(self.brandId, @"brandId")
        STRING_FOR_KEY(self.marketablechild, @"marketable")
        STRING_FOR_KEY(self.secKillActivityId, @"secKillActivityId")
        STRING_FOR_KEY(self.activityId, @"activityId")
        STRING_FOR_KEY(self.activityStartTime, @"activityStartTime")
        STRING_FOR_KEY(self.activityEndTime, @"activityEndTime")
        STRING_FOR_KEY(self.activityName, @"activityName")
        STRING_FOR_KEY(self.imageUrl, @"imageUrl")
        
        INTEGER_FOR_KEY(self.mkPrice, @"mkPrice")
        INTEGER_FOR_KEY(self.productType, @"productType")
        INTEGER_FOR_KEY(self.storechild, @"store")
        INTEGER_FOR_KEY(self.price, @"price")
        INTEGER_FOR_KEY(self.payPrice, @"payPrice")
        
    }
    return self;
}

@end
