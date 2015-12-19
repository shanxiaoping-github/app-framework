//
//  BBGGoodsListCell_iPhone.h
//  YHInternational
//
//  Created by Timmy Ouyang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGProduct.h"

typedef NS_ENUM(NSInteger, CellItemIndex) {
    //点赞
    PraiseItem,
    //评论
    CommentItem,
    //加购物车
    AddCartItem
};

@protocol GoodsListCellDelegate;
@interface BBGGoodsListCell_iPhone : UITableViewCell
//商品主图
@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@property (weak, nonatomic) IBOutlet UIButton *activityContent;

@property (nonatomic, assign) id<GoodsListCellDelegate> delegate;

/**
 *  刷新cell
 *
 *  @param product 商品model
 */
- (void)updateCellWith:(BBGSearchProduct *)product;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
+ (CGFloat)cellHeight;
@end

@protocol GoodsListCellDelegate <NSObject>

/**
 *  cell点击事件回调
 *
 *  @param listCell  self
 *  @param itemIndex item索引
 */
- (void)goodsListCell:(UITableViewCell *)listCell itemDidSelectedWith:(CellItemIndex)itemIndex;

@end