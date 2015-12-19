//
//  BBGBrandCell.m
//  YHInternational
//
//  Created by 黄 灿 on 15/7/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBrandCell.h"
@implementation BBGBrandCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)updateCell:(id)response isUp:(BOOL)isUp{
    for (int i=0; i<[response count]; i++) {
        BBGIndexRecomendInitInfo *info = response[i];
        if ([info.btnId isEqualToString:@"brand_service"]) {
            switch ([info.sort integerValue]) {
                case 1:
                {
                    [imageview1 sd_setImageWithURL:[NSURL URLWithString:info.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (cacheType==SDImageCacheTypeNone) {
                            [imageview1 setFadeInWithDefaultTime];
                        }
                        
                    }];
                    label1.text=info.Name;
                }
                    break;
                case 2:
                {
                    [imageview2 sd_setImageWithURL:[NSURL URLWithString:info.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (cacheType==SDImageCacheTypeNone) {
                            [imageview2 setFadeInWithDefaultTime];
                        }
                        
                    }];
                    label2.text=info.Name;
                }
                    break;
                case 3:
                {
                    
                    [imageview3 sd_setImageWithURL:[NSURL URLWithString:info.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (cacheType==SDImageCacheTypeNone) {
                            [imageview3 setFadeInWithDefaultTime];
                        }
                        
                    }];
                    label3.text=info.Name;
                }
                    break;
                case 4:
                {
                    [imageview4 sd_setImageWithURL:[NSURL URLWithString:info.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (cacheType==SDImageCacheTypeNone) {
                            [imageview4 setFadeInWithDefaultTime];
                            
                        }
                    }];
                    label4.text=info.Name;
                }
                    break;
                default:
                    break;
            }
        }
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    imageview1 = [[UIImageView alloc]init];
    imageview1.tag=101;
    imageview1.image=[UIImage imageNamed:@"brandDefault"];
    imageview1.userInteractionEnabled=YES;
    imageview2 = [[UIImageView alloc]init];
    imageview2.image=[UIImage imageNamed:@"brandDefault"];
    imageview2.tag=102;
    imageview2.userInteractionEnabled=YES;
    imageview3 = [[UIImageView alloc]init];
    imageview3.image=[UIImage imageNamed:@"brandDefault"];
    imageview3.tag=103;
    imageview3.userInteractionEnabled=YES;
    imageview4 = [[UIImageView alloc]init];
    imageview4.image=[UIImage imageNamed:@"brandDefault"];
    imageview4.tag=104;
    imageview4.userInteractionEnabled=YES;
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 0.5)];
    lineView.backgroundColor=UIColorFromHexadecimalRGB(0xe5e5e5);
    [self.contentView addSubview:lineView];
    
    
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, 84.5, IPHONE_WIDTH, 0.5)];
    lineView1.backgroundColor=UIColorFromHexadecimalRGB(0xe5e5e5);
    [self.contentView addSubview:lineView1];
    
    [self.contentView addSubview:imageview1];
    [self.contentView addSubview:imageview2];
    [self.contentView addSubview:imageview3];
    [self.contentView addSubview:imageview4];
    
    label1 = [[UILabel alloc]init];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=APP_FONT_DEMI_LIGHT(13);
    label1.textColor=UICOLOR_FONT_GENERAL_GRAY;
    //    label1.text=@"全球直采";
    [self.contentView addSubview:label1];
    
    
    label2 = [[UILabel alloc]init];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.font=APP_FONT_DEMI_LIGHT(13);
    label2.textColor=UICOLOR_FONT_GENERAL_GRAY;
    //    label2.text=@"正品保证";
    [self.contentView addSubview:label2];
    
    
    label3 = [[UILabel alloc]init];
    label3.textAlignment=NSTextAlignmentCenter;
    label3.font=APP_FONT_DEMI_LIGHT(13);
    label3.textColor=UICOLOR_FONT_GENERAL_GRAY;
    //    label3.text=@"免税特卖";
    [self.contentView addSubview:label3];
    
    
    label4 = [[UILabel alloc]init];
    label4.textAlignment=NSTextAlignmentCenter;
    label4.font=APP_FONT_DEMI_LIGHT(13);
    label4.textColor=UICOLOR_FONT_GENERAL_GRAY;
    //    label4.text=@"国内售后";
    [self.contentView addSubview:label4];
    
    [imageview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@13);
        make.left.equalTo(self.contentView.mas_left).offset((IPHONE_WIDTH-4*42)*0.161);
        make.centerY.equalTo(@[imageview2,imageview3,imageview4]);
        make.size.mas_equalTo(CGSizeMake(42, 42));
    }];
    
    [imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(42, 42));
        make.left.equalTo(imageview1.mas_right).offset((IPHONE_WIDTH-4*42)*0.229);
    }];
    [imageview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(42, 42));
        make.left.equalTo(imageview2.mas_right).offset((IPHONE_WIDTH-4*42)*0.229);
    }];
    
    [imageview4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(42, 42));
        make.left.equalTo(imageview3.mas_right).offset((IPHONE_WIDTH-4*42)*0.229);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageview1.mas_bottom).offset(5);
        make.centerX.equalTo(imageview1.mas_centerX);
        make.centerY.equalTo(@[label2,label3,label4]);
        make.size.mas_equalTo(CGSizeMake(80, 13));
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageview2.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 13));
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageview3.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 13));
    }];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageview4.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 13));
    }];
    NSArray *imageArray = [NSArray arrayWithObjects:imageview1,imageview2,imageview3,imageview4, nil];
    
    
    for (int i=0; i<4; i++) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(indexSelect:)];
        [imageArray[i] addGestureRecognizer:gesture];
    }
    
    
    return self;
}
- (void)indexSelect:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 101:
            [self.delegate WhichPartSelect:0];
            break;
        case 102:
            [self.delegate WhichPartSelect:1];
            break;
        case 103:
            [self.delegate WhichPartSelect:2];
            break;
        case 104:
            [self.delegate WhichPartSelect:3];
            break;
        default:
            break;
    }
}
@end
