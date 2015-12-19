//
//  BBGSearchResponse.h
//  Common
//
//  Created by calvin on 14-8-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGBrand.h"
#import "BBGSearchProduct.h"
#import "BBGPriceRange.h"
#import "BBGAttribute.h"
#import "BBGFilterAttribute.h"
#import "BBGSubAttribute.h"

@interface BBGSearchResponse : BBGResponse

/**
 *  命中的商品总数量
 */
@property (nonatomic, assign) NSInteger totalCount;
/**
 *  搜索到的所有商品，数组里为BBGSearchProduct对象
 */
@property (nonatomic, strong) NSArray *products;
/**
 *  所有筛选条件
 */
@property (nonatomic, strong) NSArray *allFilterAttributes;

@end
