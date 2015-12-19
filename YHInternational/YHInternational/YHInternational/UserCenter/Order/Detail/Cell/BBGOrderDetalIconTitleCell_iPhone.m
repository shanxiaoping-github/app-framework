//
//  BBGOrderDetalIconTitleCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetalIconTitleCell_iPhone.h"

@implementation BBGOrderDetalIconTitleCell_iPhone

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)copyLogisticsNum:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(bbgLogisticsNumCopy)]) {
        [self.delegate bbgLogisticsNumCopy];
    }
}

@end
