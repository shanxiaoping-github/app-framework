//
//  BBGAddressListCell_iPhone.h
//  YHInternational
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Common.h"

#import "BBGTableView.h"
#import "BBGAddress.h"
typedef NS_ENUM(NSInteger, BBGAddressListViewType) {
    DeleteAddressType = 1, // 删除
    EditAddressType,       // 编辑
    SetDefaultAddressType  // 设为默认
};

@protocol BBGAddressListCelDelegate <NSObject>
- (void)setDefaultAddress:(BBGAddress *)address;
- (void)didChangeAddressCellWithType:(BBGAddressListViewType)type address:(BBGAddress *)address;
@end

@interface BBGAddressListCell_iPhone : BBGTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *editView;
@property (strong, nonatomic) IBOutlet UIView *deleteView;
@property (strong, nonatomic) IBOutlet UIView *setDefault;
@property (strong, nonatomic) IBOutlet UILabel *defaultLabel;
@property (strong, nonatomic) IBOutlet UIImageView *setDefaultImage;
@property (weak, nonatomic) id<BBGAddressListCelDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *selectionImg;
@property (weak, nonatomic) IBOutlet UILabel *selectionLbl;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;

@property (strong ,nonatomic) BBGAddress *userAddress;
- (void)updateCellData:(BBGAddress *)userAddress;
@end
