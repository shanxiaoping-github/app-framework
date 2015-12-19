//
//  BBGSelectedAddressResponse.m
//  Common
//
//  Created by Timmy OuYang on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSelectedAddressResponse.h"

@implementation BBGSelectedAddressResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")
        
        BBGSettlement *settlement = [[BBGSettlement alloc] initWithHandler:self responseData:data];
        self.settlement = settlement;
    }
    return self;
}
@end
