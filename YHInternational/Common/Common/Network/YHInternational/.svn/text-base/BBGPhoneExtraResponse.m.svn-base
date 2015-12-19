//
//  BBGPhoneExtraResponse.m
//  Common
//
//  Created by Timmy OuYang on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneExtraResponse.h"
#import "BBGSearchProduct.h"

@implementation BBGPhoneExtraResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")
        INTEGER_FOR_KEY_DATA(self.totalCount, @"count",data)
        if (self.totalCount == 0) {
            return self;
        }
        
        //商品列表
        BBGResponseData *productsData;
        DATA_FOR_KEY_DATA(productsData, @"goods", data)
        NSInteger productCount = [productsData count];
        NSMutableArray *products = [NSMutableArray arrayWithCapacity:productCount];
        for (int i = 0; i < productCount; i ++) {
            BBGResponseData *productData;
            DATA_FOR_INDEX_DATA(productData, i, productsData)
            BBGSearchProduct *product = [[BBGSearchProduct alloc] initWithHandler:self responseData:productData];
            [products addObject:product];
        }
        self.products = products;

    }
    return self;
}
@end
