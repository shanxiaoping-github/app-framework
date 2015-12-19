//
//  BBGGoodsDetailViewController.h
//  Components
//
//  Created by 彭腾 on 15-5-5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGGoodsSpecInfo.h"
@class BBGGoodsBasicInfo;
@class BBGAddPraiseRequest;
@class BBGCancelPraiseRequest;
@class BBGGoodsSpecRequest;
@class BBGAddCartRequest;
@class BBGCartNumRequest;
@class BBGCartDirectRequest;
@class BBGCartNumModel;

@interface BBGGoodsDetailViewController : BBGViewController
/**
 *  条形码
 */
@property (nonatomic, copy) NSString *barCode;
/**
 *  货号
 */
@property (nonatomic, copy) NSString *bn;
/**
 *  城市
 */
@property (nonatomic, copy) NSString *city;
/**
 *  评论数，目前已设置最多10条
 */
@property (nonatomic, assign) NSInteger commentPageSize;
/**
 *  点赞数，默认10条
 */
@property (nonatomic, assign) NSInteger praisePageSize;
/**
 *  货品id
 */
@property (nonatomic, copy) NSString *productId;
/**
 *  商品id
 */
@property (nonatomic, copy) NSString *goodsId;
/**
 *  省
 */
@property (nonatomic, copy) NSString *provine;

@property (nonatomic, copy) NSString *shopId;
/**
 *  县
 */
@property (nonatomic, copy) NSString *township;
/**
 *  规格条件
 */
@property (nonatomic, copy) NSString *filterText;
/**
 *  点赞人列表
 */
@property (nonatomic, strong) NSMutableArray *praiseMembsArr;
/**
 *  店铺小贴士
 */
@property (nonatomic, strong) NSMutableArray *goodsTipArr;
/**
 *  营销信息
 */
@property (nonatomic, strong) NSMutableArray *promotionActivitiesArr;
/**
 *  商品图片列表
 */
@property (nonatomic, strong) NSMutableArray *goodsImagesArr;
/**
 *  商品基本信息
 */
@property (nonatomic, strong) BBGGoodsBasicInfo *basicInfo;
/**
 *  回复评论数组
 */
@property (nonatomic, strong) NSMutableArray *commentListArr;
/**
 *  规格数组
 */
@property (nonatomic, strong) NSMutableArray *goodsSpecsListArr;
/**
 *  规格选择信息
 */
@property (nonatomic, strong) BBGGoodsSpecInfo *specInfo;
/**
 *  获取购物车数量
 */
@property (nonatomic, strong) BBGCartNumModel *cartNum;
/**
 *  点赞请求
 */
@property (nonatomic, strong) BBGAddPraiseRequest *addPraiseRequest;
/**
 *  取消点赞请求
 */
@property (nonatomic, strong) BBGCancelPraiseRequest *cancelPraiseRequest;
/**
 *  货品规格请求
 */
@property (nonatomic, strong) BBGGoodsSpecRequest *specRequest;
/**
 *  添加购物车请求
 */
@property (nonatomic, strong) BBGAddCartRequest *addCartRequest;
/**
 *  获取购物车数量请求
 */
@property (nonatomic, strong) BBGCartNumRequest *cartNumRequest;
/**
 *  立即购买请求
 */
@property (nonatomic, strong) BBGCartDirectRequest *cartDirectRequest;
/**
 *  轮播图
 */
@property (nonatomic, strong) BBGAdvView *pictureView;
/**
 *  添加点赞请求的方法
 *
 *  @param callback <#callback description#>
 */
- (void)addPraiseRequest:(LoadDataCallback)callback;
/**
 *  取消点赞请求的方法
 *
 *  @param callback <#callback description#>
 */
- (void)cancelPraiseRequest:(LoadDataCallback)callback;
/**
 *  刷新规格条件请求的方法
 *
 *  @param callback <#callback description#>
 */
- (void)reloadGoodsSpecRequest:(LoadDataCallback)callback;
/**
 *  添加购物车请求的方法
 *
 *  @param callback <#callback description#>
 */
- (void)addCartRequest:(LoadDataCallback)callback;
/**
 *  购物车数量请求的方法
 *
 *  @param callback <#callback description#>
 */
- (void)cartNumRequest:(LoadDataCallback)callback;
/**
 *  立即购买请求的方法
 *
 *  @param callback <#callback description#>
 */
- (void)cartDirectRequest:(LoadDataCallback)callback;

@end
