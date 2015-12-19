//
//  BBGPromotionActivities.m
//  Common
//
//  Created by 彭腾 on 15-5-7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPromotionActivities.h"
#import "BBGPromotionGifts.h"
#import "BBGPromotionInfo.h"

@implementation BBGPromotionActivities

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        STRING_FOR_KEY(_ad, @"ad")
        STRING_FOR_KEY(_gift, @"gift")
        STRING_FOR_KEY(_name, @"name")
        INTEGER_FOR_KEY(_price, @"price")
        STRING_FOR_KEY(_text, @"text")
        STRING_FOR_KEY(_type, @"type")
        STRING_FOR_KEY(_tips, @"tips")
        
        BBGResponseData *giftsList ;
        DATA_FOR_KEY(giftsList, @"gifts")
        
        
//        if ([_type isEqualToString:@"ump-goods-xsqg"]) {
//            BBGResponseData *extras;
//            DATA_FOR_KEY(extras, @"extras")
//            
//            BBGResponseData *xsqg;
//            DATA_FOR_KEY_DATA(xsqg, @"xsqg", extras)
//            
//            BBGPromotionInfo *model = [[BBGPromotionInfo alloc]initWithHandler:self responseData:xsqg];
//            _canBuyNum = model.canBuyNum;
//        }
        
        if ([giftsList count]) {
            _gifts = [NSMutableArray arrayWithCapacity:[giftsList count]] ;
            
            for (NSInteger i = 0; i < [giftsList count]; i++) {
                BBGResponseData *gifts ;
                DATA_FOR_INDEX_DATA(gifts, i, giftsList)
                
                BBGPromotionGifts *bbgProAct = [[BBGPromotionGifts alloc]initWithHandler:self responseData:gifts] ;
                [_gifts addObject:bbgProAct] ;
                
                
                BBGResponseData *extras;
                DATA_FOR_KEY(extras, @"extras")
            }
        }
    }
    return self ;
}

@end
