//
//  BBGUseCouponRequest.h
//  Common
//
//  Created by Damon on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGUseCouponRequest : BBGRequest
@property (nonatomic, strong) NSString * couponCode;

@property (nonatomic, strong) NSString * shopId;

@property (nonatomic, strong) NSString * buyType;

@property (nonatomic, strong) NSString * couponType;

@end
