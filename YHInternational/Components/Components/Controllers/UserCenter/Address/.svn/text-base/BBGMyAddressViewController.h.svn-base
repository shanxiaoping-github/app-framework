//
//  BBGMyAddressViewController.h
//  Components
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGMyAddressViewController : BBGViewController

@property (nonatomic, strong) BBGAddressListRequest *addressListRequest;

@property (nonatomic, strong) BBGDeleteAddressRequest *deleteAddressRequest;

@property (nonatomic, strong) BBGSetDefaultAddressRequest *setDefaultAddressReqeust;

@property (nonatomic, strong) NSMutableArray *addressList;

@property (nonatomic, assign) BOOL isNeedSort;



/**
 *  收货地址
 *
 *  @param callback <#callback description#>
 */
- (void)deleteAddress:(LoadDataCallback)callback;


/**
 *  设置默认收货地址
 *
 *  @param callback <#callback description#>
 */
- (void)setDefaultAddressRequest:(LoadDataCallback)callback;

@end
