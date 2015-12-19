//
//  BBGIDCardListCell_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/6/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIDCardListCell_iPhone.h"

@implementation BBGIDCardListCell_iPhone

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)deleteBtnAction:(UIButton *)sender {
    if (_deleteActionBlock) {
        _deleteActionBlock();
    }
}
- (IBAction)editBtnAction:(UIButton *)sender {
    if (_editActionBlock) {
        _editActionBlock();
    }
}

- (IBAction)didClickedIDCardBtn:(UIButton *)sender {
    
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

+(CGFloat)cellHeight{
    
    CGFloat height = (IPHONE_WIDTH - 90)/2/1.55;

    return 208.0 - 83 + height;
}

- (void)updateCellData:(BBGIDCard *)userIDCard{
    WS(weakSelf);

    CGFloat height = (IPHONE_WIDTH - 90)/2/1.55;
    _bgFrontImageViewConstarint.constant = height;
    _frontImageViewConstarint.constant = height;
    _frontBtnConsarint.constant = height;
    _bgBackImageViewConstarint.constant = height;
    _backImageViewConstarint.constant = height;
    _backBtnConstraint.constant = height;
    
    _IDCardNameLabel.text = userIDCard.IDName;
    _IDCardNumberLabel.text = userIDCard.IDNumber;
    [_frontImageView sd_setImageWithURL:[NSURL URLWithString:userIDCard.frontImgUrl] placeholderImage:[UIImage imageNamed:@"IDCard_positive"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [weakSelf.frontImageView setFadeInWithDefaultTime];
        }
    }];
    [_reverImageView sd_setImageWithURL:[NSURL URLWithString:userIDCard.reverseImgUrl] placeholderImage:[UIImage imageNamed:@"IDCard_opposite"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [weakSelf.reverImageView setFadeInWithDefaultTime];
        }
    }];

}

@end
