//
//  BBGProductsCart.m
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGProductsCart.h"
#import "Common.h"

@implementation BBGProductsCart

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")
        
        FLOAT_FOR_KEY_DATA(_totalPrice, @"totalPrice",data)
        FLOAT_FOR_KEY_DATA(_totalFreight, @"totalFreight",data)
        FLOAT_FOR_KEY_DATA(_totalPmt, @"totalPmt",data)
        FLOAT_FOR_KEY_DATA(_productWeight, @"productWeight",data)
        FLOAT_FOR_KEY_DATA(_totalWeight, @"totalWeight",data)
        FLOAT_FOR_KEY_DATA(_totalRealPrice, @"totalRealPrice",data)
        FLOAT_FOR_KEY_DATA(_totalTariff, @"totalTariff",data)
        INTEGER_FOR_KEY_DATA(_totalType, @"totalType",data)
        INTEGER_FOR_KEY_DATA(_totalQuantity, @"totalQuantity",data)
        INTEGER_FOR_KEY_DATA(_selected, @"selected",data)
        
        
        self.groups = [[NSMutableArray alloc] init];
        
        BBGResponseData *groupsData;
        DATA_FOR_KEY_DATA(groupsData, @"groups",data)
        for (int i=0; i<[groupsData count]; i++) {
            BBGResponseData *group;
            DATA_FOR_INDEX_DATA(group, i, groupsData);
            BBGProductsCartGroup *groupModel = [[BBGProductsCartGroup alloc]initWithHandler:self responseData:group];
            [self.groups ARRAY_ADD_OBJ(groupModel)];
        }
        
    
    }
    return self;
}

@end
