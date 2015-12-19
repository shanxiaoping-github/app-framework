//
//  BBGBrand.h
//  Common
//
//  Created by elvis.peng on 14-8-14.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

typedef enum {
    BBGPopularBrandType,     //爆款品牌
    BBGRecommendBrandType,     //推荐品牌
}BBGBrandType;

@interface BBGBrand : BBGResponseDataHandler
/**
 *  品牌名称
 */
@property(strong,nonatomic) NSString *brandName;
/**
 *  品牌ID
 */
@property(strong,nonatomic) NSString *brandId;
/**
 *  品牌图片url
 */
@property(strong,nonatomic) NSString *url;
/**
 *  品牌下子内容（V1.2 美妆品牌下爆款品牌使用）
 */
@property (nonatomic, strong) NSArray *subContentsArray;
/**
 *  品牌类型
 */
@property (nonatomic, assign) BBGBrandType brandType;

@end
