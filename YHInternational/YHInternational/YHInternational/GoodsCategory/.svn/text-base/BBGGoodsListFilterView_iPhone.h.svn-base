//
//  BBGGoodsListFilterView.h
//  BuBuGao
//
//  Created by calvin on 14-8-21.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"


@class BBGGoodsListFilterView_iPhone;

@protocol BBGGoodsListFilterViewDelegate <NSObject>

/**
 *  排序选择结构回调
 *
 *  @param filterView self
 *  @param type       排序类型
 */
- (void)goodsListFilterView:(BBGGoodsListFilterView_iPhone *)filterView selectedSortType:(SortType)type;

@end

@interface BBGGoodsListFilterView_iPhone : UIView

@property (nonatomic, assign) IBOutlet id<BBGGoodsListFilterViewDelegate> delegate;
@property (nonatomic, strong) NSArray *filterAttributes;

/**
 *  @brief  重载刷新view，按照默认排序
 */
- (void)reloadView;

@end
