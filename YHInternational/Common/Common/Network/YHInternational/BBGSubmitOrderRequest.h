//
//  BBGSubmitOrderRequest.h
//  Common
//
//  Created by Timmy OuYang on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"
#import "BBGSettlementRequest.h"

@interface BBGSubmitOrderRequest : BBGRequest

/**
 *  购买类型
 */
@property (nonatomic) BBGBuyType buyType;

@end
