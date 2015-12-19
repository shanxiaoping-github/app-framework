//
//  BBGPriceRange.m
//  Common
//
//  Created by calvin on 14-8-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGPriceRange.h"

@implementation BBGPriceRange

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        FLOAT_FOR_KEY(self.minPrice, @"left")
        FLOAT_FOR_KEY(self.maxPrice, @"right")
    }
    return self;
}

@end
