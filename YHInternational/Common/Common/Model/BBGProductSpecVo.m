//
//  BBGProductSpecVo.m
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGProductSpecVo.h"

@implementation BBGProductSpecVo

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(_specId, @"specId")
        STRING_FOR_KEY(_valueId, @"valueId")
        STRING_FOR_KEY(_name, @"name")
        STRING_FOR_KEY(_value, @"value")
    }
    return self;
}

@end
