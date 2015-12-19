//
//  BBGGoodsBasicInfo.h
//  Common
//
//  Created by 彭腾 on 15-5-7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"
#import "BBGProduct.h"

@interface BBGGoodsBasicInfo : BBGProduct
/**
 *  商品名称
 */
@property (nonatomic, copy) NSString *goodsName ;
/**
 *  商品主图Url
 */
@property (nonatomic, copy) NSString *goodsImageUrl ;
/**
 *  货品主图Url
 */
@property (nonatomic, copy) NSString *productImageUrl ;
/**
 *  商品ID
 */
@property (nonatomic, copy) NSString *goodsId ;
/**
 *  货品ID
 */
@property (nonatomic, copy) NSString *productId ;
/**
 *  商品简介
 */
@property (nonatomic, copy) NSString *brief ;
/**
 *  销售价
 */
@property (nonatomic, assign) float price ;
/**
 *  营销价
 */
@property (nonatomic, assign) float payPrice ;
/**
 *  商品总库存
 */
@property (nonatomic, assign) NSInteger storeTotalNum ;
/**
 *  商品图文信息
 */
@property (nonatomic, copy) NSString *intro ;
/**
 *  活动结束日期
 */
@property (nonatomic, copy) NSString *activityEndDate ;
/**
 *  活动开始日期
 */
@property (nonatomic, copy) NSString *activityStartDate;
/**
 *  系统时间
 */
@property (nonatomic, copy) NSString *sysDate;
/**
 *  发货地
 */
@property (nonatomic, copy) NSString *address ;
/**
 *  是否点赞
 */
@property (nonatomic, assign) BOOL isPraise ;
/**
 *  货品规格
 */
@property (nonatomic, copy) NSString *productSpecText ;
/**
 *  购买状态
 */
@property (nonatomic, assign) NSInteger productType;
/**
 *  划线价
 */
@property (nonatomic, assign) CGFloat crossedPrice;
/**
 *  非划线价
 */
@property (nonatomic, assign) CGFloat unCrossedPrice;
/**
 *  用户能购买的数量
 */
@property (nonatomic, copy) NSString *canBuyNum;
/**
 *  加入购物车按钮文字
 */
@property (nonatomic, copy) NSString *buyButtonTips;
/**
 *  活动ID
 */
@property (nonatomic, copy) NSString *actityId;
/**
 *  是否有秒杀活动
 */
@property (nonatomic, assign) BOOL seckillActity;
///**
// *  加入购物车按钮状态
// */
//@property (nonatomic, assign) NSInteger goodsStatus;

@end
