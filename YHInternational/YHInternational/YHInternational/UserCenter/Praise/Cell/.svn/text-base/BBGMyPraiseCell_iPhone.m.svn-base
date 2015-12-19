//
//  BBGMyPraiseCell_iPhone.m
//  YHInternational
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMyPraiseCell_iPhone.h"

@implementation BBGMyPraiseCell_iPhone

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)cancelPraise:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelPraise:)]) {
        [self.delegate cancelPraise:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadCell:(BBGPraiseProduct*)product{
    
    self.contentView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:product.imgUrl]];
    self.productNameLbl.text = product.productName;
    self.priceLbl.text = [NSString stringWithFormat:@"%0.2f",product.price];
    if (product.isPraise == -1) {
        [self.praiseButton setTitle:@"点赞" forState:UIControlStateNormal];
        [self.praiseHeartImg setImage:[UIImage imageNamed:@"未点赞"]];
    }else{
        [self.praiseButton setTitle:@"取消点赞" forState:UIControlStateNormal];
        [self.praiseHeartImg setImage:[UIImage imageNamed:@"点赞"]];
    }
}

@end
