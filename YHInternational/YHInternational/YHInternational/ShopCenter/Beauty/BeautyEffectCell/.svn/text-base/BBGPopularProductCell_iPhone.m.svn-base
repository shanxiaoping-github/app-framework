//
//  BBGPopularProductCell_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/7/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPopularProductCell_iPhone.h"

@implementation BBGPopularProductCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)updateCellWithPopularProduct:(BBGPopularProduct *)product {
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:product.imageUrl] placeholderImage:[UIImage imageNamed:@"goodsDefault"]];
    self.productNameLabel.text = product.productName;
    
    //正常价格显示
    NSString *uncrosePrice = [NSString stringWithFormat:@"￥%0.2f",product.unCrosedPrice/100.0];
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",uncrosePrice]];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(13.0) range:NSMakeRange(0, 1)];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(16.0) range:NSMakeRange(1, uncrosePrice.length - 3)];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(12.0) range:NSMakeRange(uncrosePrice.length - 3, 3)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange(0, uncrosePrice.length)];
    self.normalPriceLabel.attributedText = attrStr;
    
    //划线价格显示
    if (product.crossedPrice) {
        NSString *crosePrice = [NSString stringWithFormat:@"￥%0.2f",product.crossedPrice/100.0];
        NSMutableAttributedString * attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",crosePrice]];
        [attrStr1 addAttribute:NSFontAttributeName value:APP_FONT(12.0) range:NSMakeRange(0, crosePrice.length)];
        [attrStr1 addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_WEAK_GRAYLIGHT range:NSMakeRange(0, crosePrice.length)];
        [attrStr1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, crosePrice.length)];
        [attrStr1 addAttribute:NSStrikethroughColorAttributeName value:UICOLOR_FONT_WEAK_GRAYLIGHT range:NSMakeRange(0, crosePrice.length)];
        self.crossPriceLabel.attributedText = attrStr1;
        self.crossPriceLabel.hidden = NO;
        self.uncrossPriceLabelLeadingSpaceConstraints.constant = 0.0;
    }else {
        self.crossPriceLabel.hidden = YES;
        self.uncrossPriceLabelLeadingSpaceConstraints.constant = (self.frame.size.width-90)/2;
    }
}

@end
