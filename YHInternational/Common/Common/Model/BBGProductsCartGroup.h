//
//  BBGProductsCartGroup.h
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

/**
 *  购物车商品分组
 */
@interface BBGProductsCartGroup : BBGResponseDataHandler
/**
 *  赠品数组
 */
@property (nonatomic,strong)NSMutableArray *giftsList;

/**
 *  分组店铺
 */
@property (nonatomic,strong) NSString *shopId;

/**
 *  店铺名称
 */
@property (nonatomic,strong) NSString *shopName;

/**
 *  店铺类型
 */
@property (nonatomic,assign) NSInteger shopType;

/**
 *  商品列表
 */
@property (nonatomic,strong) NSMutableArray *products;

/**
 *  优惠信息
 */
@property (nonatomic,strong) NSMutableArray *promotions;

/**
 *  提示信息
 */
@property (nonatomic,assign) NSInteger tipStatus;

/**
 *  商品价格
 */
@property (nonatomic,assign) float totalPrice;

/**
 *  运费
 */
@property (nonatomic,assign) float totalFreight;

/**
 *  总的优惠
 */
@property (nonatomic,assign) float totalPmt;

/**
 *  商品重量
 */
@property (nonatomic,assign) float productWeight;

/**
 *  总重量，全球购没有赠品的情况下与productWeight相等
 */
@property (nonatomic,assign) float totalWeight;

/**
 *  实际价格，等于商品价格+运费-优惠价格
 */
@property (nonatomic,assign) float totalRealPrice;

/**
 *  关税
 */
@property (nonatomic,assign) float totalTariff;

/**
 *  选中状态 1:选中 2:没选中 3:不可选
 */
@property (nonatomic,assign) NSInteger selected;

@end
