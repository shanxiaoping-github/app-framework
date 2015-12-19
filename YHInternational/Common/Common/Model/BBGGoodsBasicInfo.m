//
//  BBGGoodsBasicInfo.m
//  Common
//
//  Created by 彭腾 on 15-5-7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsBasicInfo.h"

@implementation BBGGoodsBasicInfo

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        
        STRING_FOR_KEY(_goodsName, @"goodsName")
        STRING_FOR_KEY(_goodsImageUrl, @"goodsImageUrl")
        STRING_FOR_KEY(_productImageUrl, @"productImageUrl")
        STRING_FOR_KEY(_goodsId, @"goodsId")
        STRING_FOR_KEY(_productId, @"productId")
        STRING_FOR_KEY(_brief, @"brief")
        FLOAT_FOR_KEY(_price, @"price")
        FLOAT_FOR_KEY(_payPrice, @"payPrice")
        INTEGER_FOR_KEY(_storeTotalNum, @"storeTotalNum")
        STRING_FOR_KEY(_intro, @"intro")
        STRING_FOR_KEY(_address, @"address")
        BOOL_FOR_KEY(_isPraise, @"isPraise")
        STRING_FOR_KEY(_productSpecText, @"productSpecText")
        INTEGER_FOR_KEY(_productType, @"productType")
        FLOAT_FOR_KEY(_crossedPrice, @"crossedPrice")
        FLOAT_FOR_KEY(_unCrossedPrice, @"unCrossedPrice")
        STRING_FOR_KEY(_canBuyNum, @"canBuyNum")
        STRING_FOR_KEY(self.productName, @"productName")
        STRING_FOR_KEY(self.buyButtonTips, @"buyButtonTips")
        INTEGER_FOR_KEY(self.goodsStatus, @"goodsStatus")
        STRING_FOR_KEY(self.actityId, @"actityId")
        BOOL_FOR_KEY(self.seckillActity, @"seckillActity")
        
        double time;
        DOUBLE_FOR_KEY(time, @"activityEndDate")
        
        NSDate *commentDate = [NSDate dateWithTimeIntervalSince1970:time/1000.0];
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        _activityEndDate  = [df stringFromDate:commentDate];
        
        
        double time1;
        DOUBLE_FOR_KEY(time1, @"activityStartDate")
        NSDate *commentDate1 = [NSDate dateWithTimeIntervalSince1970:time1/1000.0];
        _activityStartDate = [df stringFromDate:commentDate1];
        
        double time2;
        DOUBLE_FOR_KEY(time2, @"sysDate")
        NSDate *commentDate2 = [NSDate dateWithTimeIntervalSince1970:time2/1000.0];
        _sysDate = [df stringFromDate:commentDate2];
    }
    return self ;
}

@end
