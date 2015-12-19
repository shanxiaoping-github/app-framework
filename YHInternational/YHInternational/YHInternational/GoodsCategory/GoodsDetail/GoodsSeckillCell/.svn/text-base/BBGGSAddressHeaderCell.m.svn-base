//
//  BBGGSAddressHeaderCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSAddressHeaderCell.h"

@interface BBGGSAddressHeaderCell ()
@property (strong, nonatomic) IBOutlet UILabel *addrTitle;
@property (strong, nonatomic) IBOutlet UIImageView *grayImage;
@property (strong, nonatomic) IBOutlet UILabel *grayLabel;

@end

@implementation BBGGSAddressHeaderCell

- (void)updateCell:(BOOL)mark {
    if (mark) {
        self.grayLabel.hidden = NO;
        self.grayImage.hidden = NO;
        self.addrTitle.text = @"收货地址";
    }else {
        self.grayLabel.hidden = YES;
        self.grayImage.hidden = YES;
        self.addrTitle.text = @"请填写收货信息";
    }
}

- (void)awakeFromNib {
    // Initialization code
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake(0, 0, IPHONE_WIDTH, 0.5f);
    topLayer.backgroundColor = RGB_CELL_GRAY.CGColor;
    [self.layer addSublayer:topLayer];
    
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake(0, self.frame.size.height-0.5f, IPHONE_WIDTH, 0.5f);
    bottomLayer.backgroundColor = RGB_CELL_GRAY.CGColor;
    [self.layer addSublayer:bottomLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
