//
//  BBGPayInfoResponse.m
//  Common
//
//  Created by elvis.peng on 15-5-18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayInfoResponse.h"

@implementation BBGPayInfoResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *paymentInfoData;
        DATA_FOR_KEY(paymentInfoData, @"data");
        self.paymentInfo = [[BBGPaymentInfo alloc] initWithHandler:self responseData:paymentInfoData];
    }
    return self;
}
@end
