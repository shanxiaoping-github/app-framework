//
//  BBGGoodsPushAnimator.m
//  Components
//
//  Created by Damon on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsPushAnimator.h"
#import "BBGGoodsListViewController.h"
#import "BBGGoodsDetailViewController.h"
#import "BBGJumpManager.h"
@implementation BBGGoodsPushAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                   fromVC:(UIViewController *)fromVC
                     toVC:(UIViewController *)toVC
                 fromView:(UIView *)fromView
                   toView:(UIView *)toView{
    UIView *containerView = [transitionContext containerView];
    self.duration = 0.3;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    /*!
     *  商品详情image
     */
    BBGGoodsListViewController * goodsListViewController = (BBGGoodsListViewController *)fromVC;
    UIView *cellImageSnapshot = [goodsListViewController.currentImageView snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:goodsListViewController.currentImageView.frame fromView:goodsListViewController.currentImageView.superview];
    goodsListViewController.currentImageView.hidden = YES;

    BBGGoodsDetailViewController * goodsDetailViewController = nil;
    if ([toVC isKindOfClass:[BBGGoodsDetailViewController class]]) {
        goodsDetailViewController =
        (BBGGoodsDetailViewController *)toVC;
    }
    
    goodsDetailViewController.view.frame = [transitionContext finalFrameForViewController:goodsDetailViewController];
    goodsDetailViewController.view.alpha = 0;
    goodsDetailViewController.pictureView.hidden = YES;

    [containerView addSubview:goodsDetailViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    [BBGJumpManager sharedInstance].animationView = cellImageSnapshot;
    
    [UIView animateWithDuration:duration animations:^{
        goodsDetailViewController.view.alpha = 1.0;
        CGRect frame = [containerView convertRect:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH) fromView:goodsDetailViewController.view];
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        // Clean up
        goodsDetailViewController.pictureView.hidden = NO;
        goodsListViewController.currentImageView.hidden = NO;
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

    
}

@end
