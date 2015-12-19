//
//  BBGIndexRecomendMoreResponse.m
//  Common
//
//  Created by 黄 灿 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIndexRecomendMoreResponse.h"
//#import "BBGSecondsKillProduct.h"
@implementation BBGIndexRecomendMoreResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        /*!
         *  普通单品
         */
        NSMutableArray * recommendArray = [NSMutableArray array];
        for (int i = 0; i < [responseData count]; i++) {
            BBGResponseData * recommendItemData;
            DATA_FOR_INDEX_DATA(recommendItemData, i, responseData)
            
            BBGRecommendProduct *product = [[BBGRecommendProduct alloc] initWithHandler:self responseData:recommendItemData];

            [recommendArray addObject:product];
        }
        self.normalPruductArray = recommendArray;
        
          }
    return self;
    
}

@end
