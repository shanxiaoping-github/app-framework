//
//  BBGGoodsListRequest.h
//  Common
//
//  Created by Timmy Ouyang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

typedef enum {
    SortTypeDefault = 0,         //默认排序，按库存排列
    SortTypePriceDescend = 1,    //按价格降序排列
    SortTypePriceAscend = 2,     //按价格升序排列
    SortTypeSalesDescend = 3,    //按销量降序排列
}SortType;

@interface BBGGoodsListRequest : BBGRequest
/*!
 * 商铺Id
 */
@property (nonatomic, strong) NSString * shopId;
/**
 *  商品列表的排序类型
 */
@property (nonatomic, assign) SortType type;
/**
 *  搜索关键字
 */
@property (nonatomic, strong) NSString *keyword;
/**
 *  分类ID，分类搜索时使用
 */
@property (nonatomic, strong) NSString *categoryID;
/**
 *  筛选时勾选的所有品牌ID
 */
@property (nonatomic, strong) NSString *brandIDs;
/**
 *  筛选时用户选择的商品最低价
 */
@property (nonatomic, assign) float minPrice;
/**
 *  筛选时用户选择的商品最高价
 */
@property (nonatomic, assign) float maxPrice;
/**
 *  只显示有货商品，YES表示只显示有货，NO表示显示所有
 */
@property (nonatomic, assign) BOOL showHaveStoreOnly;
/**
 *  页码，默认为1
 */
@property (nonatomic, assign) NSUInteger page;
/**
 *  每页商品数，默认为20
 */
@property (nonatomic, assign) NSUInteger pageSize;
/**
 *  筛选选择的商品属性，key为属性名，value为属性ID
 */
@property (nonatomic, strong) NSDictionary *attributes;

@end
