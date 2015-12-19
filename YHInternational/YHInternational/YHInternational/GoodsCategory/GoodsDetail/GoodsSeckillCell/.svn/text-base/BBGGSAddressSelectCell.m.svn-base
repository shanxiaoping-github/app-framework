//
//  BBGGSAddressSelectCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSAddressSelectCell.h"

@interface BBGGSAddressSelectCell ()

@property (strong ,nonatomic) BBGAddress *userAddress;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumLab;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UIButton *defaultBtn;

@end

@implementation BBGGSAddressSelectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCell:(BBGAddress *)address selected:(BBGAddress *)selectAddr {
    
    self.userAddress = address;
    
    NSString *area;
    if (address) {
        NSArray *areaArray = [address.areaInfo componentsSeparatedByString:@":"];
        NSString *areaString = [areaArray ARRAY_OBJ_AT(0)];
        area = [areaString stringByReplacingOccurrencesOfString:@"_" withString:@""];
    }
    self.addressLab.text = [NSString stringWithFormat:@"%@%@",area,address.addr];
    self.nameLab.text = address.name;
    self.phoneNumLab.text = address.mobile;
    
    if ([address.addrId isEqualToString:selectAddr.addrId]) {
        [self.selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }else{
        [self.selectBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    }
    
    if (address.defAddr == YES) {
        [self.defaultBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }else {
        [self.defaultBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    }
}

- (IBAction)setDefault:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(setEditingAddress:)]) {
        [self.delegate setDefaultAddress:self.userAddress];
    }
}

- (IBAction)edit:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(setEditingAddress:)]) {
        [self.delegate setEditingAddress:self.userAddress];
    }
}

- (IBAction)selected:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(setSeletedAddress:)]) {
        [self.delegate setSeletedAddress:self.userAddress];
    }
}

@end
