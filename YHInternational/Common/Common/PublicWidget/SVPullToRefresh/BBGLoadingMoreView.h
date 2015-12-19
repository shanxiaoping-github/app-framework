//
//  BBGLoadingMoreView.h
//  Common
//
//  Created by Damon on 15/7/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FlyingAction) ();


@interface BBGLoadingMoreView : UIView
@property (nonatomic, strong) UIImageView * animationImageView;

@property (nonatomic, copy) FlyingAction block;

- (id)initAnimationViewWithFrame:(CGRect)frame;

- (void)startSwingAnimating;
- (void)startFlyingAnimatingWithCompletion:(FlyingAction)block;
- (void)stopAnimating;
@end
