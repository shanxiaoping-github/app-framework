//
//  CouponCell.h
//  YHInternational
//
//  Created by Damon on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGCoupon.h"
@interface CouponCell : UITableViewCell

- (void)setStatus:(BOOL)status;

- (void)updateCell:(BBGCoupon *)coupon;

@end
