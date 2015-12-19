//
//  UIView+Animations.m
//  Common
//
//  Created by Timmy Ouyang on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "UIView+Animations.h"
#import "sys/sysctl.h"

@implementation UIView (Animations)

- (void)animationOf3DWithDuration:(NSTimeInterval)duration {

    CATransform3D rotation;
    rotation = CATransform3DMakeRotation(M_PI/4, 1, 0, 0);
    rotation.m34 = 1.0/ -600;
    self.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.layer.transform = rotation;
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.layer.transform = CATransform3DIdentity;
}

- (void)animationOfScaleWithDuration:(NSTimeInterval)duration {
        
    CGAffineTransform transformScale = CGAffineTransformMakeScale(1.1, 1.1);
    self.transform = transformScale;
    self.alpha = 0;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animationOfAlphaEaseInWithDuration:(NSTimeInterval)duration {

    self.alpha = 0;
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    self.alpha = 1;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

@end
