//
//  BBGShoppingCartFooterViewCell.m
//  YHInternational
//
//  Created by yangjie on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShoppingCartFooterViewCell.h"

@implementation BBGShoppingCartFooterViewCell

- (id)initWithModel:(BBGProductsCartGroup *)group{
    self = [super init];
    if (self) {
        [self createView:group];
    }
    return self;
}

- (void)createView:(BBGProductsCartGroup *)group{
    NSString *totalFreightStr = [NSString stringWithFormat:@"运费:￥%0.2f",group.totalFreight/100.0];
    //NSString *totalTariffStr = [NSString stringWithFormat:@"关税:￥%0.2f",group.totalTariff/100.0];
    NSString *totalRealPriceStr = [NSString stringWithFormat:@"合计:￥%0.2f",group.totalRealPrice/100.0];
    
    //总优惠
    NSString *totalPmtStr = @"";
    if (group.totalPmt != 0) {
        totalPmtStr = [NSString stringWithFormat:@"活动优惠:-￥%0.2f",group.totalPmt/100.0];
    }
    UILabel *lastLabel;
    for (int i=0; i<[group.promotions COUNT]; i++) {
        BBGProductCartPromotion *promotion = [group.promotions ARRAY_OBJ_AT(i)];
        UILabel *titleLabel = [UILabel new];
        [titleLabel setText:promotion.ad];
        [titleLabel setFont:APP_FONT(12)];
        [titleLabel setTextColor:UICOLOR_FONT_GENERAL_GRAY];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@36);
            if (lastLabel == nil) {
                make.top.mas_equalTo(@6);
            }else{
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(4);
            }
        }];
        lastLabel = titleLabel;
    }
    
    UIImageView *lineViewOne = [UIImageView imageViewWithMyImage:@"HorizontalLine" stretchInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.contentView addSubview:lineViewOne];
    
    UILabel *totalFreightLabel = [UILabel new];
    [totalFreightLabel setFont:APP_FONT_DEMI_LIGHT(12)];
    [totalFreightLabel setTextColor:UICOLOR_FONT_GENERAL_GRAYLIGHT];
    [totalFreightLabel setText:totalFreightStr];
    [self.contentView addSubview:totalFreightLabel];
    
    UILabel *totalTariffLabel = [UILabel new];
    [totalTariffLabel setFont:APP_FONT_DEMI_LIGHT(12)];
    [totalTariffLabel setTextColor:UICOLOR_FONT_GENERAL_GRAYLIGHT];
//    [totalTariffLabel setText:totalTariffStr];
    [totalTariffLabel setText:@" "];
    [self.contentView addSubview:totalTariffLabel];
    
    UILabel *totalRealPriceLabel = [UILabel new];
    [totalRealPriceLabel setFont:APP_FONT_DEMI_LIGHT(16)];
    [totalRealPriceLabel setText:totalRealPriceStr];
    [totalRealPriceLabel sizeToFit];
    [totalRealPriceLabel setTextColor:UICOLOR_FONT_IMPORTANT_RED];
    [self.contentView addSubview:totalRealPriceLabel];
    
    UILabel *totalPmtLabel = [UILabel new];
    [totalPmtLabel setFont:APP_FONT_DEMI_LIGHT(16)];
    [totalPmtLabel setText:totalPmtStr];
    [totalPmtLabel sizeToFit];
    [totalPmtLabel setTextColor:UICOLOR_FONT_IMPORTANT_RED];
    [self.contentView addSubview:totalPmtLabel];
    
    UIView *gapView = [UIView new];
    [gapView setBackgroundColor:RGB_COLOR(240, 239, 237)];
    [self.contentView addSubview:gapView];
    
    UIImageView *lineViewTwo = [UIImageView imageViewWithMyImage:@"HorizontalLine" stretchInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [gapView addSubview:lineViewTwo];
    
    
    
    if ([group.promotions COUNT] == 0) {
        [lineViewOne setHidden:YES];
    }
    
    [lineViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([group.promotions COUNT] == 0) {
            [lineViewOne setHidden:YES];
            make.top.equalTo(lastLabel ? lastLabel.mas_bottom : @0).offset(0);
        }else{
            [lineViewOne setHidden:NO];
            make.top.equalTo(lastLabel ? lastLabel.mas_bottom : @0).offset(8);
        }
        make.left.mas_equalTo(@30);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
    
    [totalFreightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineViewOne.mas_bottom).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [totalTariffLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineViewOne.mas_bottom).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
    }];
    
    [totalRealPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(totalTariffLabel.mas_bottom).offset(6);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [totalPmtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(totalTariffLabel.mas_bottom).offset(6);
        make.right.mas_equalTo(totalRealPriceLabel.mas_left).offset(-10);
    }];
    
    [gapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(totalRealPriceLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(IPHONE_WIDTH, 10));
    }];
    
    [lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(gapView.mas_top);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(gapView.mas_right);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(IPHONE_WIDTH);
        make.bottom.mas_equalTo(gapView.mas_bottom).offset(0);
    }];
}


@end
