//
//  BBGGoodsShopCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/6/25.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsShopCell.h"
#import "PTLabel.h"

@interface BBGGoodsShopCell ()

@property (weak, nonatomic) IBOutlet PTLabel *firstLab;
@property (strong, nonatomic) IBOutlet UIView *separateLine;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end


@implementation BBGGoodsShopCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    self.separateLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"虚线"]] ;
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, IPHONE_WIDTH, 0.5f);
    topBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xe5e5e5) CGColor];
    [self.bgView.layer addSublayer:topBorder];
}

- (void)updateCellWith:(BBGGoodsBasicInfo *)goods {
    self.firstLab.content.textAlignment = NSTextAlignmentCenter;
    self.firstLab.content.text = @"点击联系客服" ;
    self.firstLab.content.textColor = UIColorFromHexadecimalRGB(0x666666) ;
    self.firstLab.content.font = APP_FONT(12.0f) ;
    self.firstLab.prefixImage.image = [UIImage imageNamed:@"ContactCustomer"] ;
    self.titleLab.text = goods.shopName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnClick:(UIButton *)sender {
    if (self.button) {
        self.button();
    }
}

- (void)handlerButtonAction:(ActionBlock)block {
    self.button = block;
}

@end
