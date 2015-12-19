//
//  BBGSearchFilterResponse.m
//  Common
//
//  Created by Timmy OuYang on 15/5/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSearchFilterResponse.h"
#import "BBGCategory.h"
#import "BBGAttribute.h"

@implementation BBGSearchFilterResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        NSMutableArray *allAttributes = [NSMutableArray array];
        
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")
        
        
        //分类信息
        BBGResponseData *categoryData;
        DATA_FOR_KEY_DATA(categoryData, @"facetCate", data)
        NSInteger categoryCount = [categoryData count];
        NSMutableArray *category = [NSMutableArray arrayWithCapacity:categoryCount];
        for (int i = 0; i < categoryCount; i ++) {
            BBGResponseData *cateData;
            DATA_FOR_INDEX_DATA(cateData, i, categoryData)
            BBGResponseData *parentCateData;
            DATA_FOR_KEY_DATA(parentCateData, @"parentCate", cateData)
            BBGCategory *parentCate = [[BBGCategory alloc] initWithHandler:self responseData:parentCateData];
            
            BBGResponseData *childrenCateData;
            DATA_FOR_KEY_DATA(childrenCateData, @"childrenCate", cateData)
            NSInteger childrenCateCount = [childrenCateData count];
            NSMutableArray *childrenCate = [NSMutableArray arrayWithCapacity:childrenCateCount];
            for (int i = 0; i < childrenCateCount; i++) {
                BBGResponseData *childCateData;
                DATA_FOR_INDEX_DATA(childCateData, i, childrenCateData)
                BBGCategory *childCate = [[BBGCategory alloc] initWithHandler:self responseData:childCateData];
                childCate.parentId = parentCate.catId;
                [childrenCate addObject:childCate];
            }
            parentCate.childrenCate = childrenCate;
            [category addObject:parentCate];
        }
        
        if ([category count] > 0) {
            BBGAttribute *attribute = [[BBGAttribute alloc] init];
            attribute.attributeName = @"分类";
            attribute.subAttributes = category;
            attribute.isMultiSelection = NO;
            [allAttributes addObject:attribute];
        }
        
        //品牌
        BBGResponseData *brandsData;
        DATA_FOR_KEY_DATA(brandsData, @"facetBrand", data)
        NSInteger brandCount = [brandsData count];
        NSMutableArray *brands = [NSMutableArray arrayWithCapacity:brandCount];
        for (int i = 0; i < brandCount; i ++) {
            BBGResponseData *brandData;
            DATA_FOR_INDEX_DATA(brandData, i, brandsData)
            BBGCategory *brand = [[BBGCategory alloc] initWithHandler:self responseData:brandData];
            brand.parentName = @"brandIds";
            [brands addObject:brand];
        }
        if ([brands count] > 0) {
            BBGAttribute *attribute = [[BBGAttribute alloc] init];
            attribute.attributeName = @"品牌";
            attribute.subAttributes = brands;
            attribute.isMultiSelection = YES;
            [allAttributes addObject:attribute];
        }
        
        //价格
        BBGResponseData *priceRangesData;
        DATA_FOR_KEY_DATA(priceRangesData, @"facetPriceRange", data)
        NSInteger priceRangeCount = [priceRangesData count];
        NSMutableArray *priceRanges = [NSMutableArray arrayWithCapacity:priceRangeCount];
        for (int i = 0; i < priceRangeCount; i ++) {
            BBGResponseData *priceRangeData;
            DATA_FOR_INDEX_DATA(priceRangeData, i, priceRangesData)
            BBGCategory *priceRange = [[BBGCategory alloc] initWithHandler:self responseData:priceRangeData];
            priceRange.parentName = @"价格";
            [priceRanges addObject:priceRange];
        }
        if ([priceRanges count] > 0) {
            BBGAttribute *attribute = [[BBGAttribute alloc] init];
            attribute.attributeName = @"价格";
            attribute.subAttributes = priceRanges;
            attribute.isMultiSelection = NO;
            [allAttributes addObject:attribute];
        }
        
        //规格
        BBGResponseData *specData;
        DATA_FOR_KEY_DATA(specData, @"facetSpec", data)
        
        //其它筛选条件
        BBGResponseData *attributesData;
        DATA_FOR_KEY_DATA(attributesData, @"facetProps", data)
        NSInteger attributeCount = [attributesData count];
        for (int i = 0; i < attributeCount; i ++) {
            BBGResponseData *attributeData;
            DATA_FOR_INDEX_DATA(attributeData, i, attributesData)
            BBGResponseData *propDatas;
            DATA_FOR_KEY_DATA(propDatas, @"propsValues", attributeData)
            NSString *parentId = nil;
            STRING_FOR_KEY_DATA(parentId, @"propsId", attributeData)
            NSMutableArray *propDataArray = [NSMutableArray arrayWithCapacity:propDatas.count];
            for (int i=0; i<propDatas.count; i++) {
                BBGResponseData *propData;
                DATA_FOR_INDEX_DATA(propData, i, propDatas)
                BBGCategory *propCate = [[BBGCategory alloc] initWithHandler:self responseData:propData];
                propCate.parentName = @"facetProps";
                propCate.parentId = parentId;
                [propDataArray addObject:propCate];
            }
            if (propDataArray.count>0) {
                BBGAttribute *attribute = [[BBGAttribute alloc] initWithHandler:self responseData:attributeData];
                attribute.subAttributes = propDataArray;
                attribute.isMultiSelection = NO;
                [allAttributes addObject:attribute];
            }
        }
        self.allFilterAttributes = allAttributes;

    }
    return self;
}

@end
