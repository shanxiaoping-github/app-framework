//
//  BBGCosmeticSectionHeader_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/7/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCosmeticSectionHeader_iPhone.h"

@implementation BBGCosmeticSectionHeader_iPhone

- (void)awakeFromNib {
    // Initialization code
    
}

- (IBAction)brandButtonPressed:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionHeader:didSelectedAtIndex:)]) {
        [self.delegate sectionHeader:self didSelectedAtIndex:self.index];
    }
}

- (void)updateSectionHeaderWith:(BBGBrand *)brand {

    if (brand.brandType == BBGPopularBrandType) {
        self.brandNameLabel.hidden = YES;
        self.brandImageView.hidden = NO;
        self.separateImageView.hidden = NO;
        [self.brandImageView sd_setImageWithURL:[NSURL URLWithString:brand.url] placeholderImage:[UIImage imageNamed:@"brandGroupDefualt"]];
    }else {
        self.brandNameLabel.hidden = NO;
        self.brandImageView.hidden = YES;
        self.separateImageView.hidden = YES;
        self.brandNameLabel.text = brand.brandName;
    }
}

@end
