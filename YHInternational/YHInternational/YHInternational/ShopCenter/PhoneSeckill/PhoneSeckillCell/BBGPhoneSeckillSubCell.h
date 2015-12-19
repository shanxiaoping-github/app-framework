//
//  PhoneSeckillSubCell.h
//  YHInternational
//
//  Created by 彭腾 on 15/7/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGSecKillProduct.h"

@interface BBGPhoneSeckillSubCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *mainLab;
@property (strong, nonatomic) IBOutlet UILabel *subLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mainWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *subWidth;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIImageView *goodImage;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *subRight;

- (void)updateCellWith:(BBGSecKillProduct *)model;

@end
