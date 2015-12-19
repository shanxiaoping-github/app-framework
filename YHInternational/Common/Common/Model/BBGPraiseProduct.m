//
//  BBGPraiseProduct.m
//  Common
//
//  Created by yangjie on 15/4/30.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPraiseProduct.h"

@implementation BBGPraiseProduct

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        FLOAT_FOR_KEY(self.price, @"price")
        STRING_FOR_KEY(self.goodsId, @"goodsId")
        STRING_FOR_KEY(self.productId, @"productId")
        STRING_FOR_KEY(self.imgUrl, @"imgUrl")
        STRING_FOR_KEY(self.productName, @"productName")
        
    }
    return self;
}

@end
