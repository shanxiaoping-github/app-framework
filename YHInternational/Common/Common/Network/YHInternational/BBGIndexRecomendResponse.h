//
//  BBGIndexRecomendResponse.h
//  Common
//
//  Created by 黄 灿 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGRecommendProduct.h"
#import "BBGAdvProduct.h"
#import "BBGSecKillProduct.h"
#import "BBGIndexRecomendInitInfo.h"
@interface BBGIndexRecomendResponse : BBGResponse

/*!
 *  文字公告
 */
@property (nonatomic, strong) NSArray *announcementArray;
/*!
 *  轮播图
 */
@property (nonatomic, strong) NSArray *advArray;
/*!
 *  秒杀单品
 */
@property (nonatomic, strong) NSArray *SecKillArray;

/**
 *  主推广告
 */
@property (nonatomic, strong) NSArray *mainAdArray;

/**
 *  主推单品
 */
@property (nonatomic, strong) NSArray *mainPruductArray;

/**
 *  普通广告
 */
@property (nonatomic, strong) NSArray *normalAd;

/**
 *  首页推荐6个入口图
 */

@property (nonatomic, strong) NSArray *brandInit;
@end
