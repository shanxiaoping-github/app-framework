//
//  BBGNextSecKillCell.m
//  YHInternational
//
//  Created by 黄 灿 on 15/7/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGNextSecKillCell.h"

@implementation BBGNextSecKillCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 0.5)];
    lineView.backgroundColor=UIColorFromHexadecimalRGB(0xe5e5e5);
    [self.contentView addSubview:lineView];
    
    
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, 39.5, IPHONE_WIDTH, 0.5)];
    lineView1.backgroundColor=UIColorFromHexadecimalRGB(0xe5e5e5);
    [self.contentView addSubview:lineView1];
    
    
  
    
    secKillImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"allSeckill"]];
    [self.contentView addSubview:secKillImageView];
    [secKillImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(secKillImageView.image.size.width);
        make.height.mas_equalTo(secKillImageView.image.size.height);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    
   
    return self;
}
-(void)updateCell:(id)response{
    
}
@end
