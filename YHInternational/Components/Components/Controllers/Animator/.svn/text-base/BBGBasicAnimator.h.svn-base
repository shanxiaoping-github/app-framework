//
//  BBGBasicAnimator.h
//  Components
//
//  Created by Damon on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "BBGMacro.h"
@interface BBGBasicAnimator : NSObject<UIViewControllerAnimatedTransitioning>

/*!
 *  是否为pop
 */
@property (nonatomic, assign) BOOL isReverse;

/*!
 *  动画时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView;

@end
