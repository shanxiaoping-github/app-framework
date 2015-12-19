//
//  BBGOrderListViewController.h
//  Components
//
//  Created by elvis.peng on 15-5-12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

typedef enum {
    OBLIGATIONSTATUS=0,//待付款
    NOTSHOPPEDSTATUS,//待发货
    NOTRECEIVESTATUS,//待收货
    HAVERECEIVEDSTATUS,//已收货
    ALLSTATUS//已结束
}BBGOrderStatus;

#import "BBGViewController.h"
@interface BBGOrderListViewController : BBGViewController

@property (nonatomic,assign)BBGOrderStatus status;
/**
 *  页码
 */
@property (nonatomic,assign) NSInteger currentPage;
/**
 *  一页显示多少个
 */
@property (nonatomic,assign) NSInteger pageSize;
/**
 *  总记录条数
 */
@property (assign,nonatomic) NSInteger total;
/**
 *  总页数
 */
@property (assign,nonatomic) NSInteger totalPage;
/**
 *  订单
 */
@property (strong,nonatomic) NSMutableArray *orderList;

-(void)deleteOrderWithOrderId:(NSString *)orderId
                     memberId:(NSString *)memberId
                     callback:(LoadDataCallback)callback;
-(void)confirmOrderWithOrderId:(NSString *)orderId
                      memberId:(NSString *)memberId
                      callback:(LoadDataCallback)callback;
-(void)cancelOrderWithOrderId:(NSString *)orderId
                      cancelReason:(NSString *)cancelReason
                      callback:(LoadDataCallback)callback;
-(void)againPurchaseWithOrderId:(NSString *)orderId
                     callback:(LoadDataCallback)callback;
@end
