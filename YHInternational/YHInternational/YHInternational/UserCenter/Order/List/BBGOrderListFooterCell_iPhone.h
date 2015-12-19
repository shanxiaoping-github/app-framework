//
//  BBGOrderListFooterCell_iPhone.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PAYMENTACTION=0,//去付款
    DELETEORDERACTION,//删除订单
    REBUYACTION,//再次购买
    CONFIRMORDERACTION,//确认收货
    CANCELORDERACTION,//取消订单
    SHOWORDER//晒单
}BBGOrderActionType;

@protocol BBGOrderListFooterCellDelegate <NSObject>
- (void)clickFooterViewWithActionType:(BBGOrderActionType)actionType orderId:(NSString *)orderId memberId:(NSString *)memberId;
@end

@interface BBGOrderListFooterCell_iPhone : UITableViewCell
@property (nonatomic,weak)id<BBGOrderListFooterCellDelegate> delegate;
-(void)updateViewDataWithOrderInfo:(BBGOrderInfo *)orderInfo;
@end
