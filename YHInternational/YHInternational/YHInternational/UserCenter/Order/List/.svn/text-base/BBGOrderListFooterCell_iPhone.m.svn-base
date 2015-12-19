//
//  BBGOrderListFooterCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderListFooterCell_iPhone.h"
@interface BBGOrderListFooterCell_iPhone ()
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteOrderBtn;
@property (strong, nonatomic) IBOutlet UILabel *totalAmountLbl;
@property (strong, nonatomic) BBGOrderInfo *orderInfo;
@end

@implementation BBGOrderListFooterCell_iPhone

-(void)awakeFromNib{
    [self.confirmBtn setBackgroundImage:[[UIImage imageNamed:@"红按钮"] stretchImage] forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteOrderBtn setBackgroundImage:[[UIImage imageNamed:@"白底红框按钮"] stretchImage] forState:UIControlStateNormal];
    [self.deleteOrderBtn addTarget:self action:@selector(deleteOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    _totalAmountLbl.textColor = UIColorFromHexadecimalRGB(0x333333);
}

/**
 *  wait_pay:待付款
 *  paid:已付款(待发货)
 *  finish_send_goods:已发货(待收货)
 *  reject_sign:已拒收
 *  wait_self_take:待自提
 *  finish_sign：已签收
 *
 *  @param orderInfo
 */
-(void)updateViewDataWithOrderInfo:(BBGOrderInfo *)orderInfo{
    self.orderInfo = orderInfo;
    self.confirmBtn.hidden = YES;
    self.deleteOrderBtn.hidden = YES;
    
    self.confirmBtn.enabled = YES;
    self.confirmBtn.alpha = 1.0;
    
    self.deleteOrderBtn.enabled = YES;
    self.deleteOrderBtn.alpha = 1.0;
    
    
    self.totalAmountLbl.text = [NSString stringWithFormat:@"实付金额:￥%.2f",orderInfo.totalRealPrice/100];
    
    if (orderInfo.allowCancel) {
        //取消订单 按钮在订单列表不显示
        self.deleteOrderBtn.hidden = YES;
        [self.deleteOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        self.deleteOrderBtn.tag = 1;
    }else if (orderInfo.allowDelete){
        self.deleteOrderBtn.hidden = NO;
        [self.deleteOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        self.deleteOrderBtn.tag = 2;
    }else{
        
        if ([orderInfo.viewStatus compare:@"finish_send_goods"] == NSOrderedSame){
            self.deleteOrderBtn.hidden = NO;
            [self.deleteOrderBtn setTitle:@"再次购买" forState:UIControlStateNormal];
            self.deleteOrderBtn.tag = 3;
        }else{
            self.deleteOrderBtn.hidden = YES;
        }
    }
    
    if ([orderInfo.viewStatus compare:@"wait_pay"] == NSOrderedSame) {
        //待付款
        self.confirmBtn.hidden = NO;
        self.confirmBtn.tag = 2;
        [self.confirmBtn setTitle:@"去付款" forState:UIControlStateNormal];
        
        NSInteger cancelSeconds = self.orderInfo.orderCancelTimeout/1000;
        NSDate *nowDate = [BBGConfiguration sharedInstance].serverTime;
        NSInteger timeout =(int)(cancelSeconds - [nowDate timeIntervalSinceDate:self.orderInfo.orderCreateTime]);
        if (timeout<=0) {
            self.confirmBtn.enabled = NO;
            self.confirmBtn.alpha = 0.7;
            self.deleteOrderBtn.enabled = NO;
            self.deleteOrderBtn.alpha = 0.7;
        }
        
    }else if ([orderInfo.viewStatus compare:@"paid"] == NSOrderedSame){
        //待发货
        self.confirmBtn.hidden = NO;
        self.confirmBtn.tag = 3;
        [self.confirmBtn setTitle:@"再次购买" forState:UIControlStateNormal];

    }else if ([orderInfo.viewStatus compare:@"finish_send_goods"] == NSOrderedSame || [orderInfo.viewStatus compare:@"finish_sign"] == NSOrderedSame){
        //待收货
        self.confirmBtn.hidden = NO;
        self.confirmBtn.tag = 1;
        [self.confirmBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        
        self.deleteOrderBtn.hidden = NO;
        [self.deleteOrderBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        self.deleteOrderBtn.tag = 3;

    }else if ([orderInfo.viewStatus compare:@"showOrder"] == NSOrderedSame){
        //晒单
        self.confirmBtn.hidden = NO;
        self.confirmBtn.tag = 4;
        [self.confirmBtn setTitle:@"晒单" forState:UIControlStateNormal];
        
        self.deleteOrderBtn.hidden = NO;
        [self.deleteOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        self.deleteOrderBtn.tag = 2;
        
    } else{
        self.confirmBtn.hidden = NO;
        self.confirmBtn.tag = 3;
        [self.confirmBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    }
    
}



-(void)confirmOrderAction:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    BBGOrderActionType actionType = PAYMENTACTION;
    if (btn.tag==1) {
        actionType = CONFIRMORDERACTION;
    }else if (btn.tag==2) {
        actionType = PAYMENTACTION;
    }else if (btn.tag==3) {
        actionType = REBUYACTION;
    }else if (btn.tag==4){
        actionType = SHOWORDER;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickFooterViewWithActionType:orderId:memberId:)]) {
        [self.delegate clickFooterViewWithActionType:actionType orderId:self.orderInfo.orderId memberId:self.orderInfo.memberId];
    }
}

-(void)deleteOrderAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    BBGOrderActionType actionType = CANCELORDERACTION;
    if (btn.tag==1) {
        actionType = CANCELORDERACTION;
    }else if (btn.tag==2){
        actionType = DELETEORDERACTION;
    }else if (btn.tag==3){
        actionType = REBUYACTION;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickFooterViewWithActionType:orderId:memberId:)]) {
        [self.delegate clickFooterViewWithActionType:actionType orderId:self.orderInfo.orderId memberId:self.orderInfo.memberId];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
