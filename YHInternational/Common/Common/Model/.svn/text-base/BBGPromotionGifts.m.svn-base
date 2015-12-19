//
//  BBGPromotionGifts.m
//  Common
//
//  Created by 彭腾 on 15/6/25.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPromotionGifts.h"
#import "BBGPromotionItem.h"

@implementation BBGPromotionGifts

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        STRING_FOR_KEY(_Id, @"id")
        STRING_FOR_KEY(_name, @"name")
        
        BBGResponseData *itemList ;
        DATA_FOR_KEY(itemList, @"items")
        
        if ([itemList count]) {
            _itemArr = [NSMutableArray arrayWithCapacity:[itemList count]] ;
            
            for (NSInteger i = 0; i < [itemList count]; i++) {
                BBGResponseData *items ;
                DATA_FOR_INDEX_DATA(items, i, itemList)
                
                BBGPromotionItem *bbgProAct = [[BBGPromotionItem alloc]initWithHandler:self responseData:items] ;
                [_itemArr addObject:bbgProAct] ;
            }
        }
    }
    return self ;
}

@end
