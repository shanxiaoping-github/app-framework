//
//  BBGProductsCart.h
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

#import "BBGProductsCart.h"
#import "BBGProductsCartGroup.h"
#import "BBGCartProduct.h"
#import "BBGProductCartPromotion.h"
#import "BBGProductSpecVo.h"


/**
 *  商品购物车总类
 */
@interface BBGProductsCart : BBGResponseDataHandler

/**
 *  种类
 */
@property (nonatomic,assign) NSInteger totalType;
/**
 *  数量
 */
@property (nonatomic,assign) NSInteger totalQuantity;

/**
 *  选中状态 1:选中 2:没选中 3:不可选
 */
@property (nonatomic,assign) NSInteger selected;

/**
 *  CartGroup数组
 */
@property (nonatomic,strong) NSMutableArray *groups;

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


@end
