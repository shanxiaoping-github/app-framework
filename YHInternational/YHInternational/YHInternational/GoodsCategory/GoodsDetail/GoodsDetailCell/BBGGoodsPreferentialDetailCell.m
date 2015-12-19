//
//  BBGGoodsPreferentialDetailCell.m
//  YHInternational
//
//  Created by 彭腾 on 15-5-6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsPreferentialDetailCell.h"

@implementation BBGGoodsPreferentialDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.detailLab.textColor = UIColorFromHexadecimalRGB(0x333333) ;
    self.detailLab.numberOfLines = 0 ;

}

+ (CGFloat)cellHeignt:(BBGPromotionActivities *)basic {
    CGSize size = [basic.ad sizeWithStringFont:APP_FONT(12.5f) constrainedToSize:CGSizeMake(IPHONE_WIDTH-96, 10000)];
    return size.height + 8 ;
}
- (IBAction)click:(UIButton *)sender {
    if (self.button) {
        self.button();
    }
}

- (void)handlerButtonAction:(ActionBlock)block {
    self.button = block;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
