//
//  BBGSettlementSectionFooterView_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/5/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlementSectionFooterView_iPhone.h"
#import "BBGSettlementPacket.h"

@implementation BBGSettlementSectionFooterView_iPhone

- (void)awakeFromNib {
    
}

- (void)setSettlement:(BBGSettlement *)settlement {

    if (_settlement != settlement) {
        _settlement = settlement;
    }
    
    self.totalFreightLbl.text = [NSString stringWithFormat:@"￥%0.2f",settlement.totalFreight/100.0];
    self.totalPmtLbl.text = [NSString stringWithFormat:@"-￥%0.2f",settlement.totalPmt/100.0];
    self.totalPrice.text = [NSString stringWithFormat:@"￥%0.2f",settlement.totalPrice/100.0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
