//
//  BBGOrderProduct.m
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderProduct.h"

@implementation BBGOrderProduct
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        
        STRING_FOR_KEY(self.orderId, @"orderId")
        STRING_FOR_KEY(self.itemId, @"itemId")
        STRING_FOR_KEY(self.productId, @"productId")
        STRING_FOR_KEY(self.name, @"name")
        STRING_FOR_KEY(self.goodsId, @"goodsId")
        STRING_FOR_KEY(self.bn, @"bn")
        STRING_FOR_KEY(self.name, @"name")
        
        FLOAT_FOR_KEY(self.salePrice, @"salePrice")
        FLOAT_FOR_KEY(self.bargainPrice, @"bargainPrice")
        FLOAT_FOR_KEY(self.weight, @"weight")
        
        INTEGER_FOR_KEY(self.buyNum, @"buyNum")
        INTEGER_FOR_KEY(self.sendNum, @"sendNum")
        
        FLOAT_FOR_KEY(self.payAmount, @"payAmount")
        STRING_FOR_KEY(self.itemType, @"itemType")
        STRING_FOR_KEY(self.imageUrl, @"imageUrl")
        STRING_FOR_KEY(self.specText, @"specText")
        
        STRING_FOR_KEY(self.mkPrice, @"mktPrice")
        
        FLOAT_FOR_KEY(self.unCrossedPrice, @"unCrossedPrice")
        FLOAT_FOR_KEY(self.crossedPrice, @"crossedPrice")

    }
    return self;
}
@end
