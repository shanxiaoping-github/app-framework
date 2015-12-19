//
//  BBGSettlementSectionFooterView_iPhone.h
//  YHInternational
//
//  Created by Timmy OuYang on 15/5/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGSettlement.h"
#import "BBGCoupon.h"

@protocol SettlementSectionFooterViewDelegate;
@interface BBGSettlementSectionFooterView_iPhone : UIView

@property (nonatomic, strong) NSArray *promotions;
@property (assign, nonatomic) NSInteger index;
@property (nonatomic, strong) BBGSettlement *settlement;
@property (nonatomic, weak) id<SettlementSectionFooterViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *totalFreightLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalPmtLbl;

@end

@protocol SettlementSectionFooterViewDelegate <NSObject>

- (void)settlementSectionFooterView:(BBGSettlementSectionFooterView_iPhone *)footerView didSelectedAtIndex:(NSInteger)index;

@end