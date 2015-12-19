//
//  BBGGoodsDetailImages.m
//  Common
//
//  Created by 彭腾 on 15-5-7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsDetailImages.h"

@implementation BBGGoodsDetailImages

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        STRING_FOR_KEY(_imageUrl, @"imageUrl")
        STRING_FOR_KEY(_imageKey, @"imageKey")
    }
    return self ;
}

@end
