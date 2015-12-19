//
//  BBGShoppingCartHeaderView.m
//  YHInternational
//
//  Created by yangjie on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShoppingCartHeaderView.h"


@implementation BBGShoppingCartHeaderView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    UIImageView *lineView = [UIImageView imageViewWithMyImage:@"HorizontalLine" stretchInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self addSubview:lineView];
    
    _selectBtn = [UIButton new];
    [_selectBtn addTarget:self action:@selector(selectBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    [_selectBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self addSubview:_selectBtn];
    
    _shopIconImageView = [UIImageView imageViewWithMyImage:@"shoppingIcon"];
    [self addSubview:_shopIconImageView];
    
    _shopNameLabel = [UILabel new];
    [_shopNameLabel setFont:APP_FONT(16)];
    [self addSubview:_shopNameLabel];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(-1);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(self.mas_right);
    }];
    
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.centerY.mas_equalTo(self);
    }];
    
    [_shopIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_selectBtn.mas_right).offset(0);
        make.centerY.mas_equalTo(self);
    }];
    
    [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_shopIconImageView.mas_right).offset(10);
        make.right.mas_lessThanOrEqualTo(self).offset(-10);
        make.centerY.mas_equalTo(self);
    }];
    
    [_shopNameLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)reloadViewWithModel:(BBGProductsCartGroup*)model{
    if (model.selected == 1) {
        [_selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }else if (model.selected == 2){
        [_selectBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"shoppingIconStop"] forState:UIControlStateNormal];
    }
    _shopNameLabel.text = model.shopName;
}

- (void)selectBtnPressed:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(selectedSection:)]) {
        [self.delegate selectedSection:_section];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
