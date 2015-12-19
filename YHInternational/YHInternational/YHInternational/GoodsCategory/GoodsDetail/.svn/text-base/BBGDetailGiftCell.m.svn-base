//
//  BBGDetailGiftCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/6/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGDetailGiftCell.h"

@implementation BBGDetailGiftCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = UIColorFromHexadecimalRGB(0xfaf8fb);
    self.numLab.layer.cornerRadius = 7.0f;
    self.numLab.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)handlerButtonAction:(ActionButton)block {
    self.button = block;
}

- (IBAction)click:(UIButton *)sender {
    if (self.button) {
        self.button();
    }
}

@end
