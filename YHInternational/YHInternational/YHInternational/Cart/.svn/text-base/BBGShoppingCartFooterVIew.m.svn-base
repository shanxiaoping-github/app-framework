//
//  BBGShoppingCartFooterVIew.m
//  YHInternational
//
//  Created by yangjie on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShoppingCartFooterVIew.h"

@implementation BBGShoppingCartFooterVIew
- (id)initWithModel:(BBGProductsCartGroup *)group{
    self = [super init];
    if (self) {
        //[self setFrame:CGRectMake(0, 0, IPHONE_WIDTH, 20)];
        [self createView:group];
    }
    return self;
}

- (void)createView:(BBGProductsCartGroup *)group{
    UILabel *lastLabel;
    for (int i=0; i<4; i++) {
        BBGProductCartPromotion *promotion = [group.promotions ARRAY_OBJ_AT(i)];
        UILabel *titleLabel = [UILabel new];
        [titleLabel setText:@"111"];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@37);
            make.top.mas_equalTo(lastLabel ? lastLabel.mas_bottom :@2);
        }];
        lastLabel = titleLabel;
    }
    
    UIImageView *lineView = [UIImageView imageViewWithMyImage:@"HorizontalLine" stretchInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [lineView setBackgroundColor:DEBUG_COLOR];
    [self addSubview:lineView];
    
    UILabel *payLabel = [UILabel new];
    [payLabel setText:@"100元"];
    [payLabel sizeToFit];
    [payLabel setTextColor:UICOLOR_FONT_IMPORTANT_RED];
    [payLabel setBackgroundColor:DEBUG_COLOR];
    [self addSubview:payLabel];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(@30);
        make.size.mas_equalTo(CGSizeMake(IPHONE_WIDTH-30, 1));
    }];

    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastLabel.mas_bottom).offset(20);
        //make.size.mas_equalTo(CGSizeMake(100, 20));
        //make.left.mas_equalTo(@(20));
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//        make.width.mas_equalTo(IPHONE_WIDTH);
//        make.bottom.mas_equalTo(payLabel.mas_bottom).offset(20);
//    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
