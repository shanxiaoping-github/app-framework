//
//  MaternalAndBeautyViewController.h
//  Components
//
//  Created by 刘薇 on 15/7/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGCartDirectRequest.h"
#import "BBGMoreMaternalORBeautyRequest.h"
#import "BBGMaternalOrBeautyResponse.h"
#import "BBGIndexRecomendMoreResponse.h"
@interface BBGMaternalAndBeautyViewController : BBGViewController
/*!
 *  1美妆 2母婴 3食品保健
 */
@property (nonatomic, assign) NSInteger tagType;
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
@property (nonatomic, strong) BBGMaternalORBeautyRequest * request;
/**
 *  单品请求
 */
@property (nonatomic, strong) BBGMoreMaternalORBeautyRequest *moreMaternalORBeautyRequest;

@property (strong, nonatomic) BBGMaternalOrBeautyResponse * maternalOrBeautyResponse;
/**
 *  分页单品
 */
@property (nonatomic, strong)BBGIndexRecomendMoreResponse *moreRecommendResponse;


- (void)getMaternalOrBeautyData:(void (^)(BOOL isfinished,id response))callback;
/**
 *  请求单品数据
 *
 *  @param callback callback
 */
- (void)getMoreData:(void(^)(BOOL isFinished ,id response))callback;
/**
 *  加入购物车请求
 */
@property (nonatomic, strong)BBGAddCartRequest *addCartRequet;
/**
 *  是否能加载更多
 */
@property (nonatomic, assign) BOOL canLoadMore;
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
 *  购物车图标点击
 */
- (void)buyOrAddInCart:(NSInteger)productType store:(NSInteger)store productId:(NSString *)productId callback:(goSettleMent)callback;
@end
