//
//  BBGSettlementListCell_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlementListCell_iPhone.h"
#import "BBGCartProduct.h"

@implementation BBGSettlementListCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    self.countLbl.layer.masksToBounds = YES;
    self.countLbl.layer.cornerRadius = 7.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWith:(BBGCartProduct *)product {

    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:product.productImage] placeholderImage:nil];
    [self.nameLbl setText:product.productName];
    //营销价
    [self.priceLbl setText:[NSString stringWithFormat:@"￥%0.2f",product.unCrossedPrice/100.0]];
    [self.countLbl setText:[NSString stringWithFormat:@"x%ld",(long)product.quantity]];
    self.spceLbl.text = product.specNameStr;
    if (product.type == 1) {
        self.giftTagImageView.hidden = NO;
    }else {
        self.giftTagImageView.hidden = YES;
    }
    
    //市场价
    [self.mkPriceLbl setText:[NSString stringWithFormat:@"￥%0.2f",product.crossedPrice/100.0]];
    

    //如果没有市场价就隐藏，否则就划线变灰
    if (!product.crossedPrice) {
        self.mkPriceLbl.hidden = YES;
        return;
    }
    
    
    NSString *finalStr =[NSString stringWithFormat:@"￥%0.2f",product.crossedPrice/100.0];
    
    NSMutableAttributedString * attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",finalStr]];
    
    [attrStr1 addAttribute:NSFontAttributeName value:APP_FONT(12.0) range:NSMakeRange(0, finalStr.length)];
    
    [attrStr1 addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_GENERAL_GRAYLIGHT range:NSMakeRange(0, finalStr.length)];
    
    
    [attrStr1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, finalStr.length)];
    [attrStr1 addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, finalStr.length)];
    
    self.mkPriceLbl.attributedText = attrStr1;
}

+ (float)cellHeight {

    return 72;
}

@end
