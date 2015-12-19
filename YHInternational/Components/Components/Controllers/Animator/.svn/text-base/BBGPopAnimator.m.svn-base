//
//  BBGPopAnimator.m
//  Components
//
//  Created by Damon on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPopAnimator.h"

@implementation BBGPopAnimator

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView{
    
    [[transitionContext containerView] insertSubview:toVC.view belowSubview:fromVC.view];
    [toVC.view setFrame:CGRectMake(0, 64, IPHONE_WIDTH, IPHONE_HEIGHT - 64)];
    [UIView animateWithDuration:self.duration animations:^{
        [fromVC.view setFrame:CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH, IPHONE_HEIGHT)];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
