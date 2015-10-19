//
//  DeviceUtil.h
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/8/16.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//
/*设备工具类*/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DeviceUtil : NSObject
/*获得当前的设备类型*/
+(NSString*)getCurrentDeviceModel:(UIViewController*)controller;
/*获取当前设备版本号*/
+(CGFloat)getCurrentDeviceSystemVersion;
@end
