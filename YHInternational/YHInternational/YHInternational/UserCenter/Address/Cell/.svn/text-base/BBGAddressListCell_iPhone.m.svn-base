//
//  BBGAddressListCell_iPhone.m
//  YHInternational
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAddressListCell_iPhone.h"
@interface BBGAddressListCell_iPhone()

@end
@implementation BBGAddressListCell_iPhone

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellData:(BBGAddress *)userAddress {
    
    self.userAddress = userAddress;
    self.nameLabel.text = userAddress.name;
    self.phoneLabel.text = userAddress.mobile;
    self.addressLabel.text = userAddress.addr;
    NSString *areaInfoStr = [[userAddress.areaInfo componentsSeparatedByString:@":"] ARRAY_OBJ_AT(0)];
    NSString * addressStr = [NSString stringWithFormat:@"%@%@",areaInfoStr,userAddress.addr];
    
    if (addressStr) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:addressStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [addressStr length])];
        self.addressLabel.attributedText = attributedString;
    }

    if (userAddress.defAddr) {
        [self.selectionImg setImage:[UIImage imageNamed:@"selected"]];
        [self.selectionLbl setText:@"当前默认"];
        self.selectionLbl.textColor = UICOLOR_FONT_IMPORTANT_RED;
    }else{
        [self.selectionImg setImage:[UIImage imageNamed:@"unSelected"]];
        [self.selectionLbl setText:@"设置默认"];
        self.selectionLbl.textColor = UICOLOR_FONT_GENERAL_GRAY;
    }
    
    self.tipLab.textColor = UICOLOR_FONT_IMPORTANT_RED;
    if (!userAddress.idCard) {
        self.tipImage.hidden = NO;
        self.tipLab.hidden   = NO;
    }else{
        self.tipImage.hidden = YES;
        self.tipLab.hidden   = YES;
    }
    
}

- (IBAction)setDefaultBtnPressed:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(setDefaultAddress:)]) {
        [self.delegate setDefaultAddress:self.userAddress];
    }
  
}

- (IBAction)clickAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didChangeAddressCellWithType:address:)]) {
        [self.delegate didChangeAddressCellWithType:btn.tag address:self.userAddress];
    }
}

@end
