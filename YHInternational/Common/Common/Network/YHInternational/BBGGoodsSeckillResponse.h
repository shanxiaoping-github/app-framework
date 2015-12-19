//
//  BBGGoodsSeckillResponse.h
//  Common
//
//  Created by 彭腾 on 15/10/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGGoodsBasicInfo.h"
#import "BBGAddress.h"
#import "BBGGSSeckillModel.h"

@interface BBGGoodsSeckillResponse : BBGResponse
/**
 *  商品图片列表
 */
@property (nonatomic, strong) NSMutableArray *goodsImagesArr;
/**
 *  商品基本信息
 */
@property (nonatomic, strong) BBGGoodsBasicInfo *basicInfo;
/**
 *  地址信息
 */
@property (nonatomic, strong) NSMutableArray *addressArr;
/**
 *  秒杀详情信息
 */
@property (nonatomic, strong) BBGGSSeckillModel *seckill;
/**
 *  是否登录
 */
@property (nonatomic, assign) BOOL isLogin;

@end
