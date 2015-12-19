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
//取得storyboard根控制器
#define storyboard_controller(storyName) \
[[UIStoryboard storyboardWithName:storyName bundle:nil] instantiateInitialViewController]
//取得storyboard指定控制器
#define storyboard_controller_identity(storyName,controllerIdentity) \
[[UIStoryboard storyboardWithName:storyName bundle:nil] instantiateViewControllerWithIdentifier:controllerIdentity]
#endif
