//
//  BBGSettlement.h
//  Common
//
//  Created by Timmy OuYang on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"
#import "BBGSettlementPacket.h"

@interface BBGSettlement : BBGResponseDataHandler

/**
 *  包裹信息集合
 */
@property (nonatomic, strong) NSArray *groups;
/**
 *  地址列表
 */
@property (nonatomic, strong) NSArray *addressList;
/**
 *  会员id
 */
@property (nonatomic, strong) NSString *memberId;
/**
 *  是否需要验证身份
 */
@property (nonatomic) BOOL needIdCheck;
/**
 *  submit提示内容
 */
@property (nonatomic, strong) NSString *tip;
/**
 *  提示标志位
 */
@property (nonatomic) NSInteger submitTag;
/**
 *  身份证信息检查 0-都不需要 1-只需要姓名和身份证号码 2-需要姓名身份证和图片(V1.1添加)
 */
@property (nonatomic) NSInteger idCheckType;
/**
 *  提示标志位,兼容老版本，（V1.1）新增该字段
 *1无可卖商品
 *2收货地址不完整
 *3需要填写实名认证
 *4需要选择上门自提点
 *5 需要上传身份证正面
 *6 需要上传身份证反面
 *0正常可提交
 */
@property (nonatomic) NSInteger submitCheckTag;
/**
 *  商品价格
 */
@property (nonatomic) NSInteger totalPrice;
/**
 *  运费
 */
@property (nonatomic) NSInteger totalFreight;
/**
 *  总的优惠
 */
@property (nonatomic) NSInteger totalPmt;
/**
 *  实际价格，等于商品价格+运费-优惠价格
 */
@property (nonatomic) NSInteger totalRealPrice;
/**
 *  关税
 */
@property (nonatomic) NSInteger totalTariff;
/**
 *  商品重量
 */
@property (nonatomic) float productWeight;
/**
 *  总重量，全球购没有赠品的情况下与productWeight相等
 */
@property (nonatomic) float totalWeight;
/**
 *  无法配送商品
 */
@property (nonatomic, strong) BBGSettlementPacket *unablePacket;

@end
