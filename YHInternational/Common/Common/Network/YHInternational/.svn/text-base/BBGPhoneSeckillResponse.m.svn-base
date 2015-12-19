//
//  BBGPhoneSeckillResponse.m
//  Common
//
//  Created by 彭腾 on 15/7/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneSeckillResponse.h"
#import "BBGPhoneSeckillModel.h"

@implementation BBGPhoneSeckillResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format] ;
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data1;
        DATA_FOR_KEY(data1, @"data")
        
        if ([data1 count]) {
            _phoneSeckillArr = [NSMutableArray arrayWithCapacity:[data1 count]];
            
            for (NSInteger i = 0; i < [data1 count]; i++) {
                BBGResponseData *phone;
                DATA_FOR_INDEX_DATA(phone, i, data1)
                
                BBGPhoneSeckillModel *model = [[BBGPhoneSeckillModel alloc]initWithHandler:self responseData:phone];
                [_phoneSeckillArr addObject:model];
            }
        }
    }
    return self ;
}

@end
