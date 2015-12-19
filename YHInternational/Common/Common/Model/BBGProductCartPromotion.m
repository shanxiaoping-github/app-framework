//
//  BBGProductCartPromotion.m
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGProductCartPromotion.h"

@implementation BBGProductCartPromotion

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(_ad, @"ad")
        STRING_FOR_KEY(_toolName, @"toolName")
        FLOAT_FOR_KEY(_discount, @"discount")
    }
    return self;
}

@end
