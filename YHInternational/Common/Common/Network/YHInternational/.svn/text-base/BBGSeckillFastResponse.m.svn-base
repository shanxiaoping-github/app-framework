//
//  BBGSeckillFastResponse.m
//  Common
//
//  Created by 彭腾 on 15/10/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSeckillFastResponse.h"

@implementation BBGSeckillFastResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        self.fastModel = [[BBGGSFastModel alloc]initWithHandler:self responseData:responseData];
        
    }
    return self;
}

@end
