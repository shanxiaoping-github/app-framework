//
//  BBGPhoneSeckillModel.m
//  Common
//
//  Created by 彭腾 on 15/7/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneSeckillModel.h"
#import "BBGSecKillProduct.h"

@implementation BBGPhoneSeckillModel

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        STRING_FOR_KEY(_name, @"name")
        STRING_FOR_KEY(_Id, @"id")
        
        double time;
        DOUBLE_FOR_KEY(time, @"startDate")
        
        NSDate *commentDate = [NSDate dateWithTimeIntervalSince1970:time/1000.0];
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        _startDate  = [df stringFromDate:commentDate];
        
        double time1;
        DOUBLE_FOR_KEY(time1, @"endDate")
        
        NSDate *commentDate1 = [NSDate dateWithTimeIntervalSince1970:time1/1000.0];
        _endDate  = [df stringFromDate:commentDate1];
        
        double time2;
        DOUBLE_FOR_KEY(time2, @"createDate")
        
        NSDate *commentDate2 = [NSDate dateWithTimeIntervalSince1970:time2/1000.0];
        _createDate  = [df stringFromDate:commentDate2];
        
        double time3;
        DOUBLE_FOR_KEY(time3, @"modifyDate")
        
        NSDate *commentDate3 = [NSDate dateWithTimeIntervalSince1970:time3/1000.0];
        _modifyDate = [df stringFromDate:commentDate3];
        
        _products = [[NSMutableArray alloc]initWithCapacity:0];
        if (![self.responseData isNullForKey:@"products"]) {
            BBGResponseData *products;
            DATA_FOR_KEY(products, @"products")
            for (NSInteger i = 0; i < [products count]; i++) {
                BBGResponseData *goods;
                DATA_FOR_INDEX_DATA(goods, i, products);
                BBGSecKillProduct *model = [[BBGSecKillProduct alloc]initWithHandler:self responseData:goods];
                model.modifyDate = _modifyDate;
                [_products addObject:model];
            }
        }
    }
    return self ;
}

@end
