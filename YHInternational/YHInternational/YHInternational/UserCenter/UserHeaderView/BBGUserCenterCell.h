//
//  BBGUserCenterCell.h
//  YHInternational
//
//  Created by BubuGao on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGUserCenterCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImage;
@property (strong, nonatomic) IBOutlet UILabel *deteLabel;
@property (weak, nonatomic) IBOutlet UILabel *telNOLbl;

+ (CGFloat)cellHeight;

@end
