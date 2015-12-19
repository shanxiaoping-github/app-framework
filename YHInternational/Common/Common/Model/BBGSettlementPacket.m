//
//  BBGSettlementPacket.m
//  Common
//
//  Created by Timmy OuYang on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlementPacket.h"
#import "BBGProductCartPromotion.h"
#import "BBGCartProduct.h"
#import "BBGCoupon.h"

@implementation BBGSettlementPacket

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.shopId, @"shopId")
        STRING_FOR_KEY(self.shopName, @"shopName")
        INTEGER_FOR_KEY(self.totalPrice, @"totalPrice")
        INTEGER_FOR_KEY(self.totalFreight, @"totalFreight")
        INTEGER_FOR_KEY(self.totalPmt, @"totalPmt")
        INTEGER_FOR_KEY(self.totalRealPrice, @"totalRealPrice")
        INTEGER_FOR_KEY(self.totalTariff, @"totalTariff")
        FLOAT_FOR_KEY(self.productWeight, @"productWeight")
        FLOAT_FOR_KEY(self.totalWeight, @"totalWeight")
        
        //商品列表
        BBGResponseData *productsData;
        DATA_FOR_KEY(productsData, @"products")
        NSInteger productsCount = productsData.count;
        NSMutableArray *productsArray = [NSMutableArray arrayWithCapacity:productsCount];
        for (int j=0; j<productsCount; j++) {
            BBGResponseData *productData;
            DATA_FOR_INDEX_DATA(productData, j, productsData)
            BBGCartProduct *product = [[BBGCartProduct alloc] initWithHandler:self responseData:productData];
            [productsArray addObject:product];
        }
        
        //赠品列表（加入商品列表后面，通过type是否为“1”判断）
        BBGResponseData *giftsData;
        DATA_FOR_KEY(giftsData, @"gifts")
        NSInteger giftsCount = giftsData.count;
        for (int j=0; j<giftsCount; j++) {
            BBGResponseData *giftData;
            DATA_FOR_INDEX_DATA(giftData, j, giftsData)
            BBGCartProduct *gift = [[BBGCartProduct alloc] initWithHandler:self responseData:giftData];
            [productsArray addObject:gift];
        }
        self.products = productsArray;

        //优惠活动列表
        BBGResponseData *promotionsData;
        DATA_FOR_KEY(promotionsData, @"promotions")
        NSInteger promotionCount = promotionsData.count;
        NSMutableArray *promotionsArray = [NSMutableArray arrayWithCapacity:promotionCount];
        for (int i = 0; i<promotionCount; i++) {
            BBGResponseData *promotionData;
            DATA_FOR_INDEX_DATA(promotionData, i, promotionsData)
            BBGProductCartPromotion *promotion = [[BBGProductCartPromotion alloc] initWithHandler:self responseData:promotionData];
            [promotionsArray addObject:promotion];
        }
        self.promotions = promotionsArray;

        //使用的优惠券对象
        BBGResponseData *userCouponData;
        DATA_FOR_KEY(userCouponData, @"useCoupon")
        BBGCoupon *coupon = [[BBGCoupon alloc] initWithHandler:self responseData:userCouponData];
        STRING_FOR_KEY_DATA(coupon.couponName, @"cpnsName", userCouponData)
        
        self.userCoupon = coupon;
        
    }
    return self;
}
@end
