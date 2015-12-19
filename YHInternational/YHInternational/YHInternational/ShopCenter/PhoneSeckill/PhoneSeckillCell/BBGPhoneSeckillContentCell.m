//
//  BBGPhoneSeckillContentCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/9/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneSeckillContentCell.h"
#import "BBGPTPriceView.h"

@interface BBGPhoneSeckillContentCell ()
@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UILabel *goodsName;
@property (strong, nonatomic) IBOutlet BBGPTPriceView *priceView;

@end

@implementation BBGPhoneSeckillContentCell

- (void)updateCellWith:(BBGSecKillProduct *)model {
    WS(weakSelf);
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [weakSelf.goodsImage setFadeInWithDefaultTime];
        }
    }];
    self.goodsName.text = model.productName;
    self.priceView.unCrossPrice = model.unCrosedPrice;
    self.priceView.crossPrice = model.crossedPrice;
    [self.priceView layoutSubviews];
}

- (void)awakeFromNib {
    // Initialization code
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(135.0f, self.frame.size.height-0.5f, IPHONE_WIDTH-135.0f, 0.5f);
    bottomBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xe5e5e5) CGColor];
    [self.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
