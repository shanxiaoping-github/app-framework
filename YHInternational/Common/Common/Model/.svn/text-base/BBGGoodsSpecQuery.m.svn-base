//
//  BBGGoodsSpecQuery.m
//  Common
//
//  Created by 彭腾 on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsSpecQuery.h"
#import "BBGGoodsSpecValue.h"

@implementation BBGGoodsSpecQuery

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
            STRING_FOR_KEY(_name, @"name")
            STRING_FOR_KEY(_Id, @"id") 
            
            _values = [[NSMutableArray alloc]initWithCapacity:0];
            if (![self.responseData isNullForKey:@"values"]) {
                BBGResponseData *goodsSpecValue ;
                DATA_FOR_KEY(goodsSpecValue, @"values")
                for (NSInteger i = 0; i < [goodsSpecValue count]; i++) {
                    BBGResponseData *goodsSpec ;
                    DATA_FOR_INDEX_DATA(goodsSpec, i, goodsSpecValue) ;
                    BBGGoodsSpecValue *model = [[BBGGoodsSpecValue alloc]initWithHandler:self responseData:goodsSpec];
                    [_values addObject:model] ;
                }
            }
    }
    return self ;
}

@end
