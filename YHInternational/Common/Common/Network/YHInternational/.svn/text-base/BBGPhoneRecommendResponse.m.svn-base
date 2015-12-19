//
//  BBGPhoneRecommendResponse.m
//  Common
//
//  Created by 黄 灿 on 15/7/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneRecommendResponse.h"
#import "BBGSecondsKillProduct.h"
#import "BBGSearchProduct.h"
@implementation BBGPhoneRecommendResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *responseData;
        DATA_FOR_KEY(responseData, @"data")
        self.totalCount=[responseData count];
        if (self.totalCount == 0) {
            return self;
        }
        
 
        

        
        //商品列表
        NSInteger productCount = [responseData count];
        NSMutableArray *products = [NSMutableArray arrayWithCapacity:productCount];
        for (int i = 0; i < productCount; i ++) {
            BBGResponseData *productData;
            DATA_FOR_INDEX_DATA(productData, i, responseData)
            BBGSearchProduct *product =[BBGSearchProduct new];
            
            STRING_FOR_KEY_DATA(product.productID, @"productId", productData)
            STRING_FOR_KEY_DATA(product.productName, @"productName", productData)
            STRING_FOR_KEY_DATA(product.productImageURL, @"imageUrl", productData)
            INTEGER_FOR_KEY_DATA(product.store, @"store", productData)
            FLOAT_FOR_KEY_DATA(product.crossedPrice, @"crossedPrice", productData)
            FLOAT_FOR_KEY_DATA(product.unCrossedPrice, @"unCrosedPrice", productData)
            STRING_FOR_KEY_DATA(product.countryFlag, @"countryFlag", productData)
            INTEGER_FOR_KEY_DATA(product.praiseCount, @"praiseCount", productData)
            INTEGER_FOR_KEY_DATA(product.commentCount, @"commentCount", productData)
            STRING_FOR_KEY_DATA(product.goodsExplain, @"goodsExplain", productData)
            STRING_FOR_KEY_DATA(product.produceCountry, @"produceCountry", productData)
            INTEGER_FOR_KEY_DATA(product.goodsStatus, @"goodsStatus", productData)
            [products addObject:product];
        }
        self.products = products;
        
    }
    return self;
}

@end
