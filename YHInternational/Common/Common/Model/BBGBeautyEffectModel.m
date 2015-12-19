//
//  BBGBeautyEffectModel.m
//  Common
//
//  Created by 彭腾 on 15/7/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBeautyEffectModel.h"

@implementation BBGBeautyEffectModel

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(_catId, @"catId")
        STRING_FOR_KEY(_catName, @"catName")
        BOOL_FOR_KEY(_disabled, @"disabled")
        STRING_FOR_KEY(_parentId, @"parentId")
        STRING_FOR_KEY(_targetType, @"targetType")
        double time;
        DOUBLE_FOR_KEY(time, @"created")
        NSDate *commentDate = [NSDate dateWithTimeIntervalSince1970:time/1000.0];
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        _created  = [df stringFromDate:commentDate];
    }
    return self;
}


@end
