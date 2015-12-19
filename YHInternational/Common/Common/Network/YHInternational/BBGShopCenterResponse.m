//
//  BBGShopCenterResponse.m
//  Common
//
//  Created by Damon on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShopCenterResponse.h"

@implementation BBGShopCenterResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        /*!
         *  推荐单品
         */
//        NSMutableArray * recommendArray = [NSMutableArray array];
//        BBGResponseData * recommendProductArray;
//        DATA_FOR_KEY_DATA(recommendProductArray, @"recommendProduct", responseData)
//        for (int i = 0; i < [recommendProductArray count]; i++) {
//            BBGResponseData * recommendItemData;
//            DATA_FOR_INDEX_DATA(recommendItemData, i, recommendProductArray)
//            BBGRecommendProduct * product = [[BBGRecommendProduct alloc] initWithHandler:self responseData:recommendItemData];
//            [recommendArray addObject:product];
//        }
//        self.recommendProductArray = recommendArray;
        
        /*!
         *  公告
         */
        NSMutableArray * announcementArray = [NSMutableArray array];
        BBGResponseData * announcementInfoArray;
        DATA_FOR_KEY_DATA(announcementInfoArray, @"announcement", responseData)
        for (int i = 0; i < [announcementInfoArray count]; i++) {
            BBGResponseData * announcementData;
            DATA_FOR_INDEX_DATA(announcementData, i, announcementInfoArray)
            NSString * announcementInfo;
            STRING_FOR_KEY_DATA(announcementInfo, @"info", announcementData)
            [announcementArray addObject:announcementInfo];
        }
        self.announcementArray = announcementArray;
        
        /*!
         *  轮播图
         */
        NSMutableArray * advArray = [NSMutableArray array];
        BBGResponseData * advInfoArray;
        DATA_FOR_KEY_DATA(advInfoArray, @"slid", responseData)
        for (int i = 0; i < [advInfoArray count]; i++) {
            BBGResponseData * advInfoItem;
            DATA_FOR_INDEX_DATA(advInfoItem, i, advInfoArray)
            BBGAdvProduct * advProduct = [[BBGAdvProduct alloc]initWithHandler:self responseData:advInfoItem];
            [advArray addObject:advProduct];
        }
        self.advArray = advArray;
        
        NSMutableArray * topicArray = [NSMutableArray array];
        BBGResponseData * topicInfoArray;
        DATA_FOR_KEY_DATA(topicInfoArray, @"reclist", responseData)
        for (int i = 0; i < [topicInfoArray count]; i++) {
            BBGResponseData * topicInfoItem;
            DATA_FOR_INDEX_DATA(topicInfoItem, i, topicInfoArray)
            BBGTopic * topic = [[BBGTopic alloc]initWithHandler:self responseData:topicInfoItem];
            [topicArray addObject:topic];
        }
        self.topicArray = topicArray;
        
    }
    return self;
}

@end
