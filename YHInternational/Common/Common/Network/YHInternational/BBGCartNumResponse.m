//
//  BBGCartNumResponse.m
//  Common
//
//  Created by 彭腾 on 15/5/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCartNumResponse.h"

@implementation BBGCartNumResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        BBGCartNumModel *model = [[BBGCartNumModel alloc]initWithHandler:self responseData:responseData] ;
        _cartNum = model ;
        
    }
    return self;
}

@end
