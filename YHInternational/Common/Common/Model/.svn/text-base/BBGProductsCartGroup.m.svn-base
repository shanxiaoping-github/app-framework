//
//  BBGProductsCartGroup.m
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGProductsCartGroup.h"
#import "Common.h"
#import "BBGCartProduct.h"
#import "BBGProductCartPromotion.h"
//#import "BBGCartProduct.h"
@implementation BBGProductsCartGroup

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        FLOAT_FOR_KEY(_totalPrice, @"totalPrice")
        FLOAT_FOR_KEY(_totalFreight, @"totalFreight")
        FLOAT_FOR_KEY(_totalPmt, @"totalPmt")
        FLOAT_FOR_KEY(_productWeight, @"productWeight")
        FLOAT_FOR_KEY(_totalWeight, @"totalWeight")
        FLOAT_FOR_KEY(_totalRealPrice, @"totalRealPrice")
        FLOAT_FOR_KEY(_totalTariff, @"totalTariff")
        STRING_FOR_KEY(_shopId, @"shopId")
        STRING_FOR_KEY(_shopName, @"shopName")
        INTEGER_FOR_KEY(_shopType, @"shopType")
        INTEGER_FOR_KEY(_tipStatus, @"tipStatus")
        INTEGER_FOR_KEY(_selected, @"selected");
        
        self.products = [[NSMutableArray alloc] init];
        
        BBGResponseData *productsData;
        DATA_FOR_KEY(productsData, @"products")
        for (int i=0; i<[productsData count]; i++) {
            BBGResponseData *product;
            DATA_FOR_INDEX_DATA(product, i, productsData);
            BBGCartProduct *productModel = [[BBGCartProduct alloc]initWithHandler:self responseData:product];
            [self.products ARRAY_ADD_OBJ(productModel)];
        }
        
        self.promotions = [[NSMutableArray alloc] init];
        
        BBGResponseData *promotionsData;
        DATA_FOR_KEY(promotionsData, @"promotions")
        for (int i=0; i<[promotionsData count]; i++) {
            BBGResponseData *promotion;
            DATA_FOR_INDEX_DATA(promotion, i, promotionsData);
            BBGProductCartPromotion *promotionModel = [[BBGProductCartPromotion alloc]initWithHandler:self responseData:promotion];
            [self.promotions ARRAY_ADD_OBJ(promotionModel)];
        }
    
// 赠品信息
        BBGResponseData *giftsList ;
        DATA_FOR_KEY(giftsList, @"gifts")
        if ([giftsList count]) {
            _giftsList = [NSMutableArray arrayWithCapacity:[giftsList count]] ;
            
            for (NSInteger i = 0; i < [giftsList count]; i++) {
                BBGResponseData *gifts ;
                DATA_FOR_INDEX_DATA(gifts, i, giftsList)
                
                BBGCartProduct *bbgGifts = [[BBGCartProduct alloc]initWithHandler:self responseData:gifts] ;
                [_giftsList addObject:bbgGifts] ;
            }
        }
        
        

//        BBGResponseData *promotionsData;
//        DATA_FOR_KEY(promotionsData, @"promotions")
//        for (int i=0; i<3; i++) {
//            BBGResponseData *promotion;
//            DATA_FOR_INDEX_DATA(promotion, i, promotionsData);
//            BBGProductCartPromotion *promotionModel = [[BBGProductCartPromotion alloc]initWithHandler:self responseData:promotion];
//            promotionModel.ad = [NSString stringWithFormat:@"第 :%d 个优惠",i];
//            [self.promotions ARRAY_ADD_OBJ(promotionModel)];
//        }
        
    }
    return self;
}

@end
