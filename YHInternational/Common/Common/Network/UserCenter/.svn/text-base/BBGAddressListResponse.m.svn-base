//
//  BBGAddressListResponse.m
//  Common
//
//  Created by Timmy Ouyang on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAddressListResponse.h"
#import "BBGAddress.h"

@implementation BBGAddressListResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *addressesData;
        DATA_FOR_KEY(addressesData, @"data")
        NSInteger addressCount = [addressesData count];
        NSMutableArray *addresseList = [NSMutableArray arrayWithCapacity:addressCount];
        for (int i = 0; i < addressCount; i ++) {
            BBGResponseData *address;
            DATA_FOR_INDEX_DATA(address, i, addressesData)
            BBGAddress *userAddress = [[BBGAddress alloc] initWithHandler:self responseData:address];
            [addresseList addObject:userAddress];
        }
        self.addressList = [[NSMutableArray alloc] initWithArray:addresseList];
    }
    return self;
}

@end
