//
//  CouponCell.m
//  YHInternational
//
//  Created by Damon on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell ()
@property (strong, nonatomic) IBOutlet UIButton *couponBtn;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UILabel *couponNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation CouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.couponBtn setBackgroundImage:[[UIImage imageNamed:@"CouponBg_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
}

- (void)setStatus:(BOOL)status{
    if (status) {
        self.amountLabel.textColor = UICOLOR_FONT_GENERAL_GRAY;
        self.couponNameLabel.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT;
        self.shopNameLabel.textColor = UICOLOR_FONT_GENERAL_GRAY;
        self.infoLabel.textColor = UICOLOR_FONT_GENERAL_GRAY;
        self.timeLabel.textColor = UICOLOR_FONT_GENERAL_GRAY;
    }
    
}

- (void)updateCell:(BBGCoupon *)coupon{
    switch (coupon.couponType) {
        case 1:
        {
            self.amountLabel.text = [NSString stringWithFormat:@"%.0f",coupon.amount];
        }
            break;
        case 2:
        {
            self.amountLabel.text = [NSString stringWithFormat:@"%.1f折",coupon.amount];
        }
            break;
        default:
            break;
    }
    
    self.couponNameLabel.text = coupon.couponName;
    self.shopNameLabel.text = coupon.shopName;
    self.infoLabel.text = coupon.couponInfo;
    self.timeLabel.text = [NSString stringWithFormat:@"使用日期：%@至%@",coupon.startTime,coupon.endTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
