//
//  BBGSearchRequest.m
//  Common
//
//  Created by calvin on 14-8-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSearchRequest.h"
#import "BBGSearchResponse.h"

@implementation BBGSearchRequest

- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
        self.type = SortTypeDefault;
        self.page = 1;
        self.pageSize = 20;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    [parameters addParameter:_keyword forKey:@"keywords"];
    [parameters addParameter:_categoryID forKey:@"backCates"];
    [parameters addParameter:_brandIDs forKey:@"brandIds"];
    [parameters addParameter:_shopId forKey:@"shopId"];
    [parameters addParameter:_shopCate forKey:@"shopCate"];
    [parameters addParameter:_facetProps forKey:@"facetProps"];
    [parameters addParameter:_facetSpec forKey:@"facetSpec"];
    [parameters addParameter:_fCate forKey:@"fCate"];
    
    if (self.minPrice >= 0) {
        [parameters addParameter:[NSString stringWithFormat:@"%.f",self.minPrice] forKey:@"leftPrice"];
    }
    if (self.maxPrice > 0) {
        [parameters addParameter:[NSString stringWithFormat:@"%.f",self.maxPrice] forKey:@"rightPrice"];
    }
    if (self.showHaveStoreOnly) {
       [parameters addParameter:[NSNumber numberWithBool:YES] forKey:@"hasStore"];
    }else {
        [parameters addParameter:[NSNumber numberWithBool:NO] forKey:@"hasStore"];
    }
//此处加上自营的字段，目前未确定
    if (self.showProprietaryOnly) {
        [parameters addParameter:@"3" forKey:@"shopType"];
    }
    //NSString *sortKey;
    
    NSString *sortField;//排序字段
    NSString *sortOn;//排序方式
    switch (self.type) {
        case SortTypeDefault:
        {
            sortField = @"default";//默认排序
            sortOn = @"";
        }
            break;
        case SortTypePriceAscend:
        {
            sortField = @"price";//价格
            sortOn = @"asc";
        }
            break;
        case SortTypePriceDescend:
        {
            sortField = @"price";//价格
            sortOn = @"desc";
        }
            break;
        case SortTypeGradeAscend:
        {
            sortField = @"comment";//价格升序
            sortOn = @"asc";
        }
            break;
        case SortTypeGradeDescend:
        {
            sortField = @"comment";//评分降序
            sortOn = @"desc";
        }
            break;

        default:
        {
            sortField = @"salecount";//销量
            sortOn = @"desc";
        }
            break;
    }
    [parameters addParameter:sortField forKey:@"sortFile"];
    [parameters addParameter:sortOn forKey:@"sortType"];
    [parameters addParameter:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageIndex"];
    [parameters addParameter:[NSString stringWithFormat:@"%lu",(unsigned long)_pageSize] forKey:@"pageSize"];
    for (NSString *key in _attributes.allKeys) {
        [parameters addParameter:_attributes[key] forKey:key];
    }
    [super buildParameters:parameters];
}

- (Class)responseClass {
    return [BBGSearchResponse class];
}

@end