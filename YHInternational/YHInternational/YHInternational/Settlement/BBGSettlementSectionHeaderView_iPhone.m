//
//  BBGSettlementSectionHeaderView_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/5/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlementSectionHeaderView_iPhone.h"

@interface BBGSettlementSectionHeaderView_iPhone ()

@property (weak, nonatomic) IBOutlet UIView *horienzonHeadLine;

@end

@implementation BBGSettlementSectionHeaderView_iPhone

- (void)awakeFromNib {

    UIImage *image = [UIImage imageNamed:@"地址title-循环"];
    self.horienzonHeadLine.backgroundColor = [UIColor colorWithPatternImage:image];
    self.titleLabel.text = @"店铺";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
