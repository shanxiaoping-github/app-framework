//
//  BBGUnEvaluateGood.h
//  Common
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGUnEvaluateGood : BBGResponseDataHandler

/*
 * 商品ID
 */
@property (nonatomic, strong) NSString *goodsId;
/**
 *  货品图片URL
 */
@property (nonatomic, strong) NSString *imgUrl;

/**
 *  货品名称
 */
@property (nonatomic, strong) NSString *productName;
/**
 *  营销价格
 */
@property (nonatomic, assign) float umpPrice;

/*
 * 商品ID
 */
@property (nonatomic, strong) NSString *productId;
/**
 *  会员ID
 */
@property (nonatomic, strong) NSString *memberId;

/**
 *  销售价
 */
@property (nonatomic, assign) float price;
@end
