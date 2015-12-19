//
//  BBGOrderDetailResponse.m
//  Common
//
//  Created by elvis.peng on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailResponse.h"

@implementation BBGOrderDetailResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data");
        self.orderDetail = [[BBGOrderInfo alloc] initWithHandler:self responseData:data];
        
    }
    return self;
}
@end
