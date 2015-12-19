//
//  BBGUseCouponCell.m
//  YHInternational
//
//  Created by Damon on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUseCouponCell.h"
#import "BBGCoupon.h"
@interface BBGUseCouponCell ()

@end

@implementation BBGUseCouponCell

- (void)updateCell:(id)response{
    BBGCoupon * coupon = response;
//    [self.couponBtn setTitle:[NSString stringWithFormat:@"   %@",coupon.couponName] forState:UIControlStateNormal];
//    [self.couponBtn setTitle:[NSString stringWithFormat:@"   %@",coupon.couponName] forState:UIControlStateSelected];
//    [self.couponBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal] ;
//    [self.couponBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected] ;
    self.titleLab.text = [NSString stringWithFormat:@"   %@",coupon.couponName];
}

- (void)buttonAction:(DetailButton)block {
    self.button = block;
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (self.button) {
        self.button(self.instrBtn.tag);
    }
}

- (void)awakeFromNib {
    // Initialization code
//    [self.couponBtn setBackgroundImage:[[UIImage imageNamed:@"CouponBg_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
//    [self.couponBtn setBackgroundImage:[[UIImage imageNamed:@"CouponBg_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateSelected];
    self.couponBtn.userInteractionEnabled = NO;
    self.contentView.backgroundColor = UIColorFromRGB(240,239,237);
//    self.bgView.layer.borderWidth = 0.5f ;
    self.leftView.backgroundColor = UIColorFromRGB(228,229,230) ;
    self.rightView.backgroundColor = UIColorFromRGB(228,229,230) ;
//    self.couponBtn.layer.borderWidth = 1.0f ;
//    self.couponBtn.layer.borderColor = [UIColorFromRGB(228,229,230) CGColor] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    self.couponBtn.selected = selected;
}

- (IBAction)couponAction:(id)sender {
}


@end
