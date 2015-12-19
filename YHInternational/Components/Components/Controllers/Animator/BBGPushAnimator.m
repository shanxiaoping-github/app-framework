//
//  BBGPushAnimator.m
//  Components
//
//  Created by Damon on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPushAnimator.h"

@implementation BBGPushAnimator


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView{
    UIView* containerView = [transitionContext containerView];
    
    toVC.view.frame = CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH, IPHONE_HEIGHT);
    
    [containerView addSubview:toVC.view];
    
    
    [UIView animateWithDuration:self.duration animations:^{
        toVC.view.frame = CGRectMake(0, 64, IPHONE_WIDTH, IPHONE_HEIGHT - 64);
    } completion:^(BOOL finished) {
        fromVC.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
