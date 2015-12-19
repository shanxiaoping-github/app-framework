//
//  BBGAddressView.h
//  BubuGao
//
//  Created by calvin on 14-5-15.
//  Copyright (c) 2014年 bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Common/Common.h>
typedef void (^actionBlock)();
typedef void (^AddressViewCallBack) (BOOL selected,NSString *p,NSString *c,NSString *d,NSString *s,NSString *pID,NSString *cID,NSString *dID,NSString *sID);

@interface BBGAddressView : UIControl

@property (nonatomic, assign) BOOL isEditAddress;

@property (nonatomic, copy) actionBlock block;

@property (nonatomic, assign) CGFloat height;
/**
 *  礼品中心使用
 */
@property (nonatomic, strong) NSArray *selfStoreList;
/**
 *  默认显示四级地址；  YES： 只显示三级地址； NO： 只显示三级地址
 */
@property (nonatomic, assign) BOOL isShowDistrict;
//- (id)initWithRegions:(BBGRegion *)region;
- (id)initWithRegions:(NSArray *)regionList;
- (void)show:(AddressViewCallBack)callback;

- (void)showWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district street:(NSString *)street callback:(AddressViewCallBack)callback;

@end
