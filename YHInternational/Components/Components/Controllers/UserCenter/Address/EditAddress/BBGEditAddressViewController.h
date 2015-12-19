//
//  BBGEditAddressViewController.h
//  Components
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGAddress.h"

@interface BBGEditAddressViewController : BBGViewController

/**
 *  原地址对象
 */
@property(nonatomic, strong) BBGAddress *editAddress;

/**
 *  修改后的地址对象
 */
@property(nonatomic, strong) BBGAddress *editedAddress;


@end
