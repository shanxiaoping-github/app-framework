//
//  BBGOrderDetailViewController.h
//  Components
//
//  Created by elvis.peng on 15-5-12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGOrderDetailViewController : BBGViewController
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *shopId;
-(void)getOrderTrackList:(LoadDataCallback)callback;
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
