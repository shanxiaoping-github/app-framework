//
//  BBGBeautyEffectResponse.m
//  Common
//
//  Created by 彭腾 on 15/7/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBeautyEffectResponse.h"
#import "BBGBeautyEffectModel.h"

@implementation BBGBeautyEffectResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format] ;
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data1;
        DATA_FOR_KEY(data1, @"data")
        
        if ([data1 count]) {
            _beautyArr = [NSMutableArray arrayWithCapacity:[data1 count]];
            
            for (NSInteger i = 0; i < [data1 count]; i++) {
                BBGResponseData *beauty;
                DATA_FOR_INDEX_DATA(beauty, i, data1)
                
                BBGBeautyEffectModel *model = [[BBGBeautyEffectModel alloc]initWithHandler:self responseData:beauty];
                [_beautyArr addObject:model];
            }
        }
    }
    return self ;
}

@end
