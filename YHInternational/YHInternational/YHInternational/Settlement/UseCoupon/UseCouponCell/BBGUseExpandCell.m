//
//  BBGUseExpandCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/6/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUseExpandCell.h"

@implementation BBGUseExpandCell

- (void)awakeFromNib {
    // Initialization code
    self.bgView.backgroundColor = UIColorFromHexadecimalRGB(0xf8f8f8);
//    self.bgImage.image = [[UIImage imageNamed:@"expandBg"] stretchImage] ;
    self.contentView.backgroundColor = UIColorFromRGB(240,239,237);
    self.dpLab.numberOfLines = 0;
    self.gcLab.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
