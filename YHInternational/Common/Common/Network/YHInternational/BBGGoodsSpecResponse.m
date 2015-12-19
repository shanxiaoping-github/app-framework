//
//  BBGGoodsSpecResponse.m
//  Common
//
//  Created by 彭腾 on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsSpecResponse.h"
#import "BBGGoodsSpecQuery.h"
#import "BBGGoodsSpecInfo.h"

@implementation BBGGoodsSpecResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        BBGResponseData *data1 ;
        DATA_FOR_KEY(data1, @"data")
        
        BBGResponseData *skuNamesList ;
        DATA_FOR_KEY_DATA(skuNamesList, @"skuNames", data1)

        
        if ([skuNamesList count]) {
            _specQueryArr = [NSMutableArray arrayWithCapacity:[skuNamesList count]] ;
            
            for (NSInteger i = 0; i < [skuNamesList count]; i++) {
                BBGResponseData *specQuery ;
                DATA_FOR_INDEX_DATA(specQuery, i, skuNamesList) ;
                
                BBGGoodsSpecQuery *bbgSpecQuery = [[BBGGoodsSpecQuery alloc]initWithHandler:self responseData:specQuery] ;
                [_specQueryArr addObject:bbgSpecQuery] ;
            }
        }
        
        BBGGoodsSpecInfo *bbgSpecInfo = [[BBGGoodsSpecInfo alloc]initWithHandler:self responseData:data1] ;
        _specInfo = bbgSpecInfo ;
        
    }
    return self;
}

@end
