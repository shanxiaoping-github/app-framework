//
//  BBGAbstractBrand.h
//  Common
//  品牌聚类（抽象出来的品牌，包含品牌列表）
//  Created by OuyangTimmy on 15/7/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBrand.h"

@interface BBGAbstractBrand : BBGBrand
/**
 *  品牌类目名称
 */
@property (nonatomic, strong) NSString *brandOutName;
/**
 *  品牌类目图url
 */
@property (nonatomic, strong) NSString *brandOutUrl;
/**
 *  品牌类目id
 */
@property (nonatomic, strong) NSString *brandOutId;

@end