//
//  PhoneSeckillViewController.h
//  Components
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGPhoneSeckillRequest.h"
#import "BBGCartDirectRequest.h"
#import "BBGAddCartRequest.h"
@interface BBGPhoneSeckillViewController : BBGViewController
/**
 *  是否加载更多
 */
@property (nonatomic, assign)BOOL isLoadMore;
/**
 *  手机秒杀请求
 */
@property (nonatomic,strong) BBGPhoneSeckillRequest *phoneRequest;
/**
 *  手机秒杀数组
 */
@property (nonatomic,strong) NSMutableArray *phoneSeckillArr;
/**
 *  页码
 */
@property (nonatomic,assign) NSInteger pageIndex;
/**
 *  立即购买请求
 */
@property (nonatomic, strong)BBGCartDirectRequest *cartDirectRequest;
/**
 *  加入购物车请求
 */
@property (nonatomic,strong)BBGAddCartRequest *addCartRequet;
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
