//
//  BBGGoodsSpecValue.m
//  Common
//
//  Created by 彭腾 on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsSpecValue.h"

@implementation BBGGoodsSpecValue

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        
        STRING_FOR_KEY(_text, @"text")
        STRING_FOR_KEY(_Id, @"id")
        STRING_FOR_KEY(_name, @"name")
        BOOL_FOR_KEY(_disable, @"disable")
        BOOL_FOR_KEY(_checked, @"checked")
        
        
        
    }
    return self ;
}

@end
