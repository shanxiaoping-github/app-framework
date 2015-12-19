//
//  BBGProductSpecVo.h
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"


/**
 *  购物车商品规格
 */
@interface BBGProductSpecVo : BBGResponseDataHandler

/**
 *  规格id
 */
@property (nonatomic,strong) NSString *specId;
/**
 *  规格值id
 */
@property (nonatomic,strong) NSString *valueId;
/**
 *  名称
 */
@property (nonatomic,strong) NSString *name;
/**
 *  值
 */
@property (nonatomic,strong) NSString *value;

@end
