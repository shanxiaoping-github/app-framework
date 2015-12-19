//
//  BBGLogisticsResponse.m
//  Common
//
//  Created by Damon on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLogisticsResponse.h"
#import "BBGOrderInfo.h"
#import "BBGOrderTrack.h"
@implementation BBGLogisticsResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        BBGResponseData * listData;
        DATA_FOR_KEY_DATA(listData, @"data", responseData)
        
        NSMutableArray * orderListArray = [NSMutableArray array];
        
        for (int i = 0; i < [listData count]; i++) {
            BBGResponseData * listItemData;
            DATA_FOR_INDEX_DATA(listItemData, i, listData)
            NSMutableArray * set = [[NSMutableArray alloc]init];
            BBGOrderInfo * orderInfo = [[BBGOrderInfo alloc]initWithHandler:self responseData:listItemData];
            [set addObject:orderInfo];
            
            NSMutableArray * trackArray = [NSMutableArray array];
            BBGResponseData * trackListData;
            DATA_FOR_KEY_DATA(trackListData, @"tracks", listItemData)
            for (int j = 0; j < [trackListData count]; j++) {
                BBGResponseData * trackItemData;
                DATA_FOR_INDEX_DATA(trackItemData, j, trackListData)
                BBGOrderTrack * track = [[BBGOrderTrack alloc] initWithHandler:self responseData:trackItemData];
                [trackArray addObject:track];
            }
            
            [set addObject:trackArray];
            
            [orderListArray addObject:set];
        }
        
        self.ordersLogisticsList = orderListArray;
    }
    return self;
}
@end
