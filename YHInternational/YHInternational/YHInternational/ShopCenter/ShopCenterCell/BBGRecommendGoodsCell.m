
//
//  BBGRecommendGoodsCell.m
//  YHInternational
//
//  Created by 黄 灿 on 15/7/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRecommendGoodsCell.h"

@implementation BBGRecommendGoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    backImageView = [[UIImageView alloc]init];
    backImageView.layer.borderColor=[[UIColor blackColor]CGColor];
    backImageView.userInteractionEnabled=YES;
    [self.contentView addSubview:backImageView];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(IPHONE_WIDTH, IPHONE_WIDTH/375*140));
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
    }];
    
    infoView = [[UIView alloc]init];
    [backImageView addSubview:infoView];
    
    
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(IPHONE_WIDTH/2, IPHONE_WIDTH/375*140));
        make.top.equalTo(self.contentView.mas_top).offset(0);
    }];
    
    dashLineView = [[UIImageView alloc]init];
    [infoView addSubview:dashLineView];
    [dashLineView setImage:[[UIImage imageNamed:@"DashedLine"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile]];
    [dashLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).offset(5);
        make.right.equalTo(infoView.mas_right).offset(-10);
        float a=IPHONE_WIDTH/375*70;
        make.top.mas_equalTo(infoView.mas_top).offset(a);
    }];
    

    titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines=2;
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.font=APP_FONT_DEMI_LIGHT(14);
    titleLabel.textColor=UICOLOR_FONT_IMPORTANT_BLACK;
    titleLabel.text=@"[保税区发货]雅思兰黛鲜活亮采双融乳液";
    [infoView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView.mas_left).offset(5);
        make.right.equalTo(infoView.mas_right).offset(-10);
        make.top.mas_equalTo(infoView.mas_top).offset(((IPHONE_WIDTH/375*70)-26)/2);
        make.height.mas_equalTo(@32);
    }];
    
    cartImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cartRecommend"]];
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddCart:)];
    [cartImageView addGestureRecognizer:gesture];
    cartImageView.userInteractionEnabled=YES;
    [infoView addSubview:cartImageView];
    
    
    payLable = [[UILabel alloc]init];
    payLable.textAlignment=NSTextAlignmentLeft;
    [infoView addSubview:payLable];
    salePriceLabel = [[UILabel alloc]init];
    salePriceLabel.textAlignment=NSTextAlignmentLeft;
    [infoView addSubview:salePriceLabel];
    
    [cartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(infoView.mas_right).offset(-10);
        make.bottom.equalTo(infoView.mas_bottom).offset((infoView.frame.size.height-dashLineView.frame.origin.y-cartImageView.image.size.height)/2);
    }];
    
    /**
     *  在cell底部加一根线
     *  高度=1  颜色 oxe5e5e5
     */
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, IPHONE_WIDTH/375*140-0.5, IPHONE_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorFromHexadecimalRGB(0xe5e5e5);
    [backImageView addSubview:lineView];
    

    
    UIView *leftBackView = [[UIView alloc]init];
    [backImageView addSubview:leftBackView];
    [leftBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImageView.mas_left);
        make.top.equalTo(backImageView.mas_top);
        make.bottom.equalTo(backImageView.mas_bottom);
        make.right.equalTo(infoView.mas_left);
    }];
    
    watermarkImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alreadySaleOut"]];
    [leftBackView addSubview:watermarkImageView];
    [watermarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(leftBackView);
    }];
    
    
    return self;
}
- (void)AddCart:(UITapGestureRecognizer *)sender{
    [self.delegate recommendIndexClicked:_indexpath];
}
- (void)updateCell:(BBGRecommendProduct *)product isUp:(BOOL)isUp{
    titleLabel.text = product.productName;
    [backImageView sd_setImageWithURL:[NSURL URLWithString:product.imageUrl] placeholderImage:[UIImage imageNamed:@"defaultImageLeft"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (isUp) {
            backImageView.alpha=0;
            [UIView animateWithDuration:0.4 animations:^{
                backImageView.alpha = 1;
            }];

        }
        }];
    if ([product.productType integerValue]==0) {
        if (product.store>0) {
            cartImageView.image = [UIImage imageNamed:@"cartRecommend"];
            cartImageView.userInteractionEnabled = YES;
        }
        else
        {
            cartImageView.image = [UIImage imageNamed:@"cartRecommendNo"];
            cartImageView.userInteractionEnabled = NO;
        }

    }
    else
    {
        if (product.store>0) {
            cartImageView.image=[UIImage imageNamed:@"payRecommend"];
            cartImageView.userInteractionEnabled = YES;

        }
        else
        {
            cartImageView.image=[UIImage imageNamed:@"payRecommendNo"];
            cartImageView.userInteractionEnabled = NO;
        }

    }
    
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

    NSString * payStr;
    NSString * finalStr;
    if (!product.crossedPrice) {
        payStr = [NSString stringWithFormat:@"￥%.2f",[product.unCrosedPrice integerValue]/100.0];
        finalStr = @"";
    }else{
        payStr = [NSString stringWithFormat:@"￥%.2f",[product.unCrosedPrice integerValue]/100.0];
        finalStr = [NSString stringWithFormat:@"￥%.2f",[product.crossedPrice integerValue]/100.0];
    }
    
    /**
    解决窄屏幕上显示不全的问题
     */
    float bigger,smaller;
    if (IPHONE_WIDTH==320) {
        bigger = 18.0;
        smaller = 10.0;
    }else{
        bigger = 22.0;
        smaller = 13.0;
    }
    
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",payStr]];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(smaller) range:NSMakeRange(0, 1)];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(bigger) range:NSMakeRange(1, payStr.length - 3)];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(smaller) range:NSMakeRange(payStr.length - 3, 3)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange(0, payStr.length)];
    
    
    payLable.attributedText = attrStr;
    [payLable setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [payLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dashLineView.mas_left);
        make.centerY.equalTo(cartImageView.mas_centerY);
        make.height.mas_equalTo(bigger);
    }];

    
    //sale价格
    NSMutableAttributedString * attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",finalStr]];
    
    [attrStr1 addAttribute:NSFontAttributeName value:APP_FONT(smaller) range:NSMakeRange(0, finalStr.length)];
    
    [attrStr1 addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_GENERAL_GRAYLIGHT range:NSMakeRange(0, finalStr.length)];
    
    
    [attrStr1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, finalStr.length)];
    [attrStr1 addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, finalStr.length)];
    
    salePriceLabel.attributedText = attrStr1;
    [salePriceLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [salePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(payLable.mas_bottom);
        
        make.left.equalTo(payLable.mas_right).offset(10);
        make.right.equalTo(cartImageView.mas_left).offset(-5);
        make.height.mas_equalTo(smaller);
    }];
    
}
@end
