//
//  BBGSettlementIDCardCell_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/6/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlementIDCardCell_iPhone.h"

@implementation BBGSettlementIDCardCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    _address = [[BBGAddress alloc] init];
    
    self.submitButton.layer.masksToBounds = YES;
    self.submitButton.layer.borderWidth = 1.0;
    self.submitButton.layer.borderColor = UICOLOR_FONT_IMPORTANT_RED.CGColor;
    self.submitButton.layer.cornerRadius = 3.0;
    
    self.IDCardFrontButton.layer.masksToBounds = YES;
    self.IDCardFrontButton.layer.borderWidth = 1.0;
    self.IDCardFrontButton.layer.borderColor = UICOLOR_FONT_GENERAL_GRAYLIGHT.CGColor;
    self.IDCardFrontButton.layer.cornerRadius = 3.0;
    
    self.IDCardBackButton.layer.masksToBounds = YES;
    self.IDCardBackButton.layer.borderWidth = 1.0;
    self.IDCardBackButton.layer.borderColor = UICOLOR_FONT_GENERAL_GRAYLIGHT.CGColor;
    self.IDCardBackButton.layer.cornerRadius = 3.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float)cellHeightWithTemp:(NSInteger)temp{

    switch (temp) {
        case 0:
            return 378;
            break;
        case 1:
            return 310;
            break;
        default:
            return 378;
            break;
    }
    
}


- (IBAction)pickerIDCardPhoto:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(settlementIDCard:didSelectedType:)]) {
        if (sender.tag == 0) {
            [self.delegate settlementIDCard:self didSelectedType:BBGAddressCellSelecteIDCardFront];
        }else if (sender.tag == 1) {
            [self.delegate settlementIDCard:self didSelectedType:BBGAddressCellSelecteIDCardBack];
        }
    }
}


- (IBAction)selecteAreaButtonPressed:(UIButton *)sender {
    [self.addressTf resignFirstResponder];
    [self.nameLblTf resignFirstResponder];
    [self.idCardTf resignFirstResponder];
    [self.phoneTf resignFirstResponder];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(settlementIDCard:didSelectedType:)]) {
        [self.delegate settlementIDCard:self didSelectedType:BBGAddressCellSelecteAreaPicker];
    }
}


- (IBAction)submitAddress:(UIButton *)sender {
    self.address.addr = self.addressTf.text;
    self.address.idCard = self.idCardTf.text;
    self.address.realName = self.nameLblTf.text;
    self.address.mobile = self.phoneTf.text;
    self.address.name = self.nameLblTf.text;
    BOOL check = [self checkData];
    if (check && self.delegate && [self.delegate respondsToSelector:@selector(settlementIDCard:didSelectedType:)]) {
        [self.delegate settlementIDCard:self didSelectedType:BBGAddressCellSelecteSubmit];
    }
}

- (BOOL)checkData {
    BOOL checkSuccess = YES;
    if ([BBGTools checkStringIsBlank:self.address.areaInfo]) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请选择收货地区"];
        return checkSuccess;
    }
    if ([BBGTools checkStringIsBlank:self.address.addr]) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请输入详细地址"];
        return checkSuccess;
    }
    if ([BBGTools checkStringIsBlank:self.address.name]) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请输入真实姓名"];
        return checkSuccess;
    }
//    if (![BBGTools validateChinese:self.address.name]) {
//        checkSuccess = NO;
//        [[BBGLoadingTips sharedInstance] showTips:@"收货人只能输入中文"];
//        return checkSuccess;
//    }
    if ([BBGTools checkStringIsBlank:self.address.mobile]) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请输入联系电话"];
        return checkSuccess;
    }
    if (self.address.mobile.length != 11) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请输入正确的手机号码"];
        return checkSuccess;
    }
    
    return checkSuccess;
}

@end
