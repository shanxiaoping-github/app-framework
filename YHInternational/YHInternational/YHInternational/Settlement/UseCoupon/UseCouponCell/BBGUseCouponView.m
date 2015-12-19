//
//  BBGUseCouponView.m
//  YHInternational
//
//  Created by Damon on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUseCouponView.h"

@interface BBGUseCouponView ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *useCouponBackground;
@property (strong, nonatomic) IBOutlet UITextField *useTextfield;
@property (strong, nonatomic) IBOutlet UIButton *commitBtn;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end

@implementation BBGUseCouponView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.useTextfield.delegate = self;
    [self.nouse setBackgroundImage:[[UIImage imageNamed:@"canuse"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    self.bgImage.image = [[UIImage imageNamed:@"shuru"] stretchImage];
    self.bgView.backgroundColor = UIColorFromRGB(248,248,248);
    self.backgroundColor = UIColorFromRGB(240,239,237);
    
    CALayer *bottomBorder = [CALayer layer];
    CGFloat height = self.bgView.frame.size.height - 1.0f ;
    bottomBorder.frame = CGRectMake(0.0f, height, IPHONE_WIDTH, 1.0f) ;
    bottomBorder.backgroundColor = [UIColorFromRGB(224,225,226) CGColor]  ;
    [self.bgView.layer addSublayer:bottomBorder] ;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.couponCode = textField.text;

}

- (IBAction)commitUseCoupon:(id)sender {
    [self.useTextfield resignFirstResponder];
    if (self.block) {
        self.block();
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    if (self.button) {
        self.button();
    }
}

- (void)handlerButtonAction:(ReturnButton)block {
    self.button = block;
}

@end
