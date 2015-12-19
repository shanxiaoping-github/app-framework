//
//  BBGCouponListResponse.m
//  Common
//
//  Created by Damon on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCouponListResponse.h"
#import "BBGTools.h"
#import "BBGCoupon.h"
@implementation BBGCouponListResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        BBGResponseData * responseCouponListData;
        
        DATA_FOR_KEY_DATA(responseCouponListData, @"data", responseData)
        
        NSMutableArray * array = [NSMutableArray array];
        for(int i = 0;i < [responseCouponListData count];i++){
            BBGResponseData * indexData;
            DATA_FOR_INDEX_DATA(indexData, i, responseCouponListData)
            BBGCoupon * coupon = [[BBGCoupon alloc] initWithHandler:self responseData:indexData];
            [array addObject:coupon];
        }
        
        INTEGER_FOR_KEY_DATA(self.count, @"count", responseData)
        
        self.couponListArray = array;
    }
    return self;
}

@end
