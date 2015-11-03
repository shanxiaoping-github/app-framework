//
//  CustomerView.m
//  gigold
//
//  Created by 单小萍 on 15/10/26.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "CustomerView.h"
#import "appliacation_attribute.h"
@implementation CustomerView
@synthesize backGroundColor=_backGroundColor;
@synthesize pullStyle = _pullStyle;
@synthesize showView = _showView;
@synthesize clickDeleget = _clickDeleget;
@synthesize baseLineValue = _baseLineValue;
@synthesize animationTime = _animationTime;
-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0,0,screenWidth,screenHeight);
        self.layer.masksToBounds = YES;
        self.animationTime = 0.5f;
        self.baseLineValue = 0.f;
        self.pullStyle = PullViewDown;
        self.backGroundColor = default_background;
    }
    return self;
}

-(BOOL)isShow{
    if ([self superview]) {
        return YES;
    }
    return NO;
}

-(void)showDialog:(UIView *)view{
    [self showDialogByBaseLine:0 view:view];
}
-(void)showDialogByBaseLine:(CGFloat)baseLineValue view:(UIView *)view{
    self.baseLineValue = baseLineValue;
    if (![self superview]) {
        self.backgroundColor = _backGroundColor;
        if (_showView&&![_showView superview]) {
            [self addContentView];
        }
        [view addSubview:self];
    }
    [self startPullAnimation];
}
-(void)showDialogByViewBottom:(UIView *)view{
    self.pullStyle = PullViewTop;
    CGFloat baseLine = view.frame.size.height+view.frame.origin.y;
    [self showDialogByBaseLine:baseLine view:[view superview]];
}
-(void)showDialogByVIewTop:(UIView *)view{
    self.pullStyle = PullViewDown;
    CGFloat baseLine = view.frame.origin.y;
    [self showDialogByBaseLine:baseLine view:[view superview]];
}

-(void)stopDialog{
    [self startStopAnimation:^(BOOL finish) {
        [self removeFromSuperview];
        [_showView removeFromSuperview];
    }];
}
//添加内容
-(void)addContentView{
    [self initContentView];
    [self addSubview:_showView];
}
-(void)initContentView{
    switch (_pullStyle){
        case PullViewTop:{
            if (_baseLineValue!=0) {
                self.frame =
                CGRectMake(0,_baseLineValue,screenWidth,screenHeight-_baseLineValue);
            }else{
                self.frame =
                CGRectMake(0,0,screenWidth,screenHeight);
                
            }
            _showView.frame = CGRectMake(_showView.frame.origin.x,0 -_showView.frame.size.height, _showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        case PullViewDown:{
            if (_baseLineValue!=0) {
                self.frame =
                CGRectMake(0,0,screenWidth,_baseLineValue);
            }else{
                self.frame =
                CGRectMake(0,0,screenWidth,screenHeight);
                
            }
            _showView.frame = CGRectMake(_showView.frame.origin.x,self.frame.size.height,_showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        case PullViewCenter:
            _showView.center = CGPointMake(screenWidth/2,screenHeight/2);
            break;
        default:{
            if (_baseLineValue!=0) {
                self.frame =
                CGRectMake(0,0,screenWidth,_baseLineValue);
            }else{
                self.frame =
                CGRectMake(0,0,screenWidth,screenHeight);
            
            }
            _showView.frame = CGRectMake(_showView.frame.origin.x,self.frame.size.height,_showView.frame.size.width,_showView.frame.size.height);
        }
        break;
    }
    _showView.alpha = 0.0f;
}
/*开启pull动画*/
-(void)startPullAnimation{
    [UIView animateWithDuration:_animationTime animations:^{
        switch (_pullStyle) {
            case PullViewTop:
                _showView.frame = CGRectMake(_showView.frame.origin.x,0,_showView.frame.size.width, _showView.frame.size.height);
                break;
            case PullViewDown:
                _showView.frame = CGRectMake(_showView.frame.origin.x,self.frame.size.height-_showView.frame.size.height, _showView.frame.size.width,_showView.frame.size.height);
                break;
            case PullViewCenter:
                break;
            default:
                _showView.frame = CGRectMake(_showView.frame.origin.x,self.frame.size.height-_showView.frame.size.height, _showView.frame.size.width,_showView.frame.size.height);
                break;
        }
        _showView.alpha = 1.0f;
        
        
    }];
}
/*开启结束动画*/
-(void)startStopAnimation:(void(^)(BOOL finish))complete{
    [UIView animateWithDuration:_animationTime animations:^{
        [self initContentView];
     } completion:complete];
}

@end
