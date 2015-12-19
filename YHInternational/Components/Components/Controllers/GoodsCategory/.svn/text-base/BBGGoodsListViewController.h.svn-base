//
//  BBGGoodsListViewController.h
//  Components
//
//  Created by Timmy Ouyang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGGoodsListViewController : BBGViewController

/**
 *  @author holyjoy, 15-04-20 14:04:49
 *
 *  搜索关键字
 */
@property (nonatomic, strong) NSString *keyword;
/**
 *  页码，默认为1
 */
@property (nonatomic, assign) NSInteger page;
/**
 *  每页商品数，默认为20
 */
@property (nonatomic, assign) NSInteger pageSize;
/**
 *  排序类型
 */
@property (nonatomic, assign) SortType type;
/**
 *  分类id
 */
@property (nonatomic, strong) NSString *categoryID;

/**
 *  筛选时勾选的所有品牌ID
 */
@property (nonatomic, strong) NSString *brandIDs;
/**
 *  筛选时用户选择的商品最低价
 */
@property (nonatomic, assign) CGFloat minPrice;
/**
 *  筛选时用户选择的商品最高价
 */
@property (nonatomic, assign) CGFloat maxPrice;
/**
 *  只显示有货商品，YES表示只显示有货，NO表示显示所有
 */
@property (nonatomic, assign) BOOL showHaveStoreOnly;
/**
 *  只显示自营商品，YES表示只显示自营商品，NO表示显示所有
 */
@property (nonatomic, assign) BOOL showProprietaryOnly;

/**
 * 店铺id
 */
@property (nonatomic, strong) NSString *shopId;
/**
 *  返回商品数据
 */
@property (nonatomic, strong) NSMutableArray *products;
/**
 *  当前cell有多少行
 */
@property (nonatomic, assign) NSInteger nowRows;
/**
 *  筛选条件
 */
@property (nonatomic, strong) NSArray *filterAttributes;
/**
 *  筛选属性列表
 */
@property (nonatomic, strong) NSString *facetProps;
/**
 *  筛选规格列表
 */
@property (nonatomic, strong) NSString *facetSpec;
/**
 *  点赞请求
 */
@property (nonatomic,strong)BBGAddPraiseRequest *addPraiseRequest;

/**
 *  前台分类ID，发现分类 点击搜索时使用
 */
@property (nonatomic,strong) NSString *fCate;

/**
 *  商品列表当前选择cell
 *
 *  @return cell对象
 */
@property (nonatomic,strong) UIImageView * currentImageView;

/**
 *  商品id
 */
@property (nonatomic,strong) NSString *productId;

/**
 *  数量
 */
@property (nonatomic,assign) NSInteger quantity;

/**
 *  清除所有筛选条件
 */
- (void)clearSearchItems;

/**
 *  给商品点赞
 */
- (void)addPraiseRequest:(LoadDataCallback)callback;

/**
 *  加入购物车请求
 */
@property (nonatomic,strong)BBGAddCartRequest *addCartRequet;

/**
 *  是否能加载更多
 */
@property (nonatomic, assign) BOOL canLoadMore;

/**
 *  加入购物车
 *
 *  @param callback
 */
- (void)addCartRequet:(LoadDataCallback)callback;

/**
 *  立即购买刷新结算数据接口
 *
 *  @param callback
 */
- (void)cartDirectRequest:(LoadDataCallback)callback;

/**
 *  手机专享
 *
 *  @param callback callback
 */
- (void)loadPhoneExtra:(LoadDataCallback)callback;

/**
 *  新品推荐
 *
 *  @param callback callback
 */
- (void)loadPhoneRequest:(LoadDataCallback)callback;

@end
