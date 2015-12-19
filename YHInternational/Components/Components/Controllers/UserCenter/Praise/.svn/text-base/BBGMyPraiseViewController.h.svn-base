//
//  BBGMyPraiseViewController.h
//  Components
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGMyPraiseViewController : BBGViewController

@property(nonatomic,strong) BBGPullTable *tableView;

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
@property (nonatomic,strong)NSMutableArray *productArray;


@property (nonatomic,strong)BBGCancelPraiseRequest *cancelPraiseRequest;

/**
 *   取消点赞
 *
 *  @param callBack <#callBack description#>
 */
- (void)cancelPraiseRequest:(LoadDataCallback)callBack;


@property (nonatomic,strong)BBGAddPraiseRequest *addPraisePraiseRequest;
/**
 *  点赞
 *
 *  @param callBack <#callBack description#>
 */
- (void)addPraiseRequest:(LoadDataCallback)callBack;

@end
