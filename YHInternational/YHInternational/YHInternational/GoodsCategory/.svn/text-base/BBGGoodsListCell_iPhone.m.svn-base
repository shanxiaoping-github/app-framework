//
//  BBGGoodsListCell_iPhone.m
//  YHInternational
//
//  Created by Timmy Ouyang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsListCell_iPhone.h"
#import "UIImageView+WebCache.h"

@interface BBGGoodsListCell_iPhone ()


//商品名称
@property (weak, nonatomic) IBOutlet UILabel *productNameLbl;
//商品描述
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *salePriceLbl;
//国家名称
@property (weak, nonatomic) IBOutlet UILabel *countryLbl;
//国旗图标
@property (weak, nonatomic) IBOutlet UIImageView *countryFlag;
//评论数
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;
//点赞数
@property (weak, nonatomic) IBOutlet UILabel *praiseCount;
//分割线
@property (strong, nonatomic) IBOutlet UIImageView *seperatLine;
//加入购物车（立即购买图标）
@property (weak, nonatomic) IBOutlet UIImageView *addCartImageView;
//划线价格标签
@property (weak, nonatomic) IBOutlet UILabel *crossPriceLabel;
//加入购物车按钮
@property (weak, nonatomic) IBOutlet UIButton *addCartButton;
@end

@implementation BBGGoodsListCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    self.activityContent.layer.masksToBounds = YES;
    self.activityContent.layer.cornerRadius = 3;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addCart:(id)sender {
    UIButton *btn = (UIButton *)sender;
    //tag为0时，表示商品状态正常可售，购物车按钮正常可点
    if (btn.tag == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodsListCell:itemDidSelectedWith:)]) {
            [self.delegate goodsListCell:self itemDidSelectedWith:AddCartItem];
        }
    }
}

- (IBAction)comment:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsListCell:itemDidSelectedWith:)]) {
        [self.delegate goodsListCell:self itemDidSelectedWith:CommentItem];
    }
}

- (IBAction)praise:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsListCell:itemDidSelectedWith:)]) {
        [self.delegate goodsListCell:self itemDidSelectedWith:PraiseItem];
    }
}

- (void)updateCellWith:(BBGSearchProduct *)product {
    WS(weakSelf);
    CGRect lineframe = self.seperatLine.frame;
    lineframe.origin.y += 1.0;
    self.seperatLine.frame = lineframe;

    [self.productImage sd_setImageWithURL:[NSURL URLWithString:product.productImageURL] placeholderImage:[UIImage imageNamed:@"goodsDefault"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [weakSelf.productImage setFadeInWithDefaultTime];
        }

    }];
    self.productNameLbl.text = product.productName;
    self.descriptionLbl.text = product.goodsExplain;
    if (product.promotionInfo) {
        [self.activityContent setAlpha:1.0f];
        [self.activityContent setTitle:product.promotionInfo forState:UIControlStateNormal];
    }else{
        [self.activityContent setAlpha:0.0f];
    }
    if (product.goodsExplain) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:product.goodsExplain];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [product.goodsExplain length])];
        self.descriptionLbl.attributedText = attributedString;
    }
    self.descriptionLbl.lineBreakMode = NSLineBreakByTruncatingTail;

    NSString *price = [NSString stringWithFormat:@"￥%0.2f",product.unCrossedPrice/100.0];
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:price];
    [priceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 1)];
    self.salePriceLbl.attributedText = priceStr;
    
    //划线价格显示
    if (product.crossedPrice) {
        NSString *crosePrice = [NSString stringWithFormat:@"￥%0.2f",product.crossedPrice/100.0];
        NSMutableAttributedString * attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",crosePrice]];
        [attrStr1 addAttribute:NSFontAttributeName value:APP_FONT(14.0) range:NSMakeRange(0, crosePrice.length)];
        [attrStr1 addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_WEAK_GRAYLIGHT range:NSMakeRange(0, crosePrice.length)];
        [attrStr1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, crosePrice.length)];
        [attrStr1 addAttribute:NSStrikethroughColorAttributeName value:UICOLOR_FONT_WEAK_GRAYLIGHT range:NSMakeRange(0, crosePrice.length)];
        self.crossPriceLabel.attributedText = attrStr1;
        self.crossPriceLabel.hidden = NO;
    }else {
        self.crossPriceLabel.hidden = YES;
    }

    self.countryLbl.text = product.produceCountry;
    [self.countryFlag sd_setImageWithURL:[NSURL URLWithString:product.countryFlag] placeholderImage:nil];
    if (product.commentCount < 1000) {
        self.commentsCount.text = [NSString stringWithFormat:@"%ld",(long)product.commentCount];
    }else {
        self.commentsCount.text = @"999+";
    }
    
    if (product.praiseCount < 1000) {
        self.praiseCount.text = [NSString stringWithFormat:@"%ld",(long)product.praiseCount];
    }else {
        self.praiseCount.text = @"999+";
    }
    
    //购物车（立即购买图标）
    if (product.goodsStatus == 0) {
        if (product.productType == 0) {
            self.addCartImageView.image = [UIImage imageNamed:@"加入购物车.png"];
        }else {
            self.addCartImageView.image = [UIImage imageNamed:@"PayMoney.png"];
        }
        self.addCartButton.tag = 0;
    }else {
    
        if (product.productType == 0) {
            self.addCartImageView.image = [UIImage imageNamed:@"ShoppingCartIconOff.png"];
        }else {
            self.addCartImageView.image = [UIImage imageNamed:@"payMoneyOff.png"];
        }
        self.addCartButton.tag = 1;
    }
}

+ (CGFloat)cellHeight {

    return 153;
}
@end
