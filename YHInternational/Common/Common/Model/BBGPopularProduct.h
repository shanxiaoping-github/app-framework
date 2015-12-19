//
//  BBGPopularProduct.h
//  Common
//
//  Created by OuyangTimmy on 15/7/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGPopularProduct : BBGResponseDataHandler

/**
 *  货品id
 */
@property (nonatomic, strong) NSString *productId;
/**
 *  正常价格显示（不划线）
 */
@property (nonatomic, assign) float unCrosedPrice;
/**
 *  BN码
 */
@property (nonatomic, strong) NSString *bn;
/**
 *  货品类型
 */
@property (nonatomic, assign) NSInteger productType;
/**
 *  支付价格
 */
@property (nonatomic, assign) NSInteger payPrice;
/**
 *  市场价
 */
@property (nonatomic, assign) NSInteger mkPrice;
/**
 *  货品名称
 */
@property (nonatomic, strong) NSString *productName;
/**
 *  活动开始时间
 */
@property (nonatomic, strong) NSString *activityStartTime;
/**
 *  货品图片
 */
@property (nonatomic, strong) NSString *imageUrl;
/**
 *  活动id
 */
@property (nonatomic, strong) NSString *activityId;
/**
 *  价格
 */
@property (nonatomic, assign) float price;
/**
 *  秒杀活动id
 */
@property (nonatomic, strong) NSString *secKillActivityId;
/**
 *  所属品牌id
 */
@property (nonatomic, strong) NSString *brandId;
/**
 *  活动结束时间
 */
@property (nonatomic, strong) NSString *activityEndTime;
/**
 *  划线价格
 */
@property (nonatomic, assign) float crossedPrice;
/**
 *  活动名称
 */
@property (nonatomic, strong) NSString *activityName;
/**
 *  二维条码
 */
@property (nonatomic, strong) NSString *barCode;
/**
 *  是否下架
 */
@property (nonatomic, assign) BOOL marketable;
/**
 *  库存
 */
@property (nonatomic, assign) NSInteger store;

@end
