//
//  BBGSettlementRequest.h
//  Common
//
//  Created by Timmy OuYang on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

typedef enum {
    BBGBuyTypeNormal = 2,     //普通购买
    BBGBuyTypeGroup = -1,     //团购
    BBGBuyTypeDirect = 1,     //直接购买
    BBGBytTypePre = 3,         //预售
}BBGBuyType;

@interface BBGSettlementRequest : BBGRequest

/**
 *  购买类型
 */
@property (nonatomic) BBGBuyType buyType;

@end
