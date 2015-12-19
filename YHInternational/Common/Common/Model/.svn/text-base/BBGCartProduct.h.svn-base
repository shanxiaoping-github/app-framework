//
//  BBGCartProduct.h
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

/**
 *  购物车商品类
 */
@interface BBGCartProduct : BBGResponseDataHandler

/**
 *  货品id
 */
@property (nonatomic,strong) NSString *productId;
/**
 *  商品id
 */
@property (nonatomic,strong) NSString *goodsId;
/**
 *  商品名称
 */
@property (nonatomic,strong) NSString *productName;
/**
 *  商品主图
 */
@property (nonatomic,strong) NSString *productImage;
/**
 *  商品广告语
 */
@property (nonatomic,strong) NSString *productAd;
/**
 *  条码
 */
@property (nonatomic,strong) NSString *barcode;
/**
 *  货号
 */
@property (nonatomic,strong) NSString *bn;
/**
 *  销售价格
 */
@property (nonatomic,assign) float price;
/**
 *  商品原价
 */
@property (nonatomic,assign) float salePrice;
/**
 *  商品市场价
 */
@property (nonatomic,assign) float mktPrice;
/**
 *  促销价
 */
@property (nonatomic,assign) float bargainPrice;
/**
 *  划线价
 */
@property (nonatomic,assign) float crossedPrice;
/**
 *  非划线价
 */
@property (nonatomic,assign) float unCrossedPrice;

/**
 *  单位重量
 */
@property (nonatomic,assign) float weight;
/**
 *  单位
 */
@property (nonatomic,strong) NSString *unit;
/**
 *  商品级优惠 单个
 */
@property (nonatomic,assign) float totalPmt;
/**
 *  分摊的订单级优惠
 */
@property (nonatomic,assign) float totalSharePmt;
/**
 *  购买数量
 */
@property (nonatomic,assign) NSInteger quantity;
/**
 *  店铺id
 */
@property (nonatomic,strong) NSString *shopId;
/**
 *  店铺类型
 */
@property (nonatomic,assign) NSInteger shopType;
/**
 *  库存
 */
@property (nonatomic,assign) NSInteger stock;
/**
 *  限制购买数量
 */
@property (nonatomic,assign) NSInteger limit;
/**
 *  种类限制
 */
@property (nonatomic,assign) NSInteger limitKind;
/**
 *  选中状态 1:选中 2:没选中 3:不可选
 */
@property (nonatomic,assign) NSInteger selected;
/**
 *  产品状态 等于100正常销售 否则提示statusTip信息
 *  产品状态 小于100不可销售
 *  产品状态 大于100可销售，有销售限制
 */
@property (nonatomic,assign) NSInteger productStatus;
/**
 *  产品状态提示信息
 */
@property (nonatomic,strong) NSString *statusTip;
/**
 *  是否可售
 */
@property (nonatomic,assign) BOOL sale;
/**
 *  是否已经收藏
 */
@property (nonatomic,assign) BOOL favorite;
/**
 *  后台分类Id
 */
@property (nonatomic,strong) NSString *backCatId;
/**
 *  购买类型
 */
@property (nonatomic,assign) NSInteger buyType;
/**
 *  检查身份
 */
@property (nonatomic,assign) BOOL idCheck;
/**
 *  加入时间
 */
@property (nonatomic,assign) float addTime;
/**
 *  规格信息
 */
@property (nonatomic,strong) NSMutableArray *specList;
/**
 *  商品重量
 */
@property (nonatomic,assign) float productWeight;
/**
 *  关税
 */
@property (nonatomic,assign) float tariff;
/**
 *  规格名称（多个用","隔开）
 */
@property (nonatomic,strong) NSString *specNameStr;
/**
 *  赠品类型
 *  1,商品
 */
@property (nonatomic, assign) NSInteger type;
/**
 *  赠品id
 */
@property (nonatomic,strong) NSString *targetId;
/**
 *  数量
 */
@property (nonatomic, assign) NSInteger num;
/**
 *  （市场价 弃用）
 */
@property (nonatomic,assign) float mktprice;

@end
