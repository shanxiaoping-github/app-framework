//
//  BBGSettlementViewController.h
//  Components
//
//  Created by Timmy OuYang on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGSettlement.h"
#import "BBGAddress.h"

@interface BBGSettlementViewController : BBGViewController

/**
 *  购买类型
 */
@property (nonatomic, assign) BBGBuyType buyType;
/**
 *  结算数据对象
 */
@property (nonatomic, strong) BBGSettlement *settlement;
/**
 *  提交订单返回订单id数组
 */
@property (nonatomic, strong) NSMutableArray *orderIdList;
/**
 *  选中地址
 */
@property (nonatomic, strong) BBGAddress *selectedAddress;
/**
 *  提交订单
 *
 *  @param callback 回调
 */
- (void)submitOrderData:(LoadDataCallback)callback;
/**
 *  提交新地址
 *
 *  @param callback 回调
 */
- (void)addAddressData:(LoadDataCallback)callback;
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

@end
