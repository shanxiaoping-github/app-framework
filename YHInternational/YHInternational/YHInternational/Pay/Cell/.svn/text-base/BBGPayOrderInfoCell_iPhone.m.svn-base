//
//  BBGPayOrderInfoCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayOrderInfoCell_iPhone.h"

@interface BBGPayOrderInfoCell_iPhone ()
@property (strong, nonatomic) IBOutlet UILabel *orderNoLbl;
@property (strong, nonatomic) IBOutlet UILabel *createTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *productNumLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderAmountLbl;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UIButton *payBtn;
@property (strong, nonatomic) IBOutlet UILabel *statusLbl;
@property (strong, nonatomic) BBGPayOrderInfo *orderInfo;
@end

@implementation BBGPayOrderInfoCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    [self.payBtn setBackgroundImage:[[UIImage imageNamed:@"红按钮"] stretchImage] forState:UIControlStateNormal];
}


-(void)updateOrderInfoCellWith:(BBGPayOrderInfo *)orderInfo{
    self.orderInfo = orderInfo;
    self.orderNoLbl.text = [NSString stringWithFormat:@"订单号：%@",orderInfo.tradeNo];
    self.createTimeLbl.text =  [self stringFromDate:orderInfo.createTime];
    self.productNumLbl.text = [NSString stringWithFormat:@"商品数：%ld",(long)orderInfo.productNum];
    self.orderAmountLbl.text = [NSString stringWithFormat:@"金额：￥%.2f",orderInfo.paymentTotal];
    if (orderInfo.isPaySuccess) {
        self.statusLbl.hidden = NO;
        self.payBtn.hidden = YES;
    }else{
        self.statusLbl.hidden = YES;
        self.payBtn.hidden = NO;
    }
}

- (IBAction)payOrderAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoPayWithOrderInfo:)]) {
        [self.delegate gotoPayWithOrderInfo:self.orderInfo];
    }
    
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
