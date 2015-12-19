//
//  BBGSettlementFooterCell_iPhone.h
//  YHInternational
//
//  Created by Timmy OuYang on 15/6/4.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettlementSectionFooterCellDelegate;

@interface BBGSettlementFooterCell_iPhone : UITableViewCell

@property (nonatomic, strong) NSArray *promotions;
@property (assign, nonatomic) NSInteger index;
@property (nonatomic, strong) BBGCoupon *userCoupon;
@property (nonatomic, strong) BBGSettlement *settlement;
@property (nonatomic, weak) id<SettlementSectionFooterCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *promotionNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *freightLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

- (void)updateFooterViewWith:(NSInteger)section;

@end


@protocol SettlementSectionFooterCellDelegate <NSObject>

- (void)settlementSectionFooterCell:(BBGSettlementFooterCell_iPhone *)footerView didSelectedAtIndex:(NSInteger)index;

@end