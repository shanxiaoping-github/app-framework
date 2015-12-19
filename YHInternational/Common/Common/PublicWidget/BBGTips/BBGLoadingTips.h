//
//  BBGLoadingTips.h
//  Common
//
//  Created by Damon on 15/5/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface BBGLoadingTips : NSObject

+ (BBGLoadingTips *)sharedInstance;

-(void)showLoading:(NSString *)str;

-(void)showTips:(NSString *)str;

-(void)hideTips;

/*!
 *  显示loading
 *
 *  @param view 显示页面
 */
- (void)showLoadingOnView:(UIView *)view;

/*!
 *  显示loading
 *
 *  @param view    显示页面
 *  @param seconds seconds后消失,单位为秒
 */
- (void)showLoadingOnView:(UIView *)view hideAfterTimeval:(NSTimeInterval)seconds;

/*
 customImgView 网络加载时的自定义图片（旋转的图片）
 string        网络加载时的文字
 bgView        网络加载所在的区域视图
 tseconds      网络加载后隐藏的时间（秒）
 */
-(void)showLoadingCustomView:(UIImageView *)customImgView   withText:(NSString *)string  inBackgroundView:(UIView *)bgView withTime:(NSTimeInterval)tseconds;

@end
