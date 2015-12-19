//
//  BBGOrderInfo.m
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderInfo.h"

@implementation BBGOrderInfo
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        
        STRING_FOR_KEY(self.waybillId, @"waybillId")
        STRING_FOR_KEY(self.orderId, @"orderId")
        STRING_FOR_KEY(self.shopId, @"shopId")
        STRING_FOR_KEY(self.memberId, @"memberId")
        STRING_FOR_KEY(self.shopName, @"shopName")
        STRING_FOR_KEY(self.shipStatus, @"shipStatus")
        STRING_FOR_KEY(self.payStatus, @"payStatus")
        STRING_FOR_KEY(self.orderStatus, @"orderStatus")
        STRING_FOR_KEY(self.paymentType, @"paymentType")
        STRING_FOR_KEY(self.payment, @"payment")
        STRING_FOR_KEY(self.paymentName, @"paymentName")
        STRING_FOR_KEY(self.shipping, @"shipping")
        
        STRING_FOR_KEY(self.shipArea, @"shipArea")
        STRING_FOR_KEY(self.shipName, @"shipName")
        STRING_FOR_KEY(self.shipAddr, @"shipAddr")
        STRING_FOR_KEY(self.shipZip, @"shipZip")
        STRING_FOR_KEY(self.shipTel, @"shipTel")
        STRING_FOR_KEY(self.shipTime, @"shipTime")
        STRING_FOR_KEY(self.shipMobile, @"shipMobile")
        
        FLOAT_FOR_KEY(self.weight, @"weight")
        FLOAT_FOR_KEY(self.totalSaleAmount, @"totalSaleAmount")
        FLOAT_FOR_KEY(self.totalPayAmount, @"totalPayAmount")
        FLOAT_FOR_KEY(self.totalRealPayAmount, @"totalRealPayAmount")
        FLOAT_FOR_KEY(self.totalDeductAmount, @"totalDeductAmount")
        FLOAT_FOR_KEY(self.expressFee, @"expressFee")
        FLOAT_FOR_KEY(self.productPromotionAmount, @"productPromotionAmount")
        FLOAT_FOR_KEY(self.orderPromotionAmount, @"orderPromotionAmount")
        FLOAT_FOR_KEY(self.couponAmount, @"couponAmount")
        FLOAT_FOR_KEY(self.totalProductAmount, @"totalProductAmount")
        
        BOOL_FOR_KEY(self.allowReturn, @"allowReturn")
        FLOAT_FOR_KEY(self.totalRealPrice, @"totalRealPrice")
        
        STRING_FOR_KEY(self.cancelReason, @"cancelReason")
        STRING_FOR_KEY(self.viewStatus, @"viewStatus")
        TIMESTAMP_FOR_KEY(self.orderCreateTime, @"orderCreateTime")
        
        BOOL_FOR_KEY(self.allowCancel, @"allowCancel")
        BOOL_FOR_KEY(self.isDelivery, @"isDelivery")
        BOOL_FOR_KEY(self.allowDelete, @"allowDelete")
        STRING_FOR_KEY(self.statusName, @"statusName")
        
        INTEGER_FOR_KEY(self.orderCancelTimeout, @"orderCancelTimeout")
        
        BBGResponseData *productListData;
        DATA_FOR_KEY(productListData, @"orderItemsList")
        if (productListData && [productListData count]>0) {
            self.productList = [NSMutableArray arrayWithCapacity:[productListData count]];
            for (int i = 0; i<[productListData count]; i++) {
                BBGResponseData *productData;
                DATA_FOR_INDEX_DATA(productData, i, productListData)
                BBGOrderProduct *product = [[BBGOrderProduct alloc] initWithHandler:self responseData:productData];
                [self.productList addObject:product];
            }
        }
        
        if (![responseData isNullForKey:@"orderSelfArea"]) {
            
            BBGResponseData *orderSelfData;
            DATA_FOR_KEY(orderSelfData, @"orderSelfArea")
            self.selfArea = [[BBGOrderSelfArea alloc] initWithHandler:self responseData:orderSelfData];
        }
        
        
        BBGResponseData *orderPmtListData;
        DATA_FOR_KEY(orderPmtListData, @"orderPmtList")
        if (orderPmtListData && [orderPmtListData count]>0) {
            
            self.orderPmtList = [NSMutableArray arrayWithCapacity:[orderPmtListData count]];
            for (int i = 0; i<[orderPmtListData count]; i++) {
                BBGResponseData *orderPmtData;
                DATA_FOR_INDEX_DATA(orderPmtData, i, orderPmtListData);
                BBGOrderPmt *orderPmt = [[BBGOrderPmt alloc] initWithHandler:self responseData:orderPmtData];
                if (i==0) {
                    self.pmtStr = [NSString stringWithFormat:@"%@",orderPmt.adInfo];
                }else{
                    self.pmtStr = [NSString stringWithFormat:@"%@\n%@",self.pmtStr,orderPmt.adInfo];
                }
                [self.orderPmtList addObject:orderPmt];
            }
            
        }else{
            self.pmtStr = @"";
        }
        
    }
    return self;
}
@end
