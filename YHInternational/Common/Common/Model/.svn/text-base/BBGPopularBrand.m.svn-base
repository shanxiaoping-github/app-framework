//
//  BBGPopularBrand.m
//  Common
//
//  Created by OuyangTimmy on 15/7/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPopularBrand.h"
#import "BBGPopularProduct.h"

@implementation BBGPopularBrand

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.brandClassId, @"brandClassId")
        BBGResponseData *productsData;
        DATA_FOR_KEY(productsData, @"popularProducts")
        NSInteger productCount = productsData.count;
        NSMutableArray *productsList = [NSMutableArray array];
        for (int i = 0; i<productCount; i++) {
            BBGResponseData *productData;
            DATA_FOR_INDEX_DATA(productData, i, productsData)
            BBGPopularProduct *product = [[BBGPopularProduct alloc] initWithHandler:self responseData:productData];
            [productsList addObject:product];
        }
        self.subContentsArray = productsList;
    }
    return self;
}

@end
