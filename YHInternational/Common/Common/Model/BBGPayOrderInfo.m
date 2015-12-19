//
//  BBGPayOrderInfo.m
//  Common
//
//  Created by elvis.peng on 15-5-18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayOrderInfo.h"

@implementation BBGPayOrderInfo
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.tradeNo, @"tradeNo")
        FLOAT_FOR_KEY(self.price, @"price")
        FLOAT_FOR_KEY(self.transfer, @"transfer");
        FLOAT_FOR_KEY(self.paymentTotal, @"paymentTotal");
        FLOAT_FOR_KEY(self.discountTotal, @"discountTotal");
        INTEGER_FOR_KEY(self.productNum, @"productNum")
        TIMESTAMP_FOR_KEY(self.createTime, @"createTime")
        INTEGER_FOR_KEY(self.cancelTimeout, @"cancelTimeOut")
    }
    return self;
}
@end
