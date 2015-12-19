//
//  BBGSearchProduct.h
//  Common
//
//  Created by calvin on 14-8-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGProduct.h"

@interface BBGSearchProduct : BBGProduct

/**
 *  总库存
 */
@property (nonatomic, assign) NSInteger storeCount;
/**
 *  团购价格
 */
@property (nonatomic, assign) float groupPrice;
/**
 *  不划线正常显示价格
 */
@property (nonatomic, assign) float unCrossedPrice;
/**
 *  划线价格（为空则不显示）
 */
@property (nonatomic, assign) float crossedPrice;

/*!
 * 商品标签列表
 */
@property (nonatomic, strong) NSMutableArray *labelsArray;
/**
 * 促销信息
 */
@property (nonatomic, strong) NSString *promotionInfo;
/**
 * 商品状态
 */
@property (nonatomic, strong) NSString *status;
/**
 * 库存状态
 */
@property (nonatomic, strong) NSString *inventorystatus;
/*!
 * 商品类型
 *  0 普通货品
 *  1 立即购买
 *  2 团购商品
 *  3 预售商品
 */
@property (nonatomic, assign) NSInteger productType;


@end
