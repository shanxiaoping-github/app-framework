//
//  BBGRegionManager.h
//  Common
//
//  Created by Damon on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "BBGLaunchTask.h"
@interface BBGRegionManager : NSObject<BBGLaunchTask>

+(BBGRegionManager *)sharedInstance;

- (void)startLocation;

- (void)endLocation;

@property (nonatomic, assign) BOOL regionTask;

@property (nonatomic, strong) NSArray * regionList;

//定位是否成功
@property (nonatomic, assign) BOOL locationSuccess;
/// 街道名称
@property (nonatomic, strong) NSString* streetName;
/// 区县名称
@property (nonatomic, strong) NSString* district;
/// 城市名称
@property (nonatomic, strong) NSString* city;
/// 省份名称
@property (nonatomic, strong) NSString* province;

@end
