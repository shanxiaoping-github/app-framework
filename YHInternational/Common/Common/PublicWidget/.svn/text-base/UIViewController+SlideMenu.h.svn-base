//
//  UIViewController+SlideMenu.h
//  Common
//
//  Created by Timmy Ouyang on 15/4/25.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, TMSlideType) {
    //左侧菜单
    TMSlideTypeLeft,
    //右侧菜单
    TMSlideTypeRight
};

typedef NS_ENUM(NSInteger, TMAnimationOptions) {
    TMAnimation,
};

#define leftMargin 60

@interface UIViewController (SlideMenu)

@property (strong, nonatomic) UIViewController *menuViewController;

@property (nonatomic, strong) NSNumber *enableSwipeGesture;

@property (nonatomic, strong) NSNumber *duration;

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

/**
 *  侧滑功能
 *
 *  @param menuViewController 菜单Controller
 *  @param duration           动画时长
 *  @param slideType          滑动方向
 *  @param completion         动画完成回调
 */
- (void)slideMenuViewController:(UIViewController *)menuViewController
              animationDuration:(NSTimeInterval)duration
                      slideTyep:(TMSlideType)slideType
                     completion:(void (^)(BOOL finished))completion;
@end
