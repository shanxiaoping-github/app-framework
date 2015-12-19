//
//  BBGAddAdressResponse.m
//  Common
//
//  Created by BubuGao on 15-4-23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAddAdressResponse.h"

@implementation BBGAddAdressResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData * data;
        DATA_FOR_KEY(data, @"data")
        BBGAddress *address = [[BBGAddress alloc] initWithHandler:self responseData:data];
        self.address = address;
    }
    return self;
}

@end
