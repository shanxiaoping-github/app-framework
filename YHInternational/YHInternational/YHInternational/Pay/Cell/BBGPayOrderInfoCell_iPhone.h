//
//  BBGPayOrderInfoCell_iPhone.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Common/Common.h>
@protocol BBGPayOrderInfoCellDelegate <NSObject>
- (void)gotoPayWithOrderInfo:(BBGPayOrderInfo *)orderInfo;
@end
@interface BBGPayOrderInfoCell_iPhone : UITableViewCell
@property (nonatomic,weak)id<BBGPayOrderInfoCellDelegate>delegate;
-(void)updateOrderInfoCellWith:(BBGPayOrderInfo *)orderInfo;
@end
