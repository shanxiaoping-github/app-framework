//
//  BBGSelectAddressViewControllerCell.h
//  YHInternational
//
//  Created by apple on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGAddress.h"
@protocol BBGSelectAddressCellDelegate<NSObject>
- (void)setSeletedAddress:(BBGAddress *)address;
- (void)setEditingAddress:(BBGAddress *)address;

@end

@interface BBGSelectAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLab;
@property (weak, nonatomic) IBOutlet UIButton *editingBtn;
@property (strong ,nonatomic) BBGAddress *userAddress;

@property (nonatomic,weak) id<BBGSelectAddressCellDelegate> delegate;

- (void)reloadCell:(BBGAddress *)address;


@end
