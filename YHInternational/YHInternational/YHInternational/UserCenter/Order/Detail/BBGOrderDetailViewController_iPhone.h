//
//  BBGOrderDetailViewController_iPhone.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailViewController.h"
@protocol BBGOrderDetaillViewDelegate <NSObject>
//用于删除订单 取消订单 确认收货 等操作刷新订单列表数据
-(void)refreshOrderList;
@end
@interface BBGOrderDetailViewController_iPhone : BBGOrderDetailViewController
@property (nonatomic,weak)id<BBGOrderDetaillViewDelegate> delegate;
@property (nonatomic,strong)BBGOrderInfo *orderInfo;
@end
