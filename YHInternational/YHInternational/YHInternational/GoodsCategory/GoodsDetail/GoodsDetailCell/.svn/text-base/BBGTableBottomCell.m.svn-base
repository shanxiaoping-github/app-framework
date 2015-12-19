//
//  BBGTableBottomCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/8/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGTableBottomCell.h"

@implementation BBGTableBottomCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:@"scrollTitle" object:nil];
}

- (void)change:(NSNotification *)notification {
    NSString *string = [notification object];
    if ([string isEqualToString:@"1"]) {
        self.titleLab.text = @"继续拖动查看图文详情";
        [self.moreImage setImage:[UIImage imageNamed:@"下拉查看更多"]];
    }else {
        self.titleLab.text = @"下拉查看商品信息";
        [self.moreImage setImage:[UIImage imageNamed:@"gd_dropdown"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"scrollTitle" object:nil];
}

@end
