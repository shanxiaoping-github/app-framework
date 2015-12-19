//
//  BBGCoupon.m
//  Common
//
//  Created by Damon on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCoupon.h"
#import "BBGTools.h"
@implementation BBGCoupon

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.couponCode, @"code")
        STRING_FOR_KEY(self.couponName, @"name")
        
        double startTime;
        double endTime;
        DOUBLE_FOR_KEY(startTime, @"effectStartTime")
        DOUBLE_FOR_KEY(endTime, @"effectEndTime")
        
        self.startTime = [BBGTools timeToString:startTime/1000.0 Format:@"YYYY-MM-dd"];
        self.endTime = [BBGTools timeToString:endTime/1000.0 Format:@"YYYY-MM-dd"];
        
        INTEGER_FOR_KEY(self.couponStatus, @"couponStatus")
        
        STRING_FOR_KEY(self.shopName, @"shopName")
        
        STRING_FOR_KEY(self.couponInfo, @"info")
        
        INTEGER_FOR_KEY(self.couponType, @"type")
        
        double m_amount;
        DOUBLE_FOR_KEY(m_amount, @"amount")
        self.amount = m_amount / 100.0;
        
        INTEGER_FOR_KEY(self.discount, @"discount")
        STRING_FOR_KEY(self.type, @"type")
    }
    return self;
}

@end
