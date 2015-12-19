//
//  BBGEditAddressTopCell_iPhone.m
//  YHInternational
//
//  Created by BubuGao on 15-4-22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEditAddressTopCell_iPhone.h"

@implementation BBGEditAddressTopCell_iPhone

- (void)awakeFromNib {
    // Initialization code UIColorFromHexadecimalRGB(rgbValue)
    _areaLbl.textColor = UIColorFromHexadecimalRGB(0x333333);
    _titleLbl.textColor = UIColorFromHexadecimalRGB(0x666666);

}
- (IBAction)selectedAddressAction:(id)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
