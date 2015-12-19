//
//  BBGPaymentInfo.m
//  Common
//
//  Created by elvis.peng on 15-5-18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPaymentInfo.h"

@implementation BBGPaymentInfo
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        FLOAT_FOR_KEY(self.total, @"total")
        FLOAT_FOR_KEY(self.paymentTotal, @"paymentTotal")
        FLOAT_FOR_KEY(self.orderTotal, @"orderTotal");
        FLOAT_FOR_KEY(self.transferTotal, @"transferTotal");
        FLOAT_FOR_KEY(self.discountTotal, @"discountTotal");
        
        BBGResponseData *tradeInfoListData;
        DATA_FOR_KEY(tradeInfoListData, @"tradeInfoList")
        
        if (tradeInfoListData && [tradeInfoListData count]>0) {
            
            self.tradeInfoList = [NSMutableArray arrayWithCapacity:[tradeInfoListData count]];
            for (int i = 0; i<[tradeInfoListData count]; i++) {
                BBGResponseData *orderInfoData;
                DATA_FOR_INDEX_DATA(orderInfoData, i, tradeInfoListData)
                BBGPayOrderInfo *payOrder = [[BBGPayOrderInfo alloc] initWithHandler:self responseData:orderInfoData];
                [self.tradeInfoList addObject:payOrder];
            }
            
        }
        
        
    }
    return self;
}
@end
