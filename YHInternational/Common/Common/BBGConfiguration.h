//
//  BBGConfiguration.h
//  Common
//
//  Created by Damon on 15/4/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define THEME_IMAGE(imageName) [[BBGConfiguration sharedInstance] imageWithImageName:(imageName)]

@interface BBGConfiguration : NSObject
+ (BBGConfiguration *)sharedInstance;

@property (nonatomic,copy) NSString * areaVersion;


/**
 *  主题图片目录
 */
@property (strong, nonatomic) NSString *theme;

@property (copy, nonatomic) NSString *URL_DOOR;

/*!
 *  @author Damon, 15-04-23 17:04:56
 *
 *  时间戳
 */
@property (nonatomic,weak,readonly) NSString * timestamp;
@property (nonatomic,weak,readonly) NSString * eCode;
@property (nonatomic,weak,readonly) NSString * uCode;
/**
 *  服务器时间
 */
@property (nonatomic,strong)NSDate *serverTime;

- (void)getTimeDifferenceWithServerTime:(NSString *)serverTime;

-(NSDate*) getCurrentServerTime;


- (UIImage *)imageWithImageName:(NSString *)imageName;
@end
