//
//  FastMobileImageAuthCell.m
//  YHInternational
//
//  Created by Holyjoy on 15/6/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "FastMobileImageAuthCell.h"

@implementation FastMobileImageAuthCell

- (void)awakeFromNib {
    // Initialization code
    
    [_imageAuthTextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _imageAuthTextfield.tintColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)didRefreshBtnAction:(UIButton *)sender {
    
    if (_refreshBtnBlock) {
        _refreshBtnBlock();
    }
}


@end
