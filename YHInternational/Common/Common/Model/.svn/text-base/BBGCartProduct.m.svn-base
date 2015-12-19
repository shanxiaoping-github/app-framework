//
//  BBGCartProduct.m
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCartProduct.h"
#import "Common.h"
#import "BBGProductSpecVo.h"

@implementation BBGCartProduct

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        

        FLOAT_FOR_KEY(_totalPmt, @"totalPmt")
        FLOAT_FOR_KEY(_productWeight, @"productWeight")
        STRING_FOR_KEY(_productId, @"productId")
        STRING_FOR_KEY(_goodsId, @"goodsId")
        
        STRING_FOR_KEY(_productName, @"productName")
        STRING_FOR_KEY(_productImage, @"productImage")
        
        STRING_FOR_KEY(_productAd, @"productAd")
        STRING_FOR_KEY(_barcode, @"barcode")
        
        STRING_FOR_KEY(_bn, @"bn")
        FLOAT_FOR_KEY(_price, @"price")
        FLOAT_FOR_KEY(_salePrice, @"salePrice")
        FLOAT_FOR_KEY(_mktPrice, @"mktprice")
        FLOAT_FOR_KEY(_crossedPrice, @"crossedPrice")
        FLOAT_FOR_KEY(_unCrossedPrice, @"unCrossedPrice")

        STRING_FOR_KEY(_unit, @"unit")
        INTEGER_FOR_KEY(_quantity, @"quantity")
        STRING_FOR_KEY(_shopId, @"shopId")
        INTEGER_FOR_KEY(_shopType, @"shopType")
        INTEGER_FOR_KEY(_stock, @"stock")
        INTEGER_FOR_KEY(_limit, @"limit")
        INTEGER_FOR_KEY(_limitKind, @"limitKind")
        INTEGER_FOR_KEY(_selected, @"selected")
        INTEGER_FOR_KEY(_productStatus, @"productStatus")
        STRING_FOR_KEY(_statusTip, @"statusTip")
        BOOL_FOR_KEY(_sale, @"sale")
        BOOL_FOR_KEY(_favorite, @"favorite")
        STRING_FOR_KEY(_backCatId, @"backCatId")
        INTEGER_FOR_KEY(_buyType, @"buyType")
        BOOL_FOR_KEY(_idCheck, @"idCheck")
        FLOAT_FOR_KEY(_addTime, @"addTime")
        FLOAT_FOR_KEY(_bargainPrice, @"bargainPrice")
        FLOAT_FOR_KEY(_mktprice, @"mktprice")
        FLOAT_FOR_KEY(_tariff, @"tariff")
        INTEGER_FOR_KEY(_type, @"type")
        STRING_FOR_KEY(_targetId, @"targetId")
        INTEGER_FOR_KEY(_num, @"num")
        
        FLOAT_FOR_KEY(_unCrossedPrice, @"unCrossedPrice")
        FLOAT_FOR_KEY(_crossedPrice, @"crossedPrice")

        
        
        self.specList = [[NSMutableArray alloc] init];
        
        BBGResponseData *specListData;
        DATA_FOR_KEY(specListData, @"specList")
        NSMutableArray *specNameArray = [NSMutableArray array];
        for (int i=0; i<[specListData count]; i++) {
            BBGResponseData *productSpecVo;
            DATA_FOR_INDEX_DATA(productSpecVo, i, specListData);
            BBGProductSpecVo *productSpecVoModel = [[BBGProductSpecVo alloc]initWithHandler:self responseData:productSpecVo];
            [specNameArray addObject:productSpecVoModel.value];
            [self.specList ARRAY_ADD_OBJ(productSpecVoModel)];
        }
        if (self.specList.count > 0) {
            self.specNameStr = [specNameArray componentsJoinedByString:@","];
        }else {
            self.specNameStr = @"";
        }

    }
    return self;
}

@end
