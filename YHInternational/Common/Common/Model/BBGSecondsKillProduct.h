//
//  BBGSecondsKillProduct.h
//  Common
//
//  Created by 刘薇 on 15/7/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGProduct.h"

@interface BBGSecondsKillProduct : BBGProduct
/*!
 * 条形码
 */
@property (nonatomic, strong) NSString *barCode;
/*!
 * 货号
 */
@property (nonatomic, strong) NSString *bn;

/*!
 * 品牌编码
 */
@property (nonatomic, strong) NSString *brandId;

/*!
 * 划线价  单位分
 */
@property (nonatomic, assign)NSInteger  crossedPrice;

/*!
 * 是否上架，true是
 */
@property (nonatomic, strong) NSString *marketablechild;
/*!
 * 市场价
 */
@property (nonatomic, assign) NSInteger mkPrice;
/*!
 * 所属秒杀活动id
 */
@property (nonatomic, strong) NSString *secKillActivityId;
/*!
 * 活动id
 */
@property (nonatomic, strong) NSString *activityId;

/*!
 * 所属营销活动开始时间
 */
@property (nonatomic, strong) NSString *activityStartTime;
/*!
 * 所属营销活动结束时间
 */
@property (nonatomic, strong) NSString *activityEndTime;
/*!
 * 所属营销活动名称
 */
@property (nonatomic, strong) NSString *activityName;
/*!
 * 货品类型
 0 普通货品、1 立即购买、2团购商品、3预售商品 ；1的话则是立即购买；其他的逻辑根据库存来判断是无货还是售完(到货通知图标样式)
 
 搜索列表：根据货品购买类型 结合 storeCount (库存)来处理
 详情页:结合当前货品的库存
 */
@property (nonatomic, assign) NSInteger productType;
/*!
 * 库存
 */
@property (nonatomic, assign) NSInteger storechild;
/*!
 * 非划线价 单位分
 */
@property (nonatomic, assign) NSInteger unCrosedPrice;
/*!
 * price
 */
@property (nonatomic, assign) NSInteger price;
/*!
 * payPrice
 */
@property (nonatomic, assign) NSInteger payPrice;
/*!
 * 图片链接
 */
@property (nonatomic, strong) NSString *imageUrl;



@end
