//
//  BBGSelectAddressViewController_iPhone.h
//  YHInternational
//
//  Created by Timmy OuYang on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSelectAddressViewController.h"

typedef void (^SettlementCallback) (BOOL sucessful, BBGSettlement *settlement);

@interface BBGSelectAddressViewController_iPhone : BBGSelectAddressViewController

@property (nonatomic, assign) BOOL mustNeedIdCardPhoto;

- (id)initWithSettlementCallBack:(SettlementCallback)callBack;
- (void)selectAddressWithAddressId:(NSString *)addressId;

@end
