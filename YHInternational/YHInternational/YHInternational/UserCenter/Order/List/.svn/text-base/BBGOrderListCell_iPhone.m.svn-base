//
//  BBGOrderListCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderListCell_iPhone.h"
#import "UIImageView+WebCache.h"
@interface BBGOrderListCell_iPhone()
@property (strong, nonatomic) IBOutlet UIImageView *productImg;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productAttr;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *numLbl;
@property (nonatomic ,strong) UIImageView *giftImageView;
@end

@implementation BBGOrderListCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = UIColorFromRGB(249, 246, 250);
    self.productName.textColor = UIColorFromHexadecimalRGB(0x333333);
    self.price.textColor = UIColorFromHexadecimalRGB(0x333333);
    self.productAttr.textColor = UIColorFromHexadecimalRGB(0x666666);
    
    self.numLbl.layer.masksToBounds = YES;
    self.numLbl.layer.cornerRadius = 7.0;
    
    _crosssedLabel = [[UILabel alloc]init];
    _crosssedLabel.textColor =UICOLOR_FONT_GENERAL_GRAY;
    _crosssedLabel.font=APP_FONT(12);
    _crosssedLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_crosssedLabel];
    [_crosssedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.price.mas_right);
        make.top.equalTo(self.price.mas_bottom).offset(3);
        make.height.mas_equalTo(@12);
    }];
    _giftImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shoppingCartGift"]];
    _giftImageView.tag = 995;
    [self.productImg addSubview:_giftImageView];
    
    
    [_giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImg.mas_left).offset(3);
        make.top.equalTo(self.productImg.mas_top).offset(3);
        make.size.mas_equalTo(_giftImageView.image.size);
    }];
}

-(void)updateOrderCellWithOrder:(BBGOrderProduct *)orderProduct{
    
    WS(weakSelf);
    [self.productImg sd_setImageWithURL:    
     [NSURL URLWithString:orderProduct.imageUrl] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         if (cacheType ==SDImageCacheTypeNone) {
             [weakSelf.productImg setFadeInWithDefaultTime];
         }
     }];
    
    if ([orderProduct.itemType isEqualToString:@"gift"]) {

        _giftImageView.alpha=1;
    }else{
        _giftImageView.alpha=0;
    }
    
    self.productName.text = orderProduct.name;
    if (orderProduct.specText && ![@"" isEqualToString:orderProduct.specText]) {
        self.productAttr.text = orderProduct.specText;
    }else{
        self.productAttr.text = nil;
    }
    self.price.text =  [NSString stringWithFormat:@"￥%.2f",orderProduct.unCrossedPrice/100];
    self.numLbl.text = [NSString stringWithFormat:@"x%ld",(long)orderProduct.buyNum];
    
    
    if (!orderProduct.crossedPrice) {
        return;
    }
    
    
    NSString *finalStr =[NSString stringWithFormat:@"￥%.2f",orderProduct.crossedPrice/100];
    
    NSMutableAttributedString * attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",finalStr]];
    
    [attrStr1 addAttribute:NSFontAttributeName value:APP_FONT(12.0) range:NSMakeRange(0, finalStr.length)];
    
    [attrStr1 addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_GENERAL_GRAYLIGHT range:NSMakeRange(0, finalStr.length)];
    
    
    [attrStr1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, finalStr.length)];
    [attrStr1 addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, finalStr.length)];
    
    _crosssedLabel.attributedText = attrStr1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
