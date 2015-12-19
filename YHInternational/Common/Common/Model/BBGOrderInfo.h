//
//  BBGOrderInfo.h
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"
#import "BBGOrderProduct.h"
#import "BBGOrderSelfArea.h"
#import "BBGOrderPmt.h"
@interface BBGOrderInfo : BBGResponseDataHandler
/**
 *  订单号
 */
@property (nonatomic,strong)NSString *waybillId;
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *shopId;
@property (nonatomic,strong)NSString *memberId;
@property (nonatomic,strong)NSString *shopName;
/**
 *  发货状态
 *   0：未发货
 *   1：已发货
 *   5：自提点签收
 *   6：用户签收
 *   7：用户拒收
 *   8：配送失败
 *   9：配送成功
 */
@property (nonatomic,strong)NSString *shipStatus;
/**
 *  支付状态
 *   0:未支付
 *   1:已支付
 */
@property (nonatomic,strong)NSString *payStatus;
/**
 *  订单状态
 *   active:活动订单canceling:取消中
 *   dead:已取消
 *   finish:已完成
 */
@property (nonatomic,strong)NSString *orderStatus;
@property (nonatomic,strong)NSString *paymentType;
@property (nonatomic,strong)NSString *payment;
@property (nonatomic,strong)NSString *paymentName;
/**
 *  配送方式
 */
@property (nonatomic,strong)NSString *shipping;
/**
 *  湖南_长沙市_岳麓区_麓谷街道:43_430100000000_430104000000_430104030000
 */
@property (nonatomic,strong)NSString *shipArea;
/**
 *  收货人
 */
@property (nonatomic,strong)NSString *shipName;
/**
 *  收货地址
 */
@property (nonatomic,strong)NSString *shipAddr;
/**
 *  邮编
 */
@property (nonatomic,strong)NSString *shipZip;
/**
 *  配送电话
 */
@property (nonatomic,strong)NSString *shipTel;
/**
 *  收货时间
 */
@property (nonatomic,strong)NSString *shipTime;
/**
 *  手机号
 */
@property (nonatomic,strong)NSString *shipMobile;
/**
 *  重量
 */
@property (nonatomic,assign)float weight;

/**
 *  总销售金额
 */
@property (nonatomic,assign)float totalSaleAmount;
/**
 *  总支付金额
 */
@property (nonatomic,assign)float totalPayAmount;
/**
 *  实际支付总金额
 */
@property (nonatomic,assign)float totalRealPayAmount;
/**
 *  优惠扣减金额
 */
@property (nonatomic,assign)float totalDeductAmount;
/**
 *  订单需支付总金额
 */
@property (nonatomic,assign)float totalRealPrice;
/**
 *  运费
 */
@property (nonatomic,assign)float expressFee;
/**
 *  商品促销活动总额
 */
@property (nonatomic,assign)float productPromotionAmount;
/**
 *  订单促销活动总额
 */
@property (nonatomic,assign)float orderPromotionAmount;
/**
 *  优惠总额
 */
@property (nonatomic,assign)float couponAmount;
/**
 *  是否允许退款
 */
@property (nonatomic,assign)BOOL allowReturn;
/**
 *  是否允许删除订单
 */
@property (nonatomic,assign)BOOL allowDelete;
/**
 *  取消订单原因
 */
@property (nonatomic,strong)NSString *cancelReason;
/**
 *  订单创建时间
 */
@property (nonatomic,strong)NSDate *orderCreateTime;
/**
 *  订单超时时间
 */
@property (nonatomic,assign)NSInteger orderCancelTimeout;

/**
 *  页面显示的订单状态
 *  wait_pay:待付款
 *   paid:已付款(待发货)
 *  finish_send_goods:已发货(待收货)
 *   reject_sign:已拒收
 *   wait_self_take:待自提
 *   finish_sign:已签收
 *    ship_success:配送成功
 *   ship_failed:配送失败
 *   trade_success:交易成功
 *   trade_failed:交易失败
 *   canceling:取消中
 *   canceled:已取消
 */
@property (nonatomic,strong)NSString *viewStatus;
/**
 *  商品总额
 */
@property (nonatomic,assign)float totalProductAmount;

/**
 *  是否允许取消订单
 */
@property (nonatomic,assign)BOOL allowCancel;

@property (nonatomic,assign)BOOL isDelivery;

@property (nonatomic,strong)NSMutableArray *productList;

@property (nonatomic,strong)BBGOrderSelfArea *selfArea;

@property (nonatomic,strong)NSString *statusName;

@property (nonatomic,strong)NSMutableArray *orderPmtList;

@property (nonatomic,strong)NSString *pmtStr;

@end
