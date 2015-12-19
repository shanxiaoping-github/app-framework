//
//  BBGOrderDetalIconTitleCell_iPhone.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBGLogisticsNumDelegate;


@interface BBGOrderDetalIconTitleCell_iPhone : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIButton *numCopyBtn;
@property (nonatomic,weak) id<BBGLogisticsNumDelegate> delegate;
@end

@protocol BBGLogisticsNumDelegate <NSObject>
- (void)bbgLogisticsNumCopy;


@end