//
//  BBGIndicatorView.m
//  BubuGao
//
//  Created by calvin on 14-4-11.
//  Copyright (c) 2014年 bubugao. All rights reserved.
//

#import "BBGIndicatorView.h"

@interface BBGIndicatorView ()

@property(nonatomic, strong) UIImageView *levelImageView;

@end

@implementation BBGIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCenterImage:(UIImage *)cImage levelImage:(UIImage *)lImage {
    CGFloat width = cImage.size.width > lImage.size.width ? cImage.size.width : lImage.size.width;
    CGFloat height = cImage.size.height > lImage.size.height ? cImage.size.height : lImage.size.height;
    self = [super initWithFrame:CGRectMake(0, 0, width, height)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *centerImageView = [[UIImageView alloc] initWithImage:cImage];
        centerImageView.center = self.center;
        [self addSubview:centerImageView];
        
        _levelImageView = [[UIImageView alloc] initWithImage:lImage];
        _levelImageView.center = self.center;
        [self addSubview:_levelImageView];
        _hidesWhenStopped = YES;
        self.hidden = YES;
    }
    return self;
}


- (void)startAnimating {
    self.hidden = NO;
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.duration = 1.0f;
    animation.repeatCount = HUGE_VAL;
    [_levelImageView.layer addAnimation:animation forKey:@"MyAnimation"];
}

- (void)stopAnimating {
    [_levelImageView.layer removeAllAnimations];
    self.hidden = _hidesWhenStopped;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
