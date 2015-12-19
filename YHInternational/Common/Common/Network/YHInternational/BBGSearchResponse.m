//
//  BBGSearchResponse.m
//  Common
//
//  Created by calvin on 14-8-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSearchResponse.h"
#import "BBGCategory.h"

@implementation BBGSearchResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        NSMutableArray *allAttributes = [NSMutableArray array];
        
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")
        INTEGER_FOR_KEY_DATA(self.totalCount, @"count",data)
        if (self.totalCount == 0) {
            return self;
        }
        
        
        BBGResponseData *facet;
        DATA_FOR_KEY_DATA(facet, @"facet", data);
        
        //分类信息
        BBGResponseData *categoryData;
        DATA_FOR_KEY_DATA(categoryData, @"facetCate", facet)
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
        DATA_FOR_KEY_DATA(brandsData, @"facetBrand", facet)
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
        DATA_FOR_KEY_DATA(priceRangesData, @"facetPriceRange", facet)
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
        DATA_FOR_KEY_DATA(specData, @"facetSpec", facet)
        NSInteger specDataCount = [specData count];
        for (int i = 0; i<specDataCount; i++) {
            BBGResponseData *parentSpecData;
            DATA_FOR_INDEX_DATA(parentSpecData, i, specData)
            
            BBGResponseData *specValueData;
            DATA_FOR_KEY_DATA(specValueData, @"specValues", parentSpecData)
            NSInteger valueCount = specValueData.count;
            NSMutableArray *subValueArray = [NSMutableArray arrayWithCapacity:valueCount];
            for (int j = 0; j<valueCount; j++) {
                BBGResponseData *valueData;
                DATA_FOR_INDEX_DATA(valueData, j, specValueData)
                BBGSubAttribute *value = [[BBGSubAttribute alloc] initWithHandler:self responseData:valueData];
                [subValueArray addObject:value];
            }
            
            if (subValueArray.count>0) {
                BBGAttribute *specParent = [[BBGAttribute alloc] init];
                STRING_FOR_KEY_DATA(specParent.attributeID, @"specId", parentSpecData)
                STRING_FOR_KEY_DATA(specParent.attributeName, @"specName", parentSpecData)
                specParent.subAttributes = subValueArray;
            }
            
        }
        
        //其它筛选条件
        BBGResponseData *attributesData;
        DATA_FOR_KEY_DATA(attributesData, @"facetProps", facet)
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
        
        //商品列表
        BBGResponseData *productsData;
        DATA_FOR_KEY_DATA(productsData, @"goods", data)
        NSInteger productCount = [productsData count];
        NSMutableArray *products = [NSMutableArray arrayWithCapacity:productCount];
        for (int i = 0; i < productCount; i ++) {
            BBGResponseData *productData;
            DATA_FOR_INDEX_DATA(productData, i, productsData)
            BBGSearchProduct *product = [[BBGSearchProduct alloc] initWithHandler:self responseData:productData];
            [products addObject:product];
        }
        self.products = products;
        
        
        /**
         * 造点假数据
         */
        
        NSMutableArray *defaultsArray  =[[NSMutableArray alloc]init];
        for (int i =0; i<[self.products count]-2; i++) {
            NSMutableArray *defaultsArray1  =[[NSMutableArray alloc]init];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            if (i==3||i==4||i==6||i==9||i==12||i==13||i==16||i==17||i==19||i==20||i==21||i==22||i==25) {
                [defaultsArray1 addObject:self.products[i]];
                [defaultsArray1 addObject:self.products[i+1]];
                [defaultsArray1 addObject:self.products[i+2]];
            }else{
                [defaultsArray1 addObject:self.products[i]];
            }
            [dic setObject:defaultsArray1 forKey:@"array"];
            [dic setObject:@"0" forKey:@"choose"];
            
            [defaultsArray addObject:dic];
        }
        self.products = defaultsArray;

    }
    return self;
}

@end
