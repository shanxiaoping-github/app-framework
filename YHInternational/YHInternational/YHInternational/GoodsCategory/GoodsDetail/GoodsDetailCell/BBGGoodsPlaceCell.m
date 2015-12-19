//
//  BBGGoodsPlaceCell.m
//  YHInternational
//
//  Created by 彭腾 on 15-5-5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsPlaceCell.h"
#import "PTLabel.h"

@interface BBGGoodsPlaceCell ()

@property (strong, nonatomic) IBOutlet UIImageView *countryFlag;
@property (strong, nonatomic) IBOutlet UILabel *produceCountry;
@property (strong, nonatomic) IBOutlet UILabel *shopName;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *separateLine;
@property (strong, nonatomic) IBOutlet PTLabel *firstLab;
@property (strong, nonatomic) IBOutlet PTLabel *secondLab;

@end

@implementation BBGGoodsPlaceCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT ;
    self.separateLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"虚线"]] ;
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, IPHONE_WIDTH, 0.5f);
    topBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xe5e5e5) CGColor];
    [self.bgView.layer addSublayer:topBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWith:(BBGGoodsBasicInfo *)goods {
//    self.produceCountry.textColor = UIColorFromHexadecimalRGB(0x666666) ;
//    self.shopName.textColor = UIColorFromHexadecimalRGB(0x666666) ;
//    [self.countryFlag sd_setImageWithURL:[NSURL URLWithString:goods.countryFlag] placeholderImage:nil] ;
//    self.produceCountry.text = goods.address ;
//    self.shopName.text = goods.shopName ;
    self.firstLab.content.textAlignment = NSTextAlignmentCenter;
    self.firstLab.content.text = goods.address ;
    self.firstLab.content.textColor = UIColorFromHexadecimalRGB(0x666666) ;
    self.firstLab.content.font = APP_FONT(12.0f) ;
    [self.firstLab.prefixImage sd_setImageWithURL:[NSURL URLWithString:goods.countryFlag] placeholderImage:nil] ;
    self.secondLab.content.textAlignment = NSTextAlignmentCenter;
    self.secondLab.content.text = goods.shopName ;
    self.secondLab.content.textColor = UIColorFromHexadecimalRGB(0x666666) ;
    self.secondLab.content.font = APP_FONT(12.0f) ;
    self.secondLab.prefixImage.image = [UIImage imageNamed:@"联系客服"] ;
}


@end
