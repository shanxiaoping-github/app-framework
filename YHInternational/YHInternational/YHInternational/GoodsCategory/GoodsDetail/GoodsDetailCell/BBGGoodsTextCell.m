//
//  BBGGoodsTextCell.m
//  YHInternational
//
//  Created by 彭腾 on 15-5-5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsTextCell.h"

@implementation BBGGoodsTextCell

- (void)awakeFromNib {
    // Initialization code
//    self.contentView.backgroundColor = UIColorFromHexadecimalRGB(0xfdfaf5) ;
    self.contentView.backgroundColor = UIColorFromHexadecimalRGB(0xfff7f9);
//    self.content.textColor = UIColorFromHexadecimalRGB(0x999999) ;
//    self.content.numberOfLines = 0 ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
