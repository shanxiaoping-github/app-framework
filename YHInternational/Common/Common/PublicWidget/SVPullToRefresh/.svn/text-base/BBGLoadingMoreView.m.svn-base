//
//  BBGLoadingMoreView.m
//  Common
//
//  Created by Damon on 15/7/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLoadingMoreView.h"
#import "Common.h"
#import "BlocksKit.h"
@interface BBGLoadingMoreView ()

@end

@implementation BBGLoadingMoreView

- (id)initAnimationViewWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 90, 10, 119, 42)];
        
        
//        [_animationImageView setImage:[UIImage imageNamed:@"1@3x"]];
        
        
        /**
         *  摇摆动画
         */
        NSMutableArray * swingArray = [NSMutableArray array];
        for (int i = 0; i < 8; i ++) {
            [swingArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d@3x",(i + 1)]]];
        }
        
        [_animationImageView setHighlightedAnimationImages:swingArray];
        
        
        /**
         *  飞行动画
         */
        NSMutableArray * flyingArray = [NSMutableArray array];
        
        for (int i = 8; i < 20; i++) {
            [flyingArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d@3x",(i + 1)]]];
        }
        [_animationImageView setAnimationImages:flyingArray];
        [_animationImageView setAnimationRepeatCount:1];
        [_animationImageView setAnimationDuration:0.7];
        
        
        [self addSubview:_animationImageView];
        
    }
    return self;
}

- (void)startSwingAnimating{
    [_animationImageView setAnimationRepeatCount:200000];
    [_animationImageView setAnimationDuration:0.7];
    _animationImageView.highlighted = YES;
    [_animationImageView startAnimating];
    
}

- (void)startFlyingAnimatingWithCompletion:(FlyingAction)block{
    [_animationImageView stopAnimating];
    _animationImageView.highlighted = NO;
    [_animationImageView setAnimationRepeatCount:1];
    [_animationImageView setAnimationDuration:0.7];
//    [self.animationImageView.layer removeAllAnimations];
    [self.animationImageView startAnimating];
    [NSTimer bk_scheduledTimerWithTimeInterval:0.7 block:^(NSTimer *timer) {
        if (block) {
            block();
        }
    } repeats:NO];
}

- (void)stopAnimating{
    [self.animationImageView stopAnimating];
}

@end
