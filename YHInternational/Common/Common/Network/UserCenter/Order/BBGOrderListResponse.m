//
//  BBGOrderListResponse.m
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderListResponse.h"

@implementation BBGOrderListResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")
        
        
        INTEGER_FOR_KEY_DATA(self.currentPage, @"pageNo",data)
        INTEGER_FOR_KEY_DATA(self.totalSize, @"totalSize",data)
        BBGResponseData *orderListData;
        DATA_FOR_KEY_DATA(orderListData,@"data",data)
        if (orderListData && [orderListData count]>0) {
            self.orderList = [NSMutableArray arrayWithCapacity:[orderListData count]];
            for (int i = 0; i<[orderListData count]; i++) {
                BBGResponseData *orderInfoData;
                DATA_FOR_INDEX_DATA(orderInfoData, i, orderListData)
                BBGOrderInfo *orderInfo = [[BBGOrderInfo alloc] initWithHandler:self responseData:orderInfoData];
                [self.orderList addObject:orderInfo];
                
            }
        }
    }
    return self;
}
@end
