//
//  BBGGoodsListRequest.m
//  Common
//
//  Created by Timmy Ouyang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsListRequest.h"
#import "BBGGoodsListResponse.h"

@implementation BBGGoodsListRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    
    [parameters addParameter:_keyword forKey:@"keywords"];
    [parameters addParameter:_categoryID forKey:@"ftCate"];
    [parameters addParameter:_brandIDs forKey:@"brandIds"];
    [parameters addParameter:_shopId forKey:@"shopId"];

    if (self.minPrice > 0) {
        [parameters addParameter:[NSString stringWithFormat:@"%.f",self.minPrice] forKey:@"leftPrice"];
    }
    if (self.maxPrice > 0) {
        [parameters addParameter:[NSString stringWithFormat:@"%.f",self.maxPrice] forKey:@"rightPrice"];
    }
    if (self.showHaveStoreOnly) {
        [parameters addParameter:[NSNumber numberWithBool:YES] forKey:@"hasStore"];
    }

    NSString *sortField;//排序字段
    NSString *sortOn;//排序方式
    switch (self.type) {
        case SortTypeDefault:
        {
            sortField = @"salecount";//销量
            sortOn = @"desc";
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
        default:
        {
            sortField = @"salecount";//销量
            sortOn = @"desc";
        }
            break;
    }
    [parameters addParameter:sortField forKey:@"sortField"];
    [parameters addParameter:sortOn forKey:@"sortOn"];
    [parameters addParameter:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageIndex"];
    [parameters addParameter:[NSString stringWithFormat:@"%lu",(unsigned long)_pageSize] forKey:@"pageSize"];
    for (NSString *key in _attributes.allKeys) {
        [parameters addParameter:_attributes[key] forKey:key];
    }
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGGoodsListResponse class];
}

@end
