//
//  BBGSettlementResponse.h
//  Common
//
//  Created by Timmy OuYang on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGSettlement.h"

@interface BBGSettlementResponse : BBGResponse

/**
 *  结算页面数据
 */
@property (nonatomic, strong) BBGSettlement *settlement;

@end
