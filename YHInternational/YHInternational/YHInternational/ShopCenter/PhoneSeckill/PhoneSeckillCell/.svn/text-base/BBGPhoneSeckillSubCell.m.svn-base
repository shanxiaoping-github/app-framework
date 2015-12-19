//
//  PhoneSeckillSubCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/7/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneSeckillSubCell.h"

@implementation BBGPhoneSeckillSubCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)updateCellWith:(BBGSecKillProduct *)model {
    CGFloat crossedPrice = [model.crossedPrice floatValue] / 100;
    CGFloat unCrossedPrice = [model.unCrosedPrice floatValue] / 100;
    
    NSString *crossedStr = [NSString stringWithFormat:@"￥%.2f",crossedPrice];
    NSString *unCrossedStr = [NSString stringWithFormat:@"￥%.2f",unCrossedPrice];
    
    NSArray *crossed = [crossedStr componentsSeparatedByString:@"."];
    NSArray *unCrossed = [unCrossedStr componentsSeparatedByString:@"."];
    
    NSString *str1 = crossed[0];
    NSString *str2 = unCrossed[0];
    
    NSMutableAttributedString *crossStr = [[NSMutableAttributedString alloc]initWithString:crossedStr];
    [crossStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(12.0f) range:NSMakeRange(0, 1)];
    [crossStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(19.0f) range:NSMakeRange(1, [str1 length]-1)];
    [crossStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(12.0f) range:NSMakeRange([str1 length], 3)];
    
    NSMutableAttributedString *unCrossStr= [[NSMutableAttributedString alloc]initWithString:unCrossedStr];
    [unCrossStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(12.0f) range:NSMakeRange(0, 1)];
    [unCrossStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(19.0f) range:NSMakeRange(1, [str2 length]-1)];
    [unCrossStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(12.0f) range:NSMakeRange([str2 length], 3)];
    
    _mainLab.attributedText = unCrossStr;
//    _subLab.attributedText = crossStr;
    _subLab.text = crossedStr;
    CGSize size = [[NSString stringWithFormat:@"%@",unCrossStr]
                   sizeWithStringFont:APP_FONT_DEMI_LIGHT(19.0f) constrainedToSize:CGSizeMake(IPHONE_WIDTH, 10000)];
    CGSize size1 = [[NSString stringWithFormat:@"%@",crossedStr]
                   sizeWithStringFont:APP_FONT_DEMI_LIGHT(12.0f) constrainedToSize:CGSizeMake(IPHONE_WIDTH, 10000)];
    _mainWidth.constant = size.width;
    _subWidth.constant = size1.width;
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, _subLab.frame.size.height/2, size1.width, 1)];
    _line.backgroundColor = UIColorFromHexadecimalRGB(0x999999);
    [self.subLab addSubview:_line];
    
    if (model.crossedPrice==nil) {
        self.subLab.hidden = YES;
        self.line.hidden = YES;
    }else {
        self.subLab.hidden = NO;
    }
    
    WS(weakSelf);
    _titleLab.text = model.productName;
    [_goodImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [weakSelf.goodImage setFadeInWithDefaultTime];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
