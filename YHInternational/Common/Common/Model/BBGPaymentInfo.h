//
//  BBGPaymentInfo.h
//  Common
//
//  Created by elvis.peng on 15-5-18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"
#import "BBGPayOrderInfo.h"
@interface BBGPaymentInfo : BBGResponseDataHandler
/**
 *  总金额
 */
@property (nonatomic,assign)float total;
/**
 *  支付总金额
 */
@property (nonatomic,assign)float paymentTotal;
/**
 *  订单总金额
 */
@property (nonatomic,assign)float orderTotal;
/**
 *  运费总金额
 */
@property (nonatomic,assign)float transferTotal;
/**
 *  优惠金额
 */
@property (nonatomic,assign)float discountTotal;
/**
 *  订单信息
 */
@property (nonatomic,strong)NSMutableArray *tradeInfoList;

@end
