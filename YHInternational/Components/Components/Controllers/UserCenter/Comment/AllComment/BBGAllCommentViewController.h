//
//  BBGAllCommentViewController.h
//  Components
//
//  Created by Holyjoy on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGAllCommentViewController : BBGViewController

@property (nonatomic,strong) NSString *goodsId;
@property (nonatomic,strong) NSString *goodsDesc;
@property (nonatomic,strong) NSString *goodsImgString;
@property (nonatomic,strong) NSString *goodsPrice;
/**
 *  页码，默认为1
 */
@property (nonatomic,assign)NSInteger pageIndex;
/**
 *  每页商品数，默认为20
 */
@property (nonatomic,assign)NSInteger pageSize;
/**
 *  @author holyjoy, 15-04-29 16:04:43
 *
 *  与某商品相关的评论和回复
 */
@property (nonatomic,strong) NSMutableArray *commentArray;

/**
 *  @author holyjoy, 15-05-04 20:05:05
 *
 *  回复评论是否成功
 */
@property (nonatomic,assign) BOOL sendReplySucessful;
/**
 *  @author holyjoy, 15-05-06 13:05:08
 *
 *  回复时对应的商品id
 */
@property (nonatomic,strong) NSString *replyToGoodsId;
/**
 *  @author holyjoy, 15-05-06 13:05:29
 *
 *  回复的文字
 */
@property (nonatomic,strong) NSString *replyToText;
/**
 *  @author holyjoy, 15-04-30 16:04:01
 *
 *  回复对应的评论ID（回复谁）
 */
@property (nonatomic,strong) NSString *forCommentId;

/**
 *  @author holyjoy, 15-05-11 19:05:19
 *
 *  Yes为个人中心全部评论，no为商品详情全部评论
 */
@property (nonatomic,assign) BOOL isFromUserCenter;

/**
 *  @author holyjoy, 15-05-12 15:05:24
 *
 *  商品详情时发表评论是否发送成功
 */
@property (nonatomic,assign) BOOL evaluateSucessful;
/**
 *  是否能加载更多
 */
@property (nonatomic, assign) BOOL canLoadMore;

- (void)sendReply:(LoadDataCallback)callback;

- (void)sendEvaluate:(LoadDataCallback)callback;

@end
