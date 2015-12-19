//
//  BBGCartNumModel.m
//  Common
//
//  Created by 彭腾 on 15/5/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCartNumModel.h"

@implementation BBGCartNumModel

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        INTEGER_FOR_KEY(_totalQuantity, @"totalQuantity")
        INTEGER_FOR_KEY(_totalType, @"totalType")
        INTEGER_FOR_KEY(_totalPrice, @"totalPrice")
    }
    return self;
}

@end
