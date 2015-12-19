//
//  BBGUserCountResponse.m
//  Common
//
//  Created by BubuGao on 15-4-23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserCountResponse.h"
@implementation BBGUserCountResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *responseData;
        DATA_FOR_KEY(responseData, @"data")

        INTEGER_FOR_KEY_DATA(self.unpaidOrderCount, @"unpaidOrderCount", responseData)
        INTEGER_FOR_KEY_DATA(self.waitSendGoodsCount, @"waitSendGoodsCount", responseData)
        INTEGER_FOR_KEY_DATA(self.logisticsCount, @"logisticsCount", responseData)

    }
    return self;
}

@end
