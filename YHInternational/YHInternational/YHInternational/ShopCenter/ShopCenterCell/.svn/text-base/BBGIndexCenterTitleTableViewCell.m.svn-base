//
//  BBGIndexCenterTitleTableViewCell.m
//  YHInternational
//
//  Created by 黄 灿 on 15/10/23.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGIndexCenterTitleTableViewCell.h"

@implementation BBGIndexCenterTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        leftImageView = [[UIImageView alloc]init];
        rightImageView = [[UIImageView alloc]init];
        centerLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:leftImageView];
        [self.contentView addSubview:rightImageView];
        [self.contentView addSubview:centerLabel];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        UIView *topLineView = [[UIView alloc]init];
        topLineView.backgroundColor = UIColorFromHexadecimalRGB(0xe5e5e5);
        [self.contentView addSubview:topLineView];
        [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(@0.5);
        }];
        
        UIView *bottomLineView = [[UIView alloc]init];
        bottomLineView.backgroundColor = UIColorFromHexadecimalRGB(0xe5e5e5);
        [self.contentView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(@0.5);
        }];

    }
    return self;
}
- (void)updateCell:(NSString *)name{
    
    
    centerLabel.font = APP_FONT(14);
    centerLabel.text = name;
    centerLabel.textColor = UIColorFromHexadecimalRGB(0x333333);
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(@14);
    }];
    
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(centerLabel.mas_left).offset(-10);
    }];
    
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(centerLabel.mas_right).offset(10);
    }];
}

- (void)setSeckillTitleCell{
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"seckillTitle"]];
    [self.contentView addSubview:imageview];
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(imageview.image.size.width);
        make.height.mas_equalTo(imageview.image.size.height);
    }];
    
//    leftImageView.image = [UIImage imageNamed:@"seckillLine_right"];
//    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.mas_centerY);
//        make.right.equalTo(imageview.mas_left).offset(-10);
//    }];
//    
//    rightImageView.image = [UIImage imageNamed:@"seckillLine_left"];
//    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.mas_centerY);
//        make.left.equalTo(imageview.mas_right).offset(10);
//    }];
}

@end
