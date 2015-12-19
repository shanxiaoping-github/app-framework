//
//  BBGSimpleCartModel.m
//  Common
//
//  Created by yangjie on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSimpleCartModel.h"

@implementation BBGSimpleCartModel

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data");
        INTEGER_FOR_KEY_DATA(_totalQuantity, @"totalQuantity", data);
        INTEGER_FOR_KEY_DATA(_totalType , @"totalType", data);
        FLOAT_FOR_KEY_DATA(_totalPrice, @"totalPrice", data)
    }
    return self;
}


@end
