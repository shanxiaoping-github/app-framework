//
//  BBGCommentedGoods.h
//  Common
//
//  Created by Holyjoy on 15/4/29.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGCommentedGoods : BBGResponseDataHandler

/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  商品ID
 */
@property (nonatomic,strong) NSString *goodsId;
/**
 *  @author holyjoy, 15-04-29 15:04:39
 *
 *  商品图片
 */
@property (nonatomic,strong) NSString *goodsImgUrl;
/**
 *  @author holyjoy, 15-04-29 15:04:39
 *
 *  商品名称
 */
@property (nonatomic,strong) NSString *goodsName;
/**
 *  @author holyjoy, 15-04-29 15:04:39
 *
 *  商品价格
 */
@property (nonatomic,strong) NSString *goodsPrice;
/**
 *  @author holyjoy, 15-04-29 15:04:39
 *
 *  商品价格
 */
@property (nonatomic,strong) NSString *goodsDesc;
/**
 *  @author holyjoy, 15-04-29 21:04:49
 *
 *  该商品的评论列表
 */
@property (nonatomic,strong) NSMutableArray *commentList;
@end
