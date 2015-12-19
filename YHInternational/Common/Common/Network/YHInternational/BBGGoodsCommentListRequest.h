//
//  BBGGoodsCommentListRequest.h
//  Common
//
//  Created by Holyjoy on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGGoodsCommentListRequest : BBGRequest
- (id)initWithFromUserCenter:(BOOL)FromUserCenter;
/**
 *  @author holyjoy, 15-05-06 19:05:11
 *
 *  商品id
 */
@property (nonatomic,strong) NSString *goodsId;
/**
 *  @author holyjoy, 15-04-23 16:04:49
 *
 *  第几页
 */
@property (nonatomic,assign) NSInteger pageNumber;

/**
 *  @author holyjoy, 15-04-23 16:04:45
 *
 *  多少条数据
 */
@property (nonatomic,assign) NSInteger size;

/**
 *  @author holyjoy, 15-05-11 19:05:19
 *
 *  Yes为个人中心全部评论，no为商品详情全部评论
 */
@property (nonatomic,assign) BOOL isFromUserCenter;

@end
