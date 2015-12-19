//
//  BBGLoadingView.m
//  Components
//
//  Created by calvin on 14-5-5.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGLoadingView.h"
#import "Common.h"

@interface BBGLoadingView ()

@property (nonatomic, strong) BBGIndicatorView *indicator;

@end

@implementation BBGLoadingView

DECLARE_SINGLETON(BBGLoadingView)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _indicator = [[BBGIndicatorView alloc] initWithCenterImage:[UIImage imageNamed:@"Image"] levelImage:[UIImage imageNamed:@"Image"]];
        [self addSubview:_indicator];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _indicator.center = self.center;
}

- (void)show {
    [self showOnView:[[UIApplication sharedApplication] keyWindow]];
}

- (void)showOnView:(UIView *)view {
    self.frame = view.bounds;
    [_indicator startAnimating];
    [view addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
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
