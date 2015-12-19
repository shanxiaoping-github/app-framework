//
//  BBGSubmitOrderResponse.m
//  Common
//
//  Created by Timmy OuYang on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSubmitOrderResponse.h"
#import "BBGCartManager.h"

@implementation BBGSubmitOrderResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")
        NSMutableArray *orderList = [NSMutableArray array];
        for (int i=0; i<data.count; i++) {
            NSString *orderId;
            STRING_FOR_INDEX_DATA(orderId, i, data)
            [orderList addObject:orderId];
        }
        self.orderIdList = orderList;
        
        //更新购物车badge个数
        [[BBGCartManager sharedInstance] updateCartData];
    }
    return self;
}


@end
