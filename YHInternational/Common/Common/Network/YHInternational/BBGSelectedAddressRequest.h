//
//  BBGSelectedAddressRequest.h
//  Common
//
//  Created by Timmy OuYang on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"
#import "BBGSettlementRequest.h"

@interface BBGSelectedAddressRequest : BBGRequest

@property (nonatomic, strong) NSString *addrId;
@property (nonatomic, assign) BBGBuyType buyType;

@end
