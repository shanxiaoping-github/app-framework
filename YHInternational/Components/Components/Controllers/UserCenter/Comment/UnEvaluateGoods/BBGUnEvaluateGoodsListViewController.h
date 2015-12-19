//
//  BBGUnEvaluateGoodsListViewController.h
//  Components
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGUnEvaluateGoodsListViewController : BBGViewController
/**
 *  页码，默认为1
 */
@property (nonatomic,assign)NSInteger pageIndex;
/**
 *  每页商品数，默认为20
 */
@property (nonatomic,assign)NSInteger pageSize;

/**
 *  产品列表
 */
@property (nonatomic,strong)NSMutableArray *unEvaluateGoodsArray;
/**
 *  是否能加载更多
 */
@property (nonatomic, assign) BOOL canLoadMore;

@end
