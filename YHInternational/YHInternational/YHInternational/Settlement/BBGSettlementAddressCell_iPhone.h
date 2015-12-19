//
//  BBGSettlementAddressCell_iPhone.h
//  YHInternational
//
//  Created by Timmy OuYang on 15/5/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGAddress.h"

@interface BBGSettlementAddressCell_iPhone : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameTelLbl;
@property (strong, nonatomic) IBOutlet UILabel *telLbl;


@property (weak, nonatomic) IBOutlet UILabel *submitTipLbl;
@property (weak, nonatomic) IBOutlet UIImageView *warningImageView;

@property (strong, nonatomic) BBGAddress *address;
/**
 *  更新UI
 *
 *  @param address 地址对象
 *  @param type    UI类型（0：有地址类型   1：无地址类型）
 */
- (void)updateCellWith:(BBGAddress *)address type:(NSInteger)type;

+ (float)cellHeightWithCellType:(NSInteger)cellType;

@end