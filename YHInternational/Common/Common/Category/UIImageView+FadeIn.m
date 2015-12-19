//
//  UIImageView+FadeIn.m
//  Common
//
//  Created by 黄 灿 on 15/9/29.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "UIImageView+FadeIn.h"
@implementation UIImageView (FadeIn)
-(void)setFadeInTime:(float)fadeTime{
    self.alpha = 0.0;
    [UIView transitionWithView:self
                      duration:fadeTime
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self setImage:self.image];
                        self.alpha = 1.0;
                    } completion:NULL];
    
}
- (void)setFadeInWithDefaultTime{
    self.alpha = 0.0;
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self setImage:self.image];
                        self.alpha = 1.0;
                    } completion:NULL];
    
}
@end
//        CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
//        contentsAnimation.fromValue = (__bridge id _Nullable)(image1.CGImage);
//        contentsAnimation.toValue   = (__bridge id _Nullable)(image.CGImage);
//        contentsAnimation.duration  = 0.5f;
//        [backImageView.layer addAnimation:contentsAnimation forKey:nil];



/**
 *
 *  关于两张图片动画形式的淡入淡出  极客学院
 *  http://v.qq.com/cover/j/jp8vqwxggybf2gl.html?vid=d1400nk9ync
 *
 */