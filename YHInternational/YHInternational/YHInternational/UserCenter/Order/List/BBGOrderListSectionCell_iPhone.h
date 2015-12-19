//
//  BBGOrderListSectionCell_iPhone.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BBGOrderListSectionCellDelegate <NSObject>
@optional
- (void)countdownFinished;
@end

@interface BBGOrderListSectionCell_iPhone : UITableViewCell
@property (nonatomic, weak) id<BBGOrderListSectionCellDelegate> delegate;
-(void)updateSectionViewWithOrderInfo:(BBGOrderInfo *)orderInfo;
@end
