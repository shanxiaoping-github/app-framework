//
//  BBGSettlementPacket.h
//  Common
//
//  Created by Timmy OuYang on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"
#import "BBGCoupon.h"

@interface BBGSettlementPacket : BBGResponseDataHandler
/**
 *  店铺id
 */
@property (nonatomic, strong) NSString *shopId;
/**
 *  店铺名称
 */
@property (nonatomic, strong) NSString *shopName;
/**
 *  商品价格
 */
@property (nonatomic, assign) NSInteger totalPrice;
/**
 *  运费
 */
@property (nonatomic, assign) NSInteger totalFreight;
/**
 *  总的优惠
 */
@property (nonatomic, assign) NSInteger totalPmt;
/**
 *  实际价格，等于商品价格+运费-优惠价格
 */
@property (nonatomic, assign) NSInteger totalRealPrice;
/**
 *  关税
 */
@property (nonatomic, assign) NSInteger totalTariff;
/**
 *  商品重量
 */
@property (nonatomic, assign) float productWeight;
/**
 *  总重量，全球购没有赠品的情况下与productWeight相等
 */
@property (nonatomic, assign) float totalWeight;
/**
 *  使用的优惠券
 */
@property (nonatomic, strong) BBGCoupon *userCoupon;
/**
 *  促销活动列表
 */
@property (nonatomic, strong) NSArray *promotions;
/**
 *  商品列表
 */
@property (nonatomic, strong) NSArray *products;

@end
