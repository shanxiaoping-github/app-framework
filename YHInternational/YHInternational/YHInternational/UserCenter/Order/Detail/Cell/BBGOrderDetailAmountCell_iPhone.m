//
//  BBGOrderDetailAmountCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailAmountCell_iPhone.h"
@interface BBGOrderDetailAmountCell_iPhone()
@property (strong, nonatomic) IBOutlet UILabel *productAmountLbl;
@property (strong, nonatomic) IBOutlet UILabel *freightAmountLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderActiveAmountLbl;
@property (strong, nonatomic) IBOutlet UILabel *payActiveAmountLbl;
@property (strong, nonatomic) IBOutlet UILabel *totalAmount;
@end
@implementation BBGOrderDetailAmountCell_iPhone

- (void)awakeFromNib {
    // Initialization code
}


-(void)updateAmountDataWithOrderInfo:(BBGOrderInfo *)orderInfo{
    
    self.productAmountLbl.text = [NSString stringWithFormat:@"￥%.2f",orderInfo.totalProductAmount/100];
    self.freightAmountLbl.text = [NSString stringWithFormat:@"￥%.2f",orderInfo.expressFee/100];
    self.orderActiveAmountLbl.text = [NSString stringWithFormat:@"-￥%.2f",orderInfo.orderPromotionAmount/100];
    self.payActiveAmountLbl.text = [NSString stringWithFormat:@"-￥%.2f",orderInfo.totalDeductAmount/100];
    self.totalAmount.text = [NSString stringWithFormat:@"￥%.2f",orderInfo.totalRealPrice/100];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
