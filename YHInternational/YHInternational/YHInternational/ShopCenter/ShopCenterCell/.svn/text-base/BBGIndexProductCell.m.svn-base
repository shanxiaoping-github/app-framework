//
//  BBGIndexProductCell.m
//  YHFresh
//
//  Created by 黄 灿 on 15/9/11.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import "BBGIndexProductCell.h"

@implementation BBGIndexProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(weakSelf);
        backImageView = [[UIImageView alloc]init];
        backImageView.userInteractionEnabled=NO;
        [self.contentView addSubview:backImageView];
        
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.contentView);
            make.right.equalTo(weakSelf.contentView);
            make.bottom.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.contentView);
        }];
        
        
        UIView *leftBackView = [[UIView alloc]init];
        [backImageView addSubview:leftBackView];
        [leftBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backImageView);
            make.top.equalTo(backImageView);
            make.bottom.equalTo(backImageView);
            make.width.mas_equalTo(IPHONE_WIDTH/2);
        }];
        
        watermarkImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alreadySaleOut"]];
        [leftBackView addSubview:watermarkImageView];
        [watermarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(leftBackView);
        }];
        
        
        
        infoView = [[UIView alloc]init];
        [backImageView addSubview:infoView];
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backImageView);
            make.bottom.equalTo(backImageView);
            make.top.equalTo(backImageView);
            make.left.equalTo(leftBackView.mas_right);
        }];
        
        smallInfoView = [[UIView alloc]init];
        [infoView addSubview:smallInfoView];
        [smallInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(infoView);
            make.width.equalTo(infoView.mas_width);
        }];
        
        
        
        
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.numberOfLines=3;
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.font=APP_FONT_DEMI_LIGHT(14);
        titleLabel.textColor=UICOLOR_FONT_IMPORTANT_BLACK;
        [smallInfoView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(smallInfoView);
            make.left.equalTo(smallInfoView);
            make.right.equalTo(smallInfoView.mas_right).offset(-10);
        }];

        
        
        cartImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cartRecommend"]];
        UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddCart:)];
        [cartImageView addGestureRecognizer:gesture];
        cartImageView.userInteractionEnabled=YES;
        [infoView addSubview:cartImageView];
        [cartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(infoView.mas_right).offset(-10);
            make.bottom.equalTo(infoView.mas_bottom).offset(-10);
            make.size.mas_equalTo(cartImageView.image.size);
        }];
        
        
        payLable = [[UILabel alloc]init];
        payLable.textAlignment=NSTextAlignmentLeft;
        [smallInfoView addSubview:payLable];
        salePriceLabel = [[UILabel alloc]init];
        salePriceLabel.textAlignment=NSTextAlignmentLeft;
        [smallInfoView addSubview:salePriceLabel];
        
        
       
        
       
        
        
        lineView = [[UIView alloc]init];
        lineView.backgroundColor = UIColorFromHexadecimalRGB(0xe5e5e5);
        [backImageView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(backImageView);
            make.left.equalTo(backImageView);
            make.right.equalTo(backImageView);
            make.height.mas_equalTo(@0.5);
        }];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}
- (void)AddCart:(UITapGestureRecognizer *)sender{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(recommendIndexClicked:)]&&_RecProduct.goodsStatus==0) {
        [self.delegate recommendIndexClicked:_indexpath];
    }
    
}
- (void)updateCell:(BBGRecommendProduct *)product isUp:(BOOL)isUp{
    
    _RecProduct = product;
    
       
    
    [backImageView sd_setImageWithURL:[NSURL URLWithString:product.imageUrl] placeholderImage:[UIImage imageNamed:@"defaultImageLeft"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [backImageView setFadeInWithDefaultTime];
        }
    }];
    
    
 

    
    switch (product.goodsStatus) {
        case 1:
        {
            watermarkImageView.image = [UIImage imageNamed:@"alreadyOut"];
            watermarkImageView.alpha = 1;
        }
            break;
        case 2:
        {
            watermarkImageView.image = [UIImage imageNamed:@"alreadySaleOut"];
            watermarkImageView.alpha = 1;
        }
            break;
        case 3:
        {
            watermarkImageView.image = [UIImage imageNamed:@"alreadyUndercarriage"];
            watermarkImageView.alpha = 1;
        }
            break;
        default:
        {
            watermarkImageView.alpha = 0;
        }
            break;
    }
    
    
    
    
    if ([product.productType integerValue]==0) {
        if (product.goodsStatus==0) {
            cartImageView.image = [UIImage imageNamed:@"cartRecommend"];
        }
        else
        {
            cartImageView.image = [UIImage imageNamed:@"cartRecommendNo"];
        }
        
    }
    else
    {
        if (product.goodsStatus==0) {
            cartImageView.image=[UIImage imageNamed:@"payRecommend"];
        }
        else
        {
            cartImageView.image=[UIImage imageNamed:@"payRecommendNo"];
        }
        
    }
    
    
    NSString * payStr;
    NSString * finalStr;
    if (!product.crossedPrice) {
        payStr = [NSString stringWithFormat:@"￥%.2f",[product.unCrosedPrice integerValue]/100.0];
        finalStr = @"";
    }else{
        payStr = [NSString stringWithFormat:@"￥%.2f",[product.unCrosedPrice integerValue]/100.0];
        finalStr = [NSString stringWithFormat:@"￥%.2f",[product.crossedPrice integerValue]/100.0];
    }
    
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",payStr]];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(12) range:NSMakeRange(0, 1)];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(20) range:NSMakeRange(1, payStr.length - 3)];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(12) range:NSMakeRange(payStr.length - 3, 3)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange(0, payStr.length)];
  
    [payLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(smallInfoView);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(smallInfoView);
        make.height.mas_equalTo(@20);
    }];
    [payLable setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    payLable.attributedText = attrStr;
    
    //sale价格
    NSMutableAttributedString * attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",finalStr]];
    
    [attrStr1 addAttribute:NSFontAttributeName value:APP_FONT(12) range:NSMakeRange(0, finalStr.length)];
    
    [attrStr1 addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_GENERAL_GRAYLIGHT range:NSMakeRange(0, finalStr.length)];
    
    
    [attrStr1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, finalStr.length)];
    [attrStr1 addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, finalStr.length)];
 
    
    [salePriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(payLable.mas_bottom);
        
        make.left.equalTo(payLable.mas_right).offset(10).priorityHigh();
        make.right.equalTo(cartImageView.mas_left).offset(-10).priorityLow();
         make.height.mas_equalTo(@12);
    }];
    
    salePriceLabel.attributedText = attrStr1;
    [salePriceLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    

    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:product.productName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    paragraphStyle.lineSpacing = 4;  //行自定义行高度
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,product.productName.length)];
    titleLabel.attributedText = attributedString;



    
}


@end
