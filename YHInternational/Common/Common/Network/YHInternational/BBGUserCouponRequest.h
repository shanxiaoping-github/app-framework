//
//  BBGUserCouponRequest.h
//  Common
//
//  Created by Damon on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGUserCouponRequest : BBGRequest
/*!
 *  店铺Id
 */
@property (nonatomic, strong) NSString * shopId;
/*!
 *  购买方式
 */
@property (nonatomic, assign) NSString * buyType;
@end
