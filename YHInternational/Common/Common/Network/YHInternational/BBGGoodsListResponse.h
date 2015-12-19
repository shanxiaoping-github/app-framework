//
//  BBGGoodsListResponse.h
//  Common
//
//  Created by Timmy Ouyang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"

@interface BBGGoodsListResponse : BBGResponse

/**
 *  搜索到的所有商品，数组里为BBGProduct对象
 */
@property (nonatomic, strong) NSArray *products;

@end
