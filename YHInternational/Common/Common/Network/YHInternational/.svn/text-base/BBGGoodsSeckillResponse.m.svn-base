//
//  BBGGoodsSeckillResponse.m
//  Common
//
//  Created by 彭腾 on 15/10/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsSeckillResponse.h"
#import "BBGGoodsDetailImages.h"

@implementation BBGGoodsSeckillResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *responseData;
        DATA_FOR_KEY(responseData, @"data")
        BOOL_FOR_KEY_DATA(self.isLogin, @"login", responseData);
        
        BBGResponseData *seckillData;
        DATA_FOR_KEY_DATA(seckillData, @"seckill", responseData)
        self.seckill = [[BBGGSSeckillModel alloc]initWithHandler:self responseData:seckillData];
        
        BBGResponseData *goodsData;
        DATA_FOR_KEY_DATA(goodsData, @"goods", responseData)
        self.basicInfo = [[BBGGoodsBasicInfo alloc]initWithHandler:self responseData:goodsData];
        
        BBGResponseData *goodsImage;
        DATA_FOR_KEY_DATA(goodsImage, @"goodsImages", goodsData)
        if ([goodsImage count]) {
            self.goodsImagesArr = [NSMutableArray arrayWithCapacity:[goodsImage count]] ;
            
            for (NSInteger i = 0; i < [goodsImage count]; i++) {
                BBGResponseData *goodsImg ;
                DATA_FOR_INDEX_DATA(goodsImg, i, goodsImage)
                
                BBGGoodsDetailImages *bbgGoodsImages = [[BBGGoodsDetailImages alloc]initWithHandler:self responseData:goodsImg];
                [_goodsImagesArr addObject:bbgGoodsImages] ;
            }
        }
        
        BBGResponseData *addrData;
        DATA_FOR_KEY_DATA(addrData, @"addrs", responseData)
        if ([addrData count]) {
            self.addressArr = [NSMutableArray arrayWithCapacity:[addrData count]];
            
            for (NSInteger i = 0; i < [addrData count]; i++) {
                BBGResponseData *addr;
                DATA_FOR_INDEX_DATA(addr, i, addrData)
                
                BBGAddress *address = [[BBGAddress alloc]initWithHandler:self responseData:addr];
                [_addressArr addObject:address];
            }
        }
    }
    return self;
}

@end
