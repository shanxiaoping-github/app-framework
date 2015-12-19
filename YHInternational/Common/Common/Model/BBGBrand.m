//
//  BBGBrand.m
//  Common
//
//  Created by elvis.peng on 14-8-14.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGBrand.h"

@implementation BBGBrand
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.brandName, @"brandName")
        STRING_FOR_KEY(self.brandId, @"brandId")
        STRING_FOR_KEY(self.url, @"url")
        if (!self.brandName) {
            STRING_FOR_KEY(self.brandName, @"name")
            STRING_FOR_KEY(self.brandId, @"id")
        }
    }
    return self;
}
@end
