//
//  BBGFind.m
//  Common
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFind.h"

@implementation BBGFind
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
        
    }
    return self;
}
@end
