//
//  PhoneSeckillHeaderCell.h
//  YHInternational
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountDownView.h"
#import "BBGPhoneSeckillModel.h"

@interface BBGPhoneSeckillHeaderCell : UITableViewCell<CountDownDelegate>
@property (strong, nonatomic) IBOutlet UIView *timeView;

- (void)updateCellWith:(BBGPhoneSeckillModel *)model;

@end
