//
//  BBGGoodsPreferentialDetailCell.h
//  YHInternational
//
//  Created by 彭腾 on 15-5-6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGPromotionActivities.h"

typedef void (^ActionBlock)();

@interface BBGGoodsPreferentialDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *detailImage;
@property (strong, nonatomic) IBOutlet UILabel *detailLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (strong, nonatomic) IBOutlet UIImageView *moreImage;
@property (nonatomic, copy) ActionBlock button;
- (void)handlerButtonAction:(ActionBlock)block;

+ (CGFloat)cellHeignt:(BBGPromotionActivities *)basic;

@end
