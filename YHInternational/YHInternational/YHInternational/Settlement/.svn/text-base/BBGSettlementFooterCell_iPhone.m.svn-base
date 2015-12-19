//
//  BBGSettlementFooterCell_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/6/4.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlementFooterCell_iPhone.h"

@implementation BBGSettlementFooterCell_iPhone

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateFooterViewWith:(NSInteger)section {
    
    self.index = section;
    BBGSettlementPacket *settlementPacket = [self.settlement.groups ARRAY_OBJ_AT(section-1)];
    
    self.freightLbl.text = [NSString stringWithFormat:@"运费：￥%0.2f",settlementPacket.totalFreight/100.0];
    self.priceLbl.text = [NSString stringWithFormat:@"合计：￥%0.2f",settlementPacket.totalRealPrice/100.0];
    
    //优惠券
    self.promotionNameLbl.text = settlementPacket.userCoupon.couponName;
    
    //促销信息
    if (settlementPacket.promotions.count > 0) {
        for (int i=0;i<settlementPacket.promotions.count;i++) {
            BBGProductCartPromotion *promotion = [settlementPacket.promotions ARRAY_OBJ_AT(i)];
            UILabel *contentLbl = [UILabel new];
            NSString *ad = promotion.toolName?promotion.toolName:@"暂无优惠";
            contentLbl.text = ad;
            [contentLbl setFont:APP_FONT(13)];
            [contentLbl setTextColor:UICOLOR_FONT_GENERAL_GRAY];
            [self addSubview:contentLbl];
            
            UILabel *amountLbl = [UILabel new];
            amountLbl.text = [NSString stringWithFormat:@"-￥%0.2f",promotion.discount/100.0];
            [amountLbl setFont:APP_FONT(13)];
            amountLbl.textAlignment = NSTextAlignmentRight;
            [amountLbl setTextColor:UICOLOR_FONT_GENERAL_GRAY];
            [self addSubview:amountLbl];
            
            //促销金额大于零才显示金额
            if (promotion.discount>0) {
                amountLbl.hidden = NO;
            }else {
                amountLbl.hidden = YES;
            }

            CGFloat Y = 45+20*i;
            [contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(@8);
                make.top.mas_equalTo(Y);
                make.width.mas_equalTo(@200);
                make.height.mas_equalTo(@20);
            }];
            
            [amountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.mas_right).offset(-8);
                make.top.mas_equalTo(Y);
                make.width.mas_equalTo(@150);
                make.height.mas_equalTo(@20);
            }];
            
        }
    }
    
}

- (IBAction)buttonPressed:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(settlementSectionFooterCell:didSelectedAtIndex:)]) {
        [self.delegate settlementSectionFooterCell:self didSelectedAtIndex:self.index];
    }

}
@end
