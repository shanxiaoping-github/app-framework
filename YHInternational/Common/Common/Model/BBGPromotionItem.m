//
//  BBGPromotionItem.m
//  Common
//
//  Created by 彭腾 on 15/6/25.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPromotionItem.h"

@implementation BBGPromotionItem

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        STRING_FOR_KEY(_name, @"name")
        STRING_FOR_KEY(_store, @"store")
        STRING_FOR_KEY(_imageUrl, @"imageUrl")
        STRING_FOR_KEY(_num, @"num")
        STRING_FOR_KEY(_productId, @"id")
        STRING_FOR_KEY(_specText, @"specText")
    }
    return self ;
}

@end
