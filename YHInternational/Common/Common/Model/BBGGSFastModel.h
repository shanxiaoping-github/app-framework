//
//  BBGGSFastModel.h
//  Common
//
//  Created by 彭腾 on 15/10/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGGSFastModel : BBGResponseDataHandler
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *createtime;
/**
 *  订单ID
 */
@property (nonatomic, copy) NSString *orderId;

@end
