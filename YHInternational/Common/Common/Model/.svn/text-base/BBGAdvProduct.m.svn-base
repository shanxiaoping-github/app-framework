//
//  BBGAdvProduct.m
//  Common
//
//  Created by Damon on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAdvProduct.h"

@implementation BBGAdvProduct
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.adImg, @"adImg")
        STRING_FOR_KEY(self.adName, @"adName")
        STRING_FOR_KEY(self.adURL, @"adUrl")
        STRING_FOR_KEY(self.charsId, @"id")
        STRING_FOR_KEY(self.charsPointType, @"pointType")

        
        
        STRING_FOR_KEY(self.barCode, @"barcode")
        STRING_FOR_KEY(self.productBN, @"productBn")
        STRING_FOR_KEY(self.productID, @"productId")
        STRING_FOR_KEY(self.type, @"type")
        
        STRING_FOR_KEY(self.searchWord, @"searchWords")
        STRING_FOR_KEY(self.isHaveNav, @"isNav")
        STRING_FOR_KEY(self.beginTime, @"beginTime")
        STRING_FOR_KEY(self.endTime, @"endTime")
        STRING_FOR_KEY(self.productId, @"productId")
        STRING_FOR_KEY(self.activityId, @"activityId")

    }
    return self;
}
@end
