//
//  BBGMyCommentViewController.h
//  Components
//
//  Created by Holyjoy on 15/4/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGMyCommentViewController : BBGViewController

/**
 *  页码，默认为1
 */
@property (nonatomic,assign)NSInteger pageIndex;
/**
 *  每页商品数，默认为20
 */
@property (nonatomic,assign)NSInteger pageSize;
/**
 *  @author holyjoy, 15-04-29 21:04:49
 *
 *  评论过的商品列表
 */
@property (nonatomic,strong) NSMutableArray *commentedGoodsArray;
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
 *  是否能加载更多
 */
@property (nonatomic, assign) BOOL canLoadMore;


/**
 *  @author holyjoy, 15-05-25 10:05:16
 *
 *  未评论商品数
 */
@property (nonatomic,assign) NSInteger noCommentGoodsNumber;

- (void)sendReply:(LoadDataCallback)callback;

- (void)getCommentDetailCount:(LoadDataCallback)callback;

@end
