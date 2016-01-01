//
//  appliacation_ attribute.h
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/7/16.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

#ifndef sxp_ios_framework_appliacation__attribute_h
#define sxp_ios_framework_appliacation__attribute_h
//取得屏幕的宽
#define screenWidth [UIScreen mainScreen].bounds.size.width
//取得屏幕高
#define screenHeight [UIScreen mainScreen].bounds.size.height
/*!
 @author shanxiaoping
 
 @brief 取得storyboard根控制器
 
 @param storyName storyName
 
 @return 控制器
 */
#define storyboard_controller(storyName) \
[[UIStoryboard storyboardWithName:storyName bundle:nil] instantiateInitialViewController]
/*!
 @author shanxiaoping
 
 @brief 获取UIStory中的控制器
 
 @param storyName          UIStory的name
 @param controllerIdentity 控制器标识
 
 @return 返回控制器
 */
#define storyboard_controller_identity(storyName,controllerIdentity) \
[[UIStoryboard storyboardWithName:storyName bundle:nil] instantiateViewControllerWithIdentifier:controllerIdentity]

/*!
 @author shanxiaoping
 
 @brief 获取类单例
 
 @param className 类的名称
 
 @return 类实例
 */
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
    static className *shared##className = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        shared##className = [[self alloc] init]; \
    }); \
    return shared##className; \
}
/*状态栏正常高度*/
#define statusBarNomalHeight 20.f
/*状态栏放大高度，一般是通知来临的高度放大*/
#define statusBarScaleBigHeight 40.f
/*屏幕水平高度*/
#define navigationBarHorizontalHeight 44.f
/*屏幕垂直高度*/
#define navigationBarVerticalHeight 32.f
#endif
