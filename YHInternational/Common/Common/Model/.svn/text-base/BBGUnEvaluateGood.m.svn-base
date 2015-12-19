//
//  BBGUnEvaluateGood.m
//  Common
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUnEvaluateGood.h"

@implementation BBGUnEvaluateGood

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        FLOAT_FOR_KEY(self.price, @"goodsPrice")
        STRING_FOR_KEY(self.goodsId, @"goodsId")
        STRING_FOR_KEY(self.imgUrl, @"goodsImgUrl")
        STRING_FOR_KEY(self.productName, @"goodsName")
    }
    return self;
}

@end
