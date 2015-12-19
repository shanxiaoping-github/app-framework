//
//  BBGCommentFootCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/8/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCommentFootCell.h"

@implementation BBGCommentFootCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = UIColorFromHexadecimalRGB(0xf8f8f8);
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height-0.5f, IPHONE_WIDTH, 0.5f);
    bottomBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xe5e5e5) CGColor];
    [self.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
