//
//  BBGGoodsSpecQuery.h
//  Common
//
//  Created by 彭腾 on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGGoodsSpecQuery : BBGResponseDataHandler
/**
 *  规格名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  规格id
 */
@property (nonatomic, copy) NSString *Id;
/**
 *  规格值集合
 */
@property (nonatomic, strong) NSMutableArray *values;

@end
