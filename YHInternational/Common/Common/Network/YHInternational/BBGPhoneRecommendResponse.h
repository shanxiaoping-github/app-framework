//
//  BBGPhoneRecommendResponse.h
//  Common
//
//  Created by 黄 灿 on 15/7/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"

@interface BBGPhoneRecommendResponse : BBGResponse
/**
 *  命中的商品总数量
 */
@property (nonatomic, assign) NSInteger totalCount;
/**
 *  搜索到的所有商品，数组里为BBGSearchProduct对象
 */
@property (nonatomic, strong) NSArray *products;

@end
