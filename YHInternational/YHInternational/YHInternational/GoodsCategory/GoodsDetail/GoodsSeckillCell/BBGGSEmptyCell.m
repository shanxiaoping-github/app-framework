//
//  BBGGSEmptyCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSEmptyCell.h"

@implementation BBGGSEmptyCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
