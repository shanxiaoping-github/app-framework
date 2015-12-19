//
//  BBGFirstShareResponse.m
//  Common
//
//  Created by 彭腾 on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFirstShareResponse.h"
#import "BBGShareModel.h"

@implementation BBGFirstShareResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        BBGShareModel *share = [[BBGShareModel alloc]initWithHandler:self responseData:responseData] ;
        _shareInfo = share ;
    }
    return self;
}

@end
