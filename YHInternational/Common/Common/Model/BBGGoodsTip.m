//
//  BBGGoodsTip.m
//  Common
//
//  Created by 彭腾 on 15-5-7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsTip.h"

@implementation BBGGoodsTip

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        INTEGER_FOR_KEY(_sortId, @"sortId")
        STRING_FOR_KEY(_tipTitle, @"tipTitle")
        STRING_FOR_KEY(_titContent, @"titContent")
    }
    return self ;
}

@end
