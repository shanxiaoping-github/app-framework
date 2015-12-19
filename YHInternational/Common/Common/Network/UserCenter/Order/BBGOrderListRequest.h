//
//  BBGOrderListRequest.h
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGOrderListRequest : BBGRequest
/**
 *  1:待收货
    2:待发货
    3:待收货
    0:全部
 */
@property (nonatomic,assign) NSInteger orderType;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,assign) NSInteger pageSize;
@end
/**
 待付款订单：payStatus=0,shipStatus=0,orderStatus=”active”
 待发货订单：payStatus=1,shipStatus=0,orderStatus=”active”
 待收货订单：payStatus=1,shipStatus=1,orderStatus=”active”
 已完成订单：orderStatus=”finish”
*/