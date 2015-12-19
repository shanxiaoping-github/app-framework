//
//  BBGGoodsDetailHeaderCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsDetailHeaderCell.h"

@interface BBGGoodsDetailHeaderCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation BBGGoodsDetailHeaderCell

- (void)updateCellWith:(BBGGoodsBasicInfo *)goods {
    self.titleLab.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:goods.goodsName];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    [paragraphStyle setLineSpacing:5.0f];

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [goods.goodsName length])];
    self.titleLab.attributedText = attributedString;
    self.headerView.isPraise = goods.isPraise;
}

+ (CGFloat)cellHeignt:(BBGGoodsBasicInfo *)basic {
    CGSize size = [basic.goodsName sizeWithStringFont:APP_FONT(13.0f) constrainedToSize:CGSizeMake(IPHONE_WIDTH-125, 100000) lineSpacing:5.0f];
    return size.height+30.0f;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
