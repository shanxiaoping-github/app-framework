//
//  BBGPraiseProductListResponse.m
//  Common
//
//  Created by yangjie on 15/4/30.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPraiseProductListResponse.h"
#import "BBGPraiseProduct.h"

@implementation BBGPraiseProductListResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *_data;
        DATA_FOR_KEY(_data, @"data")
        DATA_FOR_KEY_DATA(_data, @"data", _data)
        NSInteger productCount = [_data count];
        NSMutableArray *productList = [NSMutableArray arrayWithCapacity:productCount];
        for (int i = 0; i < productCount; i ++) {
            BBGResponseData *productData;
            DATA_FOR_INDEX_DATA(productData, i, _data)
            BBGPraiseProduct *product = [[BBGPraiseProduct alloc] initWithHandler:self responseData:productData];
            [productList addObject:product];
        }
        self.productListArray = [[NSMutableArray alloc] initWithArray:productList];
        
    }
    return self;
}

@end
