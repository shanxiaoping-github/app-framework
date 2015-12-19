//
//  BBGoodsTitleCell.m
//  YHInternational
//
//  Created by 彭腾 on 15-5-9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGoodsTitleCell.h"

@interface BBGoodsTitleCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation BBGoodsTitleCell

+ (CGFloat)cellHeignt:(BBGGoodsBasicInfo *)basic {
    
    CGSize size = [basic.goodsName
                    sizeWithStringFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(IPHONE_WIDTH-14, 10000)];
    
    return size.height + 20 ;
}

- (void)updateCellWith:(BBGGoodsBasicInfo *)goods {
    self.titleLab.numberOfLines = 0 ;
    self.titleLab.text = goods.goodsName ;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
