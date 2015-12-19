//
//  BBGEditAddressResponse.m
//  Common
//
//  Created by yangjie on 15/5/4.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEditAddressResponse.h"

@implementation BBGEditAddressResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *addressesData;
        DATA_FOR_KEY(addressesData, @"data")
        BBGAddress *address = [[BBGAddress alloc] initWithHandler:self responseData:addressesData];
        self.address = address;
    }
    return self;
}

@end
