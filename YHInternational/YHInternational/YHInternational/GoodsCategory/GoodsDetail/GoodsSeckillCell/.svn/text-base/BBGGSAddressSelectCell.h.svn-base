//
//  BBGGSAddressSelectCell.h
//  YHInternational
//
//  Created by 彭腾 on 15/10/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGAddress.h"

@protocol BBGGSAddressSelectCellDelegate<NSObject>
- (void)setSeletedAddress:(BBGAddress *)address;
- (void)setEditingAddress:(BBGAddress *)address;
- (void)setDefaultAddress:(BBGAddress *)address;
@end

@interface BBGGSAddressSelectCell : UITableViewCell

- (void)updateCell:(BBGAddress *)address selected:(BBGAddress *)selectAddr;

@property (nonatomic, assign) id<BBGGSAddressSelectCellDelegate> delegate;

@end
