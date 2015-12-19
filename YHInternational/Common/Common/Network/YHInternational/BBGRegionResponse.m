//
//  BBGRegionResponse.m
//  Common
//
//  Created by Damon on 15/5/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegionResponse.h"

@implementation BBGRegionResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    
    if (self) {
        if (self.isError) {
            return self;
        }
        //本地数据
        BBGResponseData *resdata;
        DATA_FOR_KEY(resdata, @"data")
        
        //        BBGResponseData *dataArray;
        //        DATA_FOR_KEY_DATA(dataArray, @"children", resdata)
        NSMutableArray *regionList = [NSMutableArray arrayWithCapacity:[resdata count]];
        
        
        NSInteger index = [resdata count] - 1;
        if (resdata && [resdata count]>0) {
            for (NSInteger i = index; i>=0; i--) {
                BBGResponseData *regionData;
                DATA_FOR_INDEX_DATA(regionData, i, resdata)
                BBGRegion *region = [[BBGRegion alloc] initWithHandler:self responseData:regionData];
                [regionList addObject:region];
            }
        }
        
        self.regionList = regionList;
        
        
        
        
        //sql
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        self.operatorList = [NSMutableArray array];
        
        for (int i = 0; i < [responseData count]; i++) {
            BBGResponseData * itemData;
            DATA_FOR_INDEX_DATA(itemData, i, responseData)
            
            NSString * regionId;
            STRING_FOR_KEY_DATA(regionId, @"id", itemData)
            
            NSString * parentId;
            STRING_FOR_KEY_DATA(parentId, @"parentid", itemData)
            
            NSString * name;
            STRING_FOR_KEY_DATA(name, @"name", itemData)
            
            NSString * operator;
            STRING_FOR_KEY_DATA(operator, @"operator", itemData)
            
            NSString * sql;
            
            /**
             *  1为新增
             *  2为删除
             *  3为修改
             */
            if (operator.intValue == 1) {
                sql = [NSString stringWithFormat:@"INSERT INTO regionCache VALUES('%@','%@','%@')",regionId,name,parentId];
            }else if(operator.intValue == 2){
                sql = [NSString stringWithFormat:@"DELETE FROM regionCache WHERE id = '%@'",regionId];
            }else{
                sql = [NSString stringWithFormat:@"UPDATE regionCache SET parentId = '%@',name ='%@' WHERE id = '%@'",parentId,name,regionId];
            }
            if (sql) {
                [self.operatorList addObject:sql];
            }
            
            
            
            
        }
        
        
    }
    return self;
}

@end
