//
//  BBGRefreshView.m
//  SVTest
//
//  Created by Damon on 15/4/28.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRefreshView.h"
#import "SVPullToRefresh.h"
#import "Common.h"
@interface BBGRefreshView()
@property (nonatomic, strong) UIImageView * backgroundRefreshView;
@property (nonatomic,strong) NSString *bkToken;
@end

@implementation BBGRefreshView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        _plantView = [[UIImageView alloc] initWithImage:THEME_IMAGE(@"plant")];
        _plantView.frame = CGRectMake(0, 0, 200, 200);
        [self addSubview:_plantView];
        
        _planeView = [[UIImageView alloc] initWithImage:THEME_IMAGE(@"plane")];
        _planeView.frame = CGRectMake(0, 0, 200, 200);
        [self addSubview:_planeView];
        
        _flagView = [[UIImageView alloc] initWithImage:THEME_IMAGE(@"refresh_flag")];
        _flagView.frame = CGRectMake((self.bounds.size.width - 80)/2, 44, 80, 33);
        [self addSubview:_flagView];
        
        if (!_backgroundRefreshView) {
            _backgroundRefreshView = [[UIImageView alloc]initWithImage:THEME_IMAGE(@"star")];
            _backgroundRefreshView.frame = CGRectMake(0, 0, 200, 200);
            [self addSubview:_backgroundRefreshView];
        }
        WS(ws)
        _bkToken = [[BBGConfiguration sharedInstance] bk_addObserverForKeyPath:@"theme" task:^(id target) {
            [ws.plantView setImage:THEME_IMAGE(@"plant")];
            [ws.planeView setImage:THEME_IMAGE(@"plane")];
            [ws.flagView setImage:THEME_IMAGE(@"refresh_flag")];
            if (ws.backgroundRefreshView) {
                [ws.backgroundRefreshView setImage:THEME_IMAGE(@"star")];
            }
        }];
    }
    return self;
}

- (void)spinWithGesture:(CGFloat)panY{
    
    if (!self.isLoading) {
        __weak BBGRefreshView * weakSelf = self;
        [UIView animateWithDuration:0.01 animations:^{
            weakSelf.planeView.transform = CGAffineTransformRotate(weakSelf.transform, panY/ 180 * M_PI_4) ;
            weakSelf.plantView.transform = CGAffineTransformRotate(weakSelf.transform, -panY/ 180 * M_PI_4);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void) spinWithOptions: (UIViewAnimationOptions) options {
    // this spin completes 360 degrees every 2 seconds
    
    __weak BBGRefreshView * weakSelf = self;
    [UIView animateWithDuration: 1.5f
                          delay: 0.0f
                        options: options
                     animations: ^{
                         weakSelf.plantView.transform = CGAffineTransformRotate(weakSelf.plantView.transform, M_PI / 2);
                         weakSelf.planeView.transform = CGAffineTransformRotate(weakSelf.planeView.transform, -M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (_animating) {
                                 // if flag still set, keep spinning with constant speed
                                 [weakSelf spinWithOptions: UIViewAnimationOptionCurveLinear];
                             } else if (options != UIViewAnimationOptionCurveEaseOut) {
                                 // one last spin, with deceleration
                                 [weakSelf spinWithOptions: UIViewAnimationOptionCurveEaseOut];
                             }
                         }
                     }];
}

- (void)touchspin:(CGFloat)touchFloat State:(SVPullToRefreshState)state{
    if (state == SVPullToRefreshStateTriggered) {
        
    }
}

- (void)startSpin {
    if (!_animating) {
        _animating = YES;
        [self spinWithOptions: UIViewAnimationOptionCurveEaseIn];
    }
}

- (void) stopSpin {
    // set the flag to stop spinning after one last 90 degree increment
    _animating = NO;
}

- (void)dealloc{
    if (_bkToken) {
        [[BBGConfiguration sharedInstance] bk_removeObserverForKeyPath:@"theme" identifier:_bkToken];
    }
}

@end
