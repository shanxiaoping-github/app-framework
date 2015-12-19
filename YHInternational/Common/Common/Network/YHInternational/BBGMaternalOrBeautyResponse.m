//
//  BBGMaternalOrBeautyResponse.m
//  Common
//
//  Created by 刘薇 on 15/7/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMaternalOrBeautyResponse.h"
#import "BBGRecommendProduct.h"
#import "BBGIndexRecomendInitInfo.h"
@implementation BBGMaternalOrBeautyResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        
        /*!
         *  轮播图 chars
         */
        NSMutableArray * advArray = [NSMutableArray array];
        BBGResponseData * advInfoArray;
        DATA_FOR_KEY_DATA(advInfoArray, @"chars", responseData)
        for (int i = 0; i < [advInfoArray count]; i++) {
            BBGResponseData * advInfoItem;
            DATA_FOR_INDEX_DATA(advInfoItem, i, advInfoArray)
            BBGAdvProduct * advProduct = [[BBGAdvProduct alloc]initWithHandler:self responseData:advInfoItem];
            [advArray addObject:advProduct];
        }
        self.advArray = advArray;
//       专题页ads
        NSMutableArray * topicArray = [NSMutableArray array];
        BBGResponseData * topicInfoArray;
        DATA_FOR_KEY_DATA(topicInfoArray, @"ads", responseData)
        for (int i = 0; i < [topicInfoArray count]; i++) {
            BBGResponseData * topicInfoItem;
            DATA_FOR_INDEX_DATA(topicInfoItem, i, topicInfoArray)
            BBGAdvProduct * topic = [[BBGAdvProduct alloc]initWithHandler:self responseData:topicInfoItem];
            [topicArray addObject:topic];
        }
        self.topicArray = topicArray;
        
        /*!
         *  推荐单品products
         */
        NSMutableArray * recommendArray = [NSMutableArray array];
        BBGResponseData * recommendProductArray;
        DATA_FOR_KEY_DATA(recommendProductArray, @"products", responseData)
        for (int i = 0; i < [recommendProductArray count]; i++) {
            BBGResponseData * recommendItemData;
            DATA_FOR_INDEX_DATA(recommendItemData, i, recommendProductArray)
//            BBGSecondsKillProduct * product = [[BBGSecondsKillProduct alloc] initWithHandler:self responseData:recommendItemData];
             BBGRecommendProduct * product = [[BBGRecommendProduct alloc] initWithHandler:self responseData:recommendItemData];
            [recommendArray addObject:product];
        }
        self.secondsKillProductArray = recommendArray;

        
        NSMutableArray *brandImg = [NSMutableArray array];
        BBGResponseData *brandData;
        DATA_FOR_KEY_DATA(brandData, @"configures", responseData);
        if ([brandData isNull]) {
            return  self;
        }
        for (int i=0; i<[brandData count]; i++) {
            BBGResponseData *itemData;
            DATA_FOR_INDEX_DATA(itemData, i, brandData);
            BBGIndexRecomendInitInfo *initInfo = [[BBGIndexRecomendInitInfo alloc]initWithHandler:self responseData:itemData];
            [brandImg addObject:initInfo];
        }
        self.brandInit=brandImg;
        
    }
    return self;
}

@end
