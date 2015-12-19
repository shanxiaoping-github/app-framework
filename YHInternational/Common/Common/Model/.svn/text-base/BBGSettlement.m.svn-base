//
//  BBGSettlement.m
//  Common
//
//  Created by Timmy OuYang on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlement.h"
#import "BBGAddress.h"
#import "BBGCartProduct.h"

@implementation BBGSettlement
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.memberId, @"memberId")
        STRING_FOR_KEY(self.tip, @"tip")
        BOOL_FOR_KEY(self.needIdCheck, @"needIdCheck")
        INTEGER_FOR_KEY(self.submitTag, @"submitTag")
        INTEGER_FOR_KEY(self.idCheckType, @"idCheckType")
        INTEGER_FOR_KEY(self.submitCheckTag, @"submitCheckTag")
        INTEGER_FOR_KEY(self.totalPrice, @"totalPrice")
        INTEGER_FOR_KEY(self.totalFreight, @"totalFreight")
        INTEGER_FOR_KEY(self.totalPmt, @"totalPmt")
        INTEGER_FOR_KEY(self.totalRealPrice, @"totalRealPrice")
        INTEGER_FOR_KEY(self.totalTariff, @"totalTariff")
        FLOAT_FOR_KEY(self.productWeight, @"productWeight")
        FLOAT_FOR_KEY(self.totalWeight, @"totalWeight")
        BBGResponseData *addressListData;
        DATA_FOR_KEY(addressListData, @"addresses")
        NSInteger addressCount = [addressListData count];
        NSMutableArray *addressList = [NSMutableArray arrayWithCapacity:addressCount];
        for (int i = 0; i<addressCount; i++) {
            BBGResponseData *addressData;
            DATA_FOR_INDEX_DATA(addressData, i, addressListData)
            BBGAddress *address = [[BBGAddress alloc] initWithHandler:self responseData:addressData];
            [addressList addObject:address];
        }
        self.addressList = addressList;
        
        BBGResponseData *dataGroups;
        DATA_FOR_KEY(dataGroups, @"groups")
        NSInteger count = dataGroups.count;
        NSMutableArray *groupsArray = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i < count; i++) {
            BBGResponseData *packetData;
            DATA_FOR_INDEX_DATA(packetData, i, dataGroups)
            BBGSettlementPacket *packet = [[BBGSettlementPacket alloc] initWithHandler:self responseData:packetData];
            [groupsArray addObject:packet];
        }
        
        self.groups = groupsArray;

        BBGResponseData *unableDataGroups;
        DATA_FOR_KEY(unableDataGroups, @"unableItems")
        NSInteger unableCount = unableDataGroups.count;
        NSMutableArray *unableProductsArray = [NSMutableArray arrayWithCapacity:unableCount];
        for (int i=0; i<unableDataGroups.count; i++) {
            BBGResponseData *productData;
            DATA_FOR_INDEX_DATA(productData, i, unableDataGroups)
            BBGCartProduct *product = [[BBGCartProduct alloc] initWithHandler:self responseData:productData];
            [unableProductsArray addObject:product];
        }
        if (unableProductsArray.count > 0) {
            BBGSettlementPacket *unablePacket = [[BBGSettlementPacket alloc] init];
            unablePacket.shopName = @"以下商品无法配送";
            unablePacket.products = unableProductsArray;
            _unablePacket = unablePacket;
        }

    }
    return self;
}
@end
