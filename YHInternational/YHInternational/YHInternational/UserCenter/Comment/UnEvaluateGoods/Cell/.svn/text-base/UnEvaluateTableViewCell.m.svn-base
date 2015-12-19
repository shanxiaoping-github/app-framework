//
//  UnEvaluateTableViewCell.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "UnEvaluateTableViewCell.h"

@implementation UnEvaluateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadCell:(BBGUnEvaluateGood *)product{
    
    self.contentView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:product.imgUrl]];
    self.productNameLbl.text = product.productName;
    self.priceLbl.text = [NSString stringWithFormat:@"%0.2f",product.price/100.0];
    
}


- (IBAction)didClickedShowBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickedEvaluateGoodsBtn:)]) {
        [self.delegate didClickedEvaluateGoodsBtn:self];
    }
}

@end
