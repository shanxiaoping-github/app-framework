//
//  BBGSearchProduct.m
//  Common
//
//  Created by calvin on 14-8-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSearchProduct.h"

@implementation BBGSearchProduct

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.goodsID, @"goodsId")
        STRING_FOR_KEY(self.productID, @"productId")
        STRING_FOR_KEY(self.productName, @"goodsName")
        STRING_FOR_KEY(self.productImageURL, @"goodsImageUrl")
        STRING_FOR_KEY(self.productBN, @"goodsBn")
        INTEGER_FOR_KEY(self.storeCount,@"storeCount")
        STRING_FOR_KEY(self.shopName, @"shopName")
        STRING_FOR_KEY(self.promotionInfo, @"activityText")
        INTEGER_FOR_KEY(self.productType, @"productType")
        FLOAT_FOR_KEY(self.crossedPrice, @"crossedPrice")
        FLOAT_FOR_KEY(self.unCrossedPrice, @"unCrossedPrice")
        
        self.labelsArray = [[NSMutableArray alloc]initWithCapacity:0];
        //解析商品标签
        if (![self.responseData isNullForKey:@"labels"]) {
            BBGResponseData *labels;
            DATA_FOR_KEY(labels, @"labels")
            for (int i = 0; i < [labels count]; i++) {
                BBGResponseData *label;
                DATA_FOR_INDEX_DATA(label, i, labels);
                BBGProductTag *tag = [[BBGProductTag alloc]initWithHandler:self responseData:label];
                [self.labelsArray addObject:tag];
            }
        }
        //如果库存为0，也是一个特殊的tag
        
        if (self.storeCount <= 0) {
            NSDictionary *storeLabelData = @{@"location":@(3),@"isShow":@(YES),@"labelName":@"售馨",@"labelId":@"1",@"transparency":@(0.5),@"bgColor":@"#f90033",@"wordColor":@"#ffffff"};
            BBGResponseData *storeData = [[BBGResponseData alloc] initWithData:storeLabelData];
            BBGProductTag *tag = [[BBGProductTag alloc]initWithHandler:self responseData:storeData];
            [self.labelsArray addObject:tag];
        }
    }
    return self;
}

@end
