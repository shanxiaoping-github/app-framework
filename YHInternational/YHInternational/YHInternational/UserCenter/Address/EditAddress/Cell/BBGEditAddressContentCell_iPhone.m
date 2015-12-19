//
//  BBGEditAddressContentCell_iPhone.m
//  YHInternational
//
//  Created by BubuGao on 15-4-22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEditAddressContentCell_iPhone.h"

@implementation BBGEditAddressContentCell_iPhone

- (void)awakeFromNib {
    // Initialization code
     self.textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the  selected state
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(self.delegate && [self.delegate respondsToSelector:@selector(editAddressWithType:value:)]){
        
        [self.delegate editAddressWithType:self.type value:textField.text];
    }
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
       if(self.delegate && [self.delegate respondsToSelector:@selector(editAddressWithType:value:)]){
        
        [self.delegate editAddressWithType:self.type value:textField.text];
    }
    return YES;
}

- (void)setType:(BBGEditAddressType)type {
    
    _type = type;
    if(type == EDITADDRESSINFO){
        self.textField.placeholder = @"请输入详细地址";
    }else if (type == EDITUSERNAME){
        self.textField.placeholder = @"请输入收货人姓名";
    }else if (type == EDITPHONE){
        self.textField.placeholder = @"请输入收货人电话";
    }else if (type == EDITIDCARDNAME){
        self.textField.placeholder = @"请输入身份证姓名";
    }
}

- (BOOL)isJudgmentPhoneFormat:(NSString *)phone {
    NSString *pattern = @"^1\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return ![predicate evaluateWithObject:phone];
}

- (BOOL)isJudgmentAddressFormat:(NSString *)address {
    ///匹配字符：以中文字、任意字母开头 ＋ 任意字母、下滑线、数字
    NSString *_address = @"^([\u4E00-\u9FA5]|[a-zA-Z])([\u4E00-\u9FA5]|[A-Za-z0-9_]|[^A-Za-z0-9_])*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", _address];
    return ![emailTest evaluateWithObject:address];
}

@end
