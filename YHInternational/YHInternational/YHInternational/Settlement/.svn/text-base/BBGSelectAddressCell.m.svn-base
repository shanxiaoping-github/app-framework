//
//  BBGSelectAddressViewControllerCell.m
//  YHInternational
//
//  Created by apple on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSelectAddressCell.h"

@implementation BBGSelectAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadCell:(BBGAddress *)address{
    
    
    self.userAddress = address;
    
    NSString *area;
    if (address) {
        NSArray *areaArray = [address.areaInfo componentsSeparatedByString:@":"];
        NSString *areaString = [areaArray ARRAY_OBJ_AT(0)];
        area = [areaString stringByReplacingOccurrencesOfString:@"_" withString:@""];
    }
    self.addressLab.text = [NSString stringWithFormat:@"%@%@",area,address.addr];
    self.nameLab.text    = address.name;
    self.phoneNumLab.text = address.mobile;
    
    if (address.selected) {
        [self.selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }else{
        [self.selectBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    }

}

- (IBAction)editingAddressCell:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setEditingAddress:)]) {
        [self.delegate setEditingAddress:self.userAddress];
    }
}

- (IBAction)selecteBtnClick:(UIButton *)sender {
    

    if (self.delegate && [self.delegate respondsToSelector:@selector(setSeletedAddress:)]) {
        [self.delegate setSeletedAddress:self.userAddress];
    }
}

@end
