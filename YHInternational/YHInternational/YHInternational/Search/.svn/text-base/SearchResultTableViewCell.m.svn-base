//
//  SearchResultTableViewCell.m
//  BuBuGao
//
//  Created by Holyjoy on 15/3/23.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "SearchResultTableViewCell.h"

@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.nameLabel.textColor = UIColorFromHexadecimalRGB(0x666666);
    self.nameLabel.font = APP_FONT(14.0);
    self.numberLabel.textColor = UIColorFromHexadecimalRGB(0x999999);
    self.numberLabel.font = APP_FONT(12.0);
    self.numberLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.backgroundColor = UIColorFromHexadecimalRGB(0xe1e1e1);
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
    
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:YES];
    
    if (highlighted) {
        self.backgroundColor = UIColorFromHexadecimalRGB(0xe1e1e1);
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)updateCellData:(BBGPhraseAssociation *)PhraseAssociation {
    self.nameLabel.text = PhraseAssociation.associationedKeyword;
    self.numberLabel.text = [NSString stringWithFormat:@"约%ld件",(long)PhraseAssociation.associationedNumber];
}

@end
