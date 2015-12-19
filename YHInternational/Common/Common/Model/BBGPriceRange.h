//
//  BBGPriceRange.h
//  Common
//  价格区间，用于搜索
//  Created by calvin on 14-8-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGPriceRange : BBGResponseDataHandler

/**
 *  商品价格区间的最小值
 */
@property (nonatomic, assign) float minPrice;
/**
 *  商品价格区间的最大值
 */
@property (nonatomic, assign) float maxPrice;

@end
