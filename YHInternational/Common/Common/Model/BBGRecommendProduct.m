//
//  BBGRecommendProduct.m
//  Common
//
//  Created by Damon on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRecommendProduct.h"

@implementation BBGRecommendProduct
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        FLOAT_FOR_KEY(self.salePrice, @"salePrice")
        FLOAT_FOR_KEY(self.finalPrice, @"payPrice")
        STRING_FOR_KEY(self.barCode, @"barcode")
        STRING_FOR_KEY(self.productImageURL, @"productImageUrl")
        STRING_FOR_KEY(self.productName, @"productName")
        STRING_FOR_KEY(self.productBN, @"productBn")
        STRING_FOR_KEY(self.productType, @"productType")
        STRING_FOR_KEY(self.crossedPrice, @"crossedPrice");
        STRING_FOR_KEY(self.unCrosedPrice, @"unCrosedPrice");
        STRING_FOR_KEY(self.imageUrl, @"imageUrl");
        INTEGER_FOR_KEY(self.store, @"store")
        STRING_FOR_KEY(self.activityId, @"activityId")

    }
    return self;
}
@end
