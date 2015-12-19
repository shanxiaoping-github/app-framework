//
//  FastMobileLoginEnterAuthCodeCell.m
//  YHInternational
//
//  Created by Holyjoy on 15/6/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "FastMobileLoginEnterAuthCodeCell.h"

@implementation FastMobileLoginEnterAuthCodeCell

- (void)awakeFromNib {
    // Initialization code
    
    [_authCodeTextfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _authCodeTextfield.tintColor = [UIColor whiteColor];
    [_resendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)resendBtnAction:(UIButton *)sender {
    
    if (_resendBtnBlock) {
        _resendBtnBlock();
    }
    
}

@end
