//
//  BBGPhoneExtraResponse.h
//  Common
//
//  Created by Timmy OuYang on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"

@interface BBGPhoneExtraResponse : BBGResponse

/**
 *  命中的商品总数量
 */
@property (nonatomic, assign) NSInteger totalCount;
/**
 *  搜索到的所有商品，数组里为BBGSearchProduct对象
 */
@property (nonatomic, strong) NSArray *products;

@end
