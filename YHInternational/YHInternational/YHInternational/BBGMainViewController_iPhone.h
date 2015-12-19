//
//  BBGMainViewController_iPhone.h
//  YHInternational
//
//  Created by Damon on 15/4/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "BBGComponents.h"

@interface BBGMainViewController_iPhone : UITabBarController

/**
 *  查找当前的controller所在index
 *
 *  @param viewController 用来查找的controller
 *
 *  @return 如果查找到则返回对应的index，如果没查找到则返回-1
 */
- (NSInteger)indexForViewController:(UIViewController *)viewController;

@end
