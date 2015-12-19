//
//  BBGPayInfo.h
//  Common
//
//  Created by calvin on 14-9-1.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBGPayInfo : NSObject

/**
 *  所有订单（可能包含多个子订单）
 */
@property (nonatomic, strong) NSString *orderId;
/**
 *  支付方式ID
 */
@property (nonatomic, strong) NSString *paymentID;
/**
 *  支付数据
 */
@property (nonatomic, strong) id info;

@end
