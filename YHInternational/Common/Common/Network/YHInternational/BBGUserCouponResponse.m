//
//  BBGUserCouponResponse.m
//  Common
//
//  Created by Damon on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserCouponResponse.h"
@implementation BBGUserCouponResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        NSMutableArray * array = [NSMutableArray array];
        NSMutableArray * array1 = [NSMutableArray array];
        
        BBGResponseData * couponList ;
        DATA_FOR_KEY_DATA(couponList, @"availableItems", responseData)
        
        for (int i = 0; i < [couponList count]; i++) {
            BBGResponseData * couponItem;
            DATA_FOR_INDEX_DATA(couponItem, i, couponList)
            
            BBGCoupon * coupon = [[BBGCoupon alloc]initWithHandler:self  responseData:couponItem];
//            STRING_FOR_KEY_DATA(coupon.couponCode, @"code", couponItem)
//            STRING_FOR_KEY_DATA(coupon.couponName, @"cpnsName", couponItem)
//            STRING_FOR_KEY_DATA(coupon.type, @"type", couponItem)
            [array addObject:coupon];
        }
        
        BBGResponseData * enableList ;
        DATA_FOR_KEY_DATA(enableList, @"unableItems", responseData)
        
        for (NSInteger i = 0; i < [enableList count]; i++) {
            BBGResponseData * enableItem;
            DATA_FOR_INDEX_DATA(enableItem, i, enableList)
            
            BBGCoupon * coupon = [[BBGCoupon alloc]initWithHandler:self  responseData:enableItem];

            [array1 addObject:coupon];
        }
        
        self.couponArray = array ;
        self.enableArray = array1 ;
    }
    return self;
}

@end
