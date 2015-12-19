//
//  BBGSettlementAddressCell_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/5/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlementAddressCell_iPhone.h"

@implementation BBGSettlementAddressCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    _address = [[BBGAddress alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)updateCellWith:(BBGAddress *)address type:(NSInteger)type {

    NSString *area;
    if (address) {
        NSArray *areaArray = [address.areaInfo componentsSeparatedByString:@":"];
        NSString *areaString = [areaArray ARRAY_OBJ_AT(0)];
        area = [areaString stringByReplacingOccurrencesOfString:@"_" withString:@""];
    }
    self.addressLbl.text = [NSString stringWithFormat:@"%@%@",area,address.addr];
    self.nameTelLbl.text = [NSString stringWithFormat:@"%@",address.name];
    self.telLbl.text     = [NSString stringWithFormat:@"%@",address.mobile];

}

+ (float)cellHeightWithCellType:(NSInteger)cellType {

    switch (cellType) {
        case 0:
//            return 60;
            return 80;
            break;
        case 1:
//            return 82;
            return 100;
            break;
            
        default:
            break;
    }
    return 0;
}

@end
