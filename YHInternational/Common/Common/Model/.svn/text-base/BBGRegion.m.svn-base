//
//  BBGRegion.m
//  Common
//
//  Created by Damon on 15/4/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegion.h"

@implementation BBGRegion
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
            //商城地址解析
            STRING_FOR_KEY(self.parentId, @"parentId")
            STRING_FOR_KEY(self.regionId, @"id")
            STRING_FOR_KEY(self.name, @"name")
            if (![self.responseData isNullForKey:@"children"]) {
                BBGResponseData *dataArray;
                DATA_FOR_KEY(dataArray, @"children")
                NSMutableArray *childrenArray = [NSMutableArray array];
                NSInteger index = [dataArray count] - 1;
                for (NSInteger i = index; i>=0; i --) {
                    BBGResponseData *regionData = nil;
                    DATA_FOR_INDEX_DATA(regionData, i, dataArray)
                    BBGRegion *region = [[BBGRegion alloc] initWithHandler:self responseData:regionData];
                    [childrenArray addObject:region];
                }
                self.regionChildren = childrenArray;
            }
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.parentId = [aDecoder decodeObjectForKey:@"parentId"];
        self.regionId = [aDecoder decodeObjectForKey:@"regionId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.leaf = [aDecoder decodeBoolForKey:@"leaf"];
        self.regionChildren = [aDecoder decodeObjectForKey:@"regionChildren"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.parentId forKey:@"parentId"];
    [aCoder encodeObject:self.regionId forKey:@"regionId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeBool:self.leaf forKey:@"leaf"];
    [aCoder encodeObject:self.regionChildren forKey:@"regionChildren"];
}
@end
