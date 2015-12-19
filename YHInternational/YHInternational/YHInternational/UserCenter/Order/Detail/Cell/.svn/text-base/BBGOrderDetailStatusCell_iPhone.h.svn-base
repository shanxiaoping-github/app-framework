//
//  BBGOrderDetailStatusCell_iPhone.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BBGOrderDetailStatusCellDelegate <NSObject>
@optional
- (void)countdownFinished;
@end
@interface BBGOrderDetailStatusCell_iPhone : UITableViewCell
@property (nonatomic,weak)id<BBGOrderDetailStatusCellDelegate> delegate;
-(void)updateStatusCellWithOrderInfo:(BBGOrderInfo *)orderInfo;
@end
