//
//  BBGIndexRecomendResponse.m
//  Common
//
//  Created by 黄 灿 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIndexRecomendResponse.h"

@implementation BBGIndexRecomendResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        /*!
         *  主推单品
         */
        NSMutableArray * recommendArray = [NSMutableArray array];
        BBGResponseData * recommendProductArray;
        DATA_FOR_KEY_DATA(recommendProductArray, @"mainProducts", responseData)
        for (int i = 0; i < [recommendProductArray count]; i++) {
            BBGResponseData * recommendItemData;
            DATA_FOR_INDEX_DATA(recommendItemData, i, recommendProductArray)
            BBGRecommendProduct * product = [[BBGRecommendProduct alloc] initWithHandler:self responseData:recommendItemData];
            [recommendArray addObject:product];
        }
        self.mainPruductArray = recommendArray;
        
        /*!
         *  公告
         */
        NSMutableArray * announcementArray = [NSMutableArray array];
        BBGResponseData * announcementInfoArray;
        DATA_FOR_KEY_DATA(announcementInfoArray, @"acs", responseData)
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
        DATA_FOR_KEY_DATA(advInfoArray, @"chars", responseData)
        for (int i = 0; i < [advInfoArray count]; i++) {
            BBGResponseData * advInfoItem;
            DATA_FOR_INDEX_DATA(advInfoItem, i, advInfoArray)
            BBGAdvProduct * advProduct = [[BBGAdvProduct alloc]initWithHandler:self responseData:advInfoItem];
            [advArray addObject:advProduct];
        }
        self.advArray = advArray;
        
      
        /**
         *  主推广告
         */
        NSMutableArray *mainAdarray  = [NSMutableArray array];
        BBGResponseData *mianAdInfoArray;
        DATA_FOR_KEY_DATA(mianAdInfoArray, @"mainAds", responseData);
        for (int i =0; i<[mianAdInfoArray count]; i++) {
            BBGResponseData *mainAdvItem;
            DATA_FOR_INDEX_DATA(mainAdvItem, i, mianAdInfoArray);
            BBGAdvProduct *mainAd  = [[BBGAdvProduct alloc]initWithHandler:self responseData:mainAdvItem];
            [mainAdarray addObject:mainAd];
        }
        self.mainAdArray=mainAdarray;
        
        /**
         *  普通广告
         */
        NSMutableArray *normalAdarray  = [NSMutableArray array];
        BBGResponseData *normalAdInfoArray;
        DATA_FOR_KEY_DATA(normalAdInfoArray, @"commonAds", responseData);
        for (int i =0; i<[normalAdInfoArray count]; i++) {
            BBGResponseData *normalAdvItem;
            DATA_FOR_INDEX_DATA(normalAdvItem, i, normalAdInfoArray);
            BBGAdvProduct *normalAd  = [[BBGAdvProduct alloc]initWithHandler:self responseData:normalAdvItem];
            [normalAdarray addObject:normalAd];
        }
        self.normalAd=normalAdarray;

        /**
         *  首页入口图
         */
        
        NSMutableArray *brandImg = [NSMutableArray array];
        BBGResponseData *brandData;
        DATA_FOR_KEY_DATA(brandData, @"configures", responseData);
        for (int i=0; i<[brandData count]; i++) {
            BBGResponseData *itemData;
            DATA_FOR_INDEX_DATA(itemData, i, brandData);
            BBGIndexRecomendInitInfo *initInfo = [[BBGIndexRecomendInitInfo alloc]initWithHandler:self responseData:itemData];
            [brandImg addObject:initInfo];
        }
        self.brandInit=brandImg;
        
        
        /**
         *  秒杀单品
         */
        NSMutableArray *secArray = [NSMutableArray array];
        BBGResponseData *secArrayData;
        DATA_FOR_KEY_DATA(secArrayData, @"secKillActivity", responseData);
        if ([secArrayData isNull]) {
            return self;
        }
        BBGResponseData *modifyDate;
        DATA_FOR_KEY_DATA(modifyDate, @"modifyDate", secArrayData)
        
        DATA_FOR_KEY_DATA(secArrayData, @"products", secArrayData)
        for (int i=0 ; i<[secArrayData count]; i++) {
            BBGResponseData *itemData;
            DATA_FOR_INDEX_DATA(itemData, i, secArrayData);
            BBGSecKillProduct *seckill = [ [BBGSecKillProduct alloc]initWithHandler:self responseData:itemData];
            seckill.modifyDate=modifyDate.data;
            if ([secArray count]<10) {
                [secArray addObject:seckill];
            }
            
        }
        self.SecKillArray = secArray;
        
        
       
        
    }
        
    return self;

}
@end
