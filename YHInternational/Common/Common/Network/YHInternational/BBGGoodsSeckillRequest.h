//
//  BBGGoodsSeckillRequest.h
//  Common
//
//  Created by 彭腾 on 15/10/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGGoodsSeckillRequest : BBGRequest
/**
 *  秒杀活动ID
 */
@property (nonatomic, copy) NSString *activityId;
/**
 *  货品ID
 */
@property (nonatomic, copy) NSString *productId;

@end
