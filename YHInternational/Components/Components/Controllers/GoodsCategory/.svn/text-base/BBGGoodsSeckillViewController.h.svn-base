//
//  BBGGoodsSeckillViewController.h
//  Components
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGGoodsBasicInfo.h"
#import "BBGAddress.h"
#import "BBGGSSeckillModel.h"
#import "BBGGSFastModel.h"

@interface BBGGoodsSeckillViewController : BBGViewController
/**
 *  轮播图
 */
@property (nonatomic, strong) BBGAdvView *pictureView;
/**
 *  货品id
 */
@property (nonatomic, copy) NSString *productId;
/**
 *  秒杀活动ID
 */
@property (nonatomic, copy) NSString *activityId;
/**
 *  商品图片列表
 */
@property (nonatomic, strong) NSMutableArray *goodsImagesArr;
/**
 *  商品基本信息
 */
@property (nonatomic, strong) BBGGoodsBasicInfo *basicInfo;
/**
 *  订单信息
 */
@property (nonatomic, strong) BBGGSFastModel *fastModel;
/**
 *  地址信息
 */
@property (nonatomic, strong) NSMutableArray *addressArr;
/**
 *  秒杀详情信息
 */
@property (nonatomic, strong) BBGGSSeckillModel *seckill;
/**
 *  选中地址
 */
@property (nonatomic, strong) BBGAddress *selectedAddress;
/**
 *  是否登录
 */
@property (nonatomic, assign) BOOL isLogin;
/**
 *  @author holyjoy, 15-06-08 14:06:19
 *
 *  是否选择身份证背面图片  yes/选择的时背面  no/选中的是正面
 */
@property (nonatomic, assign) BOOL isChooseIDPhotoBack;
/**
 *  上传身份证照片
 *
 *  @param img      身份证照片
 *  @param callback
 */
- (void)AFNetworkUploadIDPhoto:(UIImage*)img callBack:(LoadDataCallback)callback;
/**
 *  提交新地址
 *
 *  @param callback 回调
 */
- (void)addAddressData:(LoadDataCallback)callback;
/**
 *  秒杀购买请求
 *
 *  @param callback 回调
 */
- (void)fastRequest:(LoadDataCallback)callback;

@end
