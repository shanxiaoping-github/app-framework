//
//  BBGIndexRecommendViewController.h
//  Components
//
//  Created by 黄 灿 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGCartDirectRequest.h"
@interface BBGIndexRecommendViewController : BBGViewController
/**
 *  当前页
 */
@property (nonatomic, assign)NSInteger nowPage;
/**
 *  总共页
 */
@property (nonatomic, assign)NSInteger totalPage;

/**
 *  每页多少个
 */
@property (nonatomic, assign)NSInteger pageNumber;

/**
 *   控制请求的间隔
 */

@property (nonatomic, assign)long lastRequestTime;

/**
 *  基础数据请求
 */
@property (nonatomic, strong) BBGIndexRecomendRequest *request;

/**
 *  单品请求
 */
@property (nonatomic, strong) BBGIndexRecomendMoreRequest *MoreRequest;

/**
 *  加入购物车请求
 */
@property (nonatomic, strong)BBGAddCartRequest *addCartRequet;

/**
 *  立即购买请求
 */
@property (nonatomic, strong)BBGCartDirectRequest *cartDirectRequest;

/**
 *  加入购物车
 *
 *  @param callback
 */
- (void)addCartRequet:(LoadDataCallback)callback;

/**
 *  立即购买
 *
 *  @return callback
 */

- (void)cartDirectRequest:(LoadDataCallback)callback;
/**
 *  请求基本数据
 *
 *  @param callback callback
 */
- (void)getIndexBaseData:(void(^)(BOOL isFinished ,id response))callback;
/**
 *  请求单品数据
 *
 *  @param callback callback
 */
- (void)getindexMoreData:(void(^)(BOOL isFinished ,id response))callback;

/**
 *  购物车图标点击
 */
- (void)buyOrAddInCart:(NSInteger)productType store:(NSInteger)store productId:(NSString *)productId callback:(goSettleMent)callback;

@end
