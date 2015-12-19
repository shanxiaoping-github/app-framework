//
//  BBGSubCatCell_iPhone.m
//  YHInternational
//
//  Created by Timmy Ouyang on 15/4/30.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSubCatCell_iPhone.h"

@implementation BBGSubCatCell_iPhone

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight {
    
    return 40;
}

- (void)updateCellWith:(BBGCategory *)cate index:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        self.catNameLeadingConstraints.constant = 67.0;
        self.backgroundColor = [UIColor whiteColor];
        self.nameLbl.textColor = UIColorFromHexadecimalRGB(0x333333);
    }else {
        self.catNameLeadingConstraints.constant = 87.0;
        self.backgroundColor = UIColorFromHexadecimalRGB(0xfafafa);
        self.nameLbl.textColor = UIColorFromHexadecimalRGB(0x666666);
    }
}

@end
