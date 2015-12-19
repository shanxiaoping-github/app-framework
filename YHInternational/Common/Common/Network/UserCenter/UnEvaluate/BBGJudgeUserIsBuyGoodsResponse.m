//
//  BBGJudgeUserIsBuyGoodsResponse.m
//  Common
//
//  Created by Holyjoy on 15/5/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGJudgeUserIsBuyGoodsResponse.h"
#import "BBGTools.h"

@implementation BBGJudgeUserIsBuyGoodsResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *_data;
        DATA_FOR_KEY(_data, @"data")
        
        STRING_FOR_KEY_DATA(_orderId, @"orderId", _data)
        BOOL_FOR_KEY_DATA(_hasOrder, @"hasOrder", _data)
        
        double orderDate;
        DOUBLE_FOR_KEY_DATA(orderDate, @"orderTime",_data)
        _orderTime = [BBGTools timeToString:orderDate/1000.0 Format:@"YYYY-MM-dd HH:mm:ss"];
    }
    return self;
}

@end
