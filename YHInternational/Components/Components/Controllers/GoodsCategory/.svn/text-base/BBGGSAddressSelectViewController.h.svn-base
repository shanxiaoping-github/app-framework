//
//  BBGGSAddressSelectViewController.h
//  Components
//
//  Created by 彭腾 on 15/10/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGGSAddressSelectViewController : BBGViewController
/**
 *  选中地址
 */
@property (nonatomic, strong) BBGAddress *selectedAddress;
/**
 *  地址数组
 */
@property (nonatomic, strong) NSMutableArray *addressArr;
/**
 *  身份证照片是否必须，用来从结算到身份证编辑页面判断
 */
@property (nonatomic, assign) BOOL mustNeedIdCardPhoto;
/**
 *  默认地址ID
 */
@property (nonatomic, copy) NSString *addrId;
/**
 *  设置默认地址
 *
 *  @param callback 回调
 */
- (void)setDefaultAddressRequest:(LoadDataCallback)callback;

@end
