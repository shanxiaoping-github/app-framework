//
//  BBGSimpleCartModel.h
//  Common
//
//  Created by yangjie on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGSimpleCartModel : BBGResponseDataHandler

/**
 *  商品总数量
 */
@property (nonatomic,assign) NSInteger totalQuantity;
/**
 *  商品总类数
 */
@property (nonatomic,assign) NSInteger totalType;
/**
 *  商品总价
 */
@property (nonatomic,assign) float totalPrice;

@end
