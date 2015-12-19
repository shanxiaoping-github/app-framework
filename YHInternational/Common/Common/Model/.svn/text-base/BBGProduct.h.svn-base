//
//  BBGProduct.h
//  Common
//　商品实体
//  Created by calvin on 14-5-8.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGResponseDataHandler.h"
//#import "BBGProductSpec.h"
#import "BBGProductTag.h"
@interface BBGProduct : BBGResponseDataHandler

/*!
 * 商铺Id
 */
@property (nonatomic, strong) NSString * shopId;
/*!
 * 商品ID
 */
@property (nonatomic, strong) NSString *productID;
/*!
 * 货品ID
 */
@property (nonatomic, strong) NSString *goodsID;
/*!
 * 商品图片地址
 */
@property (nonatomic, strong) NSString *productImageURL;
/*!
 * 商品名称
 */
@property (nonatomic, strong) NSString *productName;
/*!
 * 商品编号
 */
@property (nonatomic, strong) NSString *productBN;
/**
 *  商品最终售价（实际销售价格）
 */
@property (nonatomic, assign) float finalPrice;
/*!
 * 商品销售价
 */
@property (nonatomic, assign) float salePrice;
/*!
 * 商品市场价
 */
@property (nonatomic, assign) float marketPrice;
/*!
 * 促销价
 */
@property (nonatomic, assign) float promotionPrice;

@property (nonatomic, assign) NSMutableArray *priceArray;
/*!
 * 营销库存
 */
@property (nonatomic, assign) NSInteger store;

/*!
 * 真实库存
 */
@property (nonatomic, assign) NSInteger realStore;
/*!
 * 是否上架
 */
@property (nonatomic, assign) BOOL marketable;
/*!
 * 店铺名称
 */
@property (nonatomic, strong) NSString *shopName;
/**
 *  评论数
 */
@property (nonatomic, assign) NSInteger commentCount;
/**
 *  点赞数
 */
@property (nonatomic, assign) NSInteger praiseCount;
/**
 *  商品描述
 */
@property (nonatomic, strong) NSString *goodsExplain;
/**
 *  产国
 */
@property (nonatomic, strong) NSString *produceCountry;
/**
 *  国旗图片 (图片链接)
 */
@property (nonatomic, strong) NSString *countryFlag;

@property (nonatomic, strong) NSMutableArray *specArray;


/**
 *  商品状态 0-正常 1-已抢完  2-已售完  3-已下架
 */
@property (nonatomic, assign) NSInteger goodsStatus;
/**
 *  是否秒杀
 */
@property (nonatomic,assign) BOOL isSecKill;

@end
