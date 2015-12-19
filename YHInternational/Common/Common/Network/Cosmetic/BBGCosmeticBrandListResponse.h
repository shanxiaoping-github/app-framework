//
//  BBGCosmeticBrandListResponse.h
//  Common
//
//  Created by OuyangTimmy on 15/7/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"

@interface BBGCosmeticBrandListResponse : BBGResponse

/**
 *  爆款品牌数组(每个品牌下含两个推荐商品)
 */
@property (strong, nonatomic) NSArray *popularBrands;
/**
 *  推荐品牌数组(每个品牌下含推荐品牌列表)
 */
@property (strong, nonatomic) NSArray *recommendBrands;

@end
