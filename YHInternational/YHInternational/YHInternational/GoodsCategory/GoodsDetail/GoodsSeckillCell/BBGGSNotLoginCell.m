//
//  BBGGSNotLoginCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSNotLoginCell.h"

@implementation BBGGSNotLoginCell

- (void)awakeFromNib {
    // Initialization code
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height-0.5f, IPHONE_WIDTH, 0.5f);
    bottomBorder.backgroundColor = [RGB_CELL_GRAY CGColor];
    [self.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
