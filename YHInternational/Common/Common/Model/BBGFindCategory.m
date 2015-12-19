//
//  BBGFindCategory.m
//  Common
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFindCategory.h"
#import "BBGFind.h"

@implementation BBGFindCategory
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(_catId, @"catId")
        STRING_FOR_KEY(_parentId, @"parentId")
        STRING_FOR_KEY(_catName, @"catName")
        STRING_FOR_KEY(_catPath, @"catPath")
        STRING_FOR_KEY(_catSort, @"catSort")
        STRING_FOR_KEY(_isLeaf, @"isLeaf")
        STRING_FOR_KEY(_targetType, @"targetType")
        STRING_FOR_KEY(_imageUrl, @"imageUrl")
        BBGResponseData *findCategoryData;
        DATA_FOR_KEY(findCategoryData, @"childCategories")
        if (findCategoryData && [findCategoryData count]>0) {
            _findCategoryArray = [NSMutableArray arrayWithCapacity:[findCategoryData count]];
            for (int i = 0; i<[findCategoryData count]; i++) {
                BBGResponseData *findData;
                DATA_FOR_INDEX_DATA(findData, i, findCategoryData)
                BBGFind *find = [[BBGFind alloc] initWithHandler:self responseData:findData];
                [ _findCategoryArray addObject:find];
            }
        }

    }
    return self;
}

@end
