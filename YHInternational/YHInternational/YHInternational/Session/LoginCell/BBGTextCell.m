//
//  BBGTextCell.m
//  YHInternational
//
//  Created by Damon on 15/9/22.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGTextCell.h"
#import "BlocksKit+UIKit.h"
@interface BBGTextCell ()
@property (weak, nonatomic) IBOutlet UIImageView *loginIcon;
@property (weak, nonatomic) IBOutlet UIImageView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *vertificationView;

@end

@implementation BBGTextCell

- (void)awakeFromNib {
    // Initialization code
    [_lineView setImage:[UIImage imageNamed:@"LoginTextLine"]];
    [self.loginTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.loginTextField.tintColor = [UIColor whiteColor];
    self.passwordBtn.selected = YES;
    self.loginTextField.returnKeyType = UIReturnKeyDone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showPasswordAction:(id)sender {
    UIButton * button = sender;
    button.selected = !button.isSelected;
    if (self.tag == 11) {
        self.loginTextField.enabled = NO;
        self.loginTextField.secureTextEntry = button.selected;
        self.loginTextField.enabled = YES;
        [self.loginTextField becomeFirstResponder];
    }
    
}

- (void)updateVertificationView:(NSString * )urlStr{
    [_vertificationView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageLowPriority|SDWebImageRetryFailed|SDWebImageRefreshCached];
}

- (void)updateCellWithIndex:(NSInteger)index{
    if (index == 0) {
        [_loginIcon setImage:[UIImage imageNamed:@"UserName"]];
        
    }else if(index == 1){
        [_loginIcon setImage:[UIImage imageNamed:@"Password"]];
        self.loginTextField.placeholder = @"密码";
    }else if(index == 2){
        [_loginIcon setImage:[UIImage imageNamed:@"Vertification"]];
        self.loginTextField.placeholder = @"验证码";
    }
    if (index == 2) {
        [_rVertificationBtn setImage:[UIImage imageNamed:@"RVertification"] forState:UIControlStateNormal];
//        [_rVertificationBtn setImage:[UIImage imageNamed:@"RVertification"] forState:UIControlStateHighlighted];
    }else{
        _rVertificationBtn.hidden = YES;
    }
    
    if (index == 1) {
        [_passwordBtn setImage:[UIImage imageNamed:@"ShowPwd"] forState:UIControlStateNormal];
        [_passwordBtn setImage:[UIImage imageNamed:@"NotShowPwd"] forState:UIControlStateSelected];

        
    }else{
        _passwordBtn.hidden = YES;
    }
}

@end
