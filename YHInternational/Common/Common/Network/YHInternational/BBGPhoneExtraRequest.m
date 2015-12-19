//
//  BBGPhoneExtraRequest.m
//  Common
//
//  Created by Timmy OuYang on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneExtraRequest.h"
#import "BBGPhoneExtraResponse.h"

@implementation BBGPhoneExtraRequest

- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
        self.type = SortTypeDefault;
        self.page = 1;
        self.pageSize = 20;
        self.hasStore = NO;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    
    
    [parameters addParameter:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageIndex"];
    [parameters addParameter:[NSString stringWithFormat:@"%lu",(unsigned long)_pageSize] forKey:@"pageSize"];

    if (self.hasStore) {
        [parameters addParameter:[NSNumber numberWithBool:YES] forKey:@"hasStore"];
    }else {
        [parameters addParameter:[NSNumber numberWithBool:NO] forKey:@"hasStore"];
    }

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
    [super buildParameters:parameters];

}

- (Class)responseClass {
    return [BBGPhoneExtraResponse class];
}

@end
