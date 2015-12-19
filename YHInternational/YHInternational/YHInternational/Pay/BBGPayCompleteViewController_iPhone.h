//
//  BBGPayCompleteViewController_iPhoneViewController.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
typedef enum {
    CHECKOUTORDER= 0, //结算页
    USERCENTERORDERLIST,//订单列表页
    USERCENTERORDERDETAIL,//订单详情页
}BBGPaySource;
@interface BBGPayCompleteViewController_iPhone : BBGViewController
/**
 *  页面来源
 */
@property (nonatomic,assign) BBGPaySource paySource;

@property (nonatomic,strong) NSString *orderId;
@end
