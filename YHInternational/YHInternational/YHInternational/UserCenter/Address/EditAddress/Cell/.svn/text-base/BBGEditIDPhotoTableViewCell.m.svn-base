//
//  BBGEditIDPhotoTableViewCell.m
//  YHInternational
//
//  Created by Holyjoy on 15/6/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEditIDPhotoTableViewCell.h"

@implementation BBGEditIDPhotoTableViewCell

- (void)awakeFromNib {
    
    
    //2个按钮
    //    _frontButtonWidth.constant = (IPHONE_WIDTH - 90)/2;
    _frontButtonHeight.constant = (IPHONE_WIDTH - 90)/2 * 9/14;
    
    [_titleLabel1 setTextColor:UICOLOR_FONT_GENERAL_GRAY];
    
    [_frontButton setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    [_backButton setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    
    _frontButton.layer.borderWidth = 0.6;
    _frontButton.layer.borderColor = UICOLOR_FONT_IMPORTANT_RED.CGColor;
    _frontButton.layer.masksToBounds = YES;
    _frontButton.layer.cornerRadius = 3;
    
    _backButton.layer.borderWidth = 0.6;
    _backButton.layer.borderColor = UICOLOR_FONT_IMPORTANT_RED.CGColor;
    _backButton.layer.masksToBounds = YES;
    _backButton.layer.cornerRadius = 3;
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickedIDFrontBtn:(UIButton *)sender {
    if (_IDFrontblock) {
        _IDFrontblock();
    }
    
}

- (IBAction)clickedIDBackBtn:(UIButton *)sender {
    if (_IDBackblock) {
        _IDBackblock();
    }
    
}

- (IBAction)didClickedIDPhotoBtn:(UIButton *)sender {
    
    //tag ：10 身份证正面  ，20 身份证反面
    if (sender.tag == 10) {
        if (_BtnIDFrontblock) {
            _BtnIDFrontblock();
        }
    }else if (sender.tag == 20) {
        if (_BtnIDBackblock) {
            _BtnIDBackblock();
        }
    }
}


@end
