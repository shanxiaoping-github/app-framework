//
//  BBGGoodsListResponse.m
//  Common
//
//  Created by Timmy Ouyang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsListResponse.h"
#import "BBGProduct.h"

@implementation BBGGoodsListResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {

    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")

        BBGResponseData *productsData;
        DATA_FOR_KEY_DATA(productsData, @"goods", data)
    }
    return self;
}
@end
