//
//  BBGFindCountry.m
//  Common
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFindCountry.h"
#import "BBGFindCategory.h"

@implementation BBGFindCountry

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
        
        BBGResponseData *findCountryData;
        DATA_FOR_KEY(findCountryData, @"childCategories")
        if (findCountryData && [findCountryData count]>0) {
            _findCountryArray = [NSMutableArray arrayWithCapacity:[findCountryData count]];
            for (int i = 0; i<[findCountryData count]; i++) {
                BBGResponseData *categoryData;
                DATA_FOR_INDEX_DATA(categoryData, i, findCountryData)
                BBGFindCategory *category = [[BBGFindCategory alloc] initWithHandler:self responseData:categoryData];
                [ _findCountryArray addObject:category];
            }
        }
    }
    return self;
}

@end
