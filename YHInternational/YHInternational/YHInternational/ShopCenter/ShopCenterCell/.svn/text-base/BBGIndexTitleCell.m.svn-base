
//
//  BBGIndexTitleCell.m
//  YHInternational
//
//  Created by 黄 灿 on 15/7/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIndexTitleCell.h"

@implementation BBGIndexTitleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorFromHexadecimalRGB(0xe5e5e5);
    [self.contentView addSubview:lineView];
    
    _linewView_1 = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, IPHONE_WIDTH, 0.5)];
    _linewView_1.backgroundColor = UIColorFromHexadecimalRGB(0xe5e5e5);
    [self.contentView addSubview:_linewView_1];
    
    
    _title = [[UILabel alloc]init];
    _title.font = APP_FONT(14);
    _title.textColor = UICOLOR_FONT_IMPORTANT_BLACK;
    _title.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_title];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(13);
        make.size.mas_equalTo(CGSizeMake(200, 14));
    }];

    
    
    return self;
}

- (void)updateTitle:(NSString *)str{
    _title.text = str;
}
-(void)dismissBottomLine{
    _linewView_1.alpha=0;
}
-(void)showBottomLine{
    _linewView_1.alpha=1;
}
@end
