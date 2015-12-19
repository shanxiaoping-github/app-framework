//
//  CustomerView.m
//  gigold
//
//  Created by 单小萍 on 15/10/26.
//  Copyright © 2015年 wsc. All rights reserved.
//


#import "CustomerView.h"
#import "ViewUtil.h"
#import "appliacation_attribute.h"
@implementation CustomerView
@synthesize backGroundColor = _backGroundColor;
@synthesize pullStyle = _pullStyle;
@synthesize showView = _showView;
@synthesize isClickOutsideCancel=_isClickOutsideCancel;
@synthesize clickDeleget = _clickDeleget;
@synthesize baseLineValue = _baseLineValue;
@synthesize animationTime = _animationTime;
@synthesize currentTag = _currentTag;
-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.animationTime = 0.5f;
        self.baseLineValue = 0.f;
        self.pullStyle = PullViewDown;
        self.isClickOutsideCancel = YES;
		self.currentTag = UN_CONTENT_CLIP_STOP;
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
        self.frame = CGRectMake(0.f,0.f,view.frame.size.width,view.frame.size.height);
        if (_showView&&![_showView superview]) {
            [self addContentView];
        }
        if (_isClickOutsideCancel) {
            if (self.tag == 1111) {
                self.userInteractionEnabled = YES;
            }else{
                self.tag = 1111;
                [ViewUtil registerGestures:self target:self action:@selector(stopDialog)];
            }
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
-(void)showDialogByViewTop:(UIView *)view{
    self.pullStyle = PullViewDown;
    CGFloat baseLine = view.frame.origin.y;
    [self showDialogByBaseLine:baseLine view:[view superview]];
}
-(void)showDialogByViewLeft:(UIView *)view{
    self.pullStyle = PullviewRight;
    CGFloat baseLine = view.frame.origin.x;
    [self showDialogByBaseLine:baseLine view:view];
}
-(void)showDialogByViewRight:(UIView *)view{
    self.pullStyle = PullViewLeft;
    CGFloat baseLine = view.frame.origin.x+view.frame.size.width;
    [self showDialogByBaseLine:baseLine view:view];
}

-(void)stopDialog{
    [self startStopAnimation:^(BOOL finish) {
        [self removeFromSuperview];
        [_showView removeFromSuperview];
		if(_clickDeleget){
			if ([_currentTag isEqualToString:UN_CONTENT_CLIP_STOP]) {
				[_clickDeleget click:UN_CONTENT_CLIP_STOP];
			}else{
				[_clickDeleget click:_currentTag];
				self.currentTag = UN_CONTENT_CLIP_STOP;
			}
		}
    }];
	
}
//添加内容
-(void)addContentView{
    [self initContentView];
    if (_isClickOutsideCancel){
        if (_showView.tag == 1111){
            _showView.userInteractionEnabled = YES;
        }else{
            _showView.tag = 1111;
            [ViewUtil registerGestures:_showView target:self action:@selector(stopDialog)];
        }
    }
    [self addSubview:_showView];
}
-(void)initContentView{
    switch (_pullStyle){
        case PullViewTop:{
            if (_baseLineValue!=0) {
                self.frame =
                CGRectMake(0,_baseLineValue,self.frame.size.width,self.frame.size.height-_baseLineValue);
            }
//            else{
//                self.frame =
//                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
//                
//            }
            _showView.frame = CGRectMake(_showView.frame.origin.x,0 -_showView.frame.size.height, _showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        case PullViewDown:{
            if (_baseLineValue!=0) {
                self.frame =
                CGRectMake(0,0,self.frame.size.width,_baseLineValue);
            }
//            else{
//                self.frame =
//                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
//                
//            }
            _showView.frame = CGRectMake(_showView.frame.origin.x,self.frame.size.height,_showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        case PullViewCenter:
            _showView.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
            break;
        case PullViewLeft:{
            if (_baseLineValue != 0){
                self.frame =
                CGRectMake(_baseLineValue,0,self.frame.size.width-_baseLineValue,self.frame.size.height);
            }
//            else{
//                self.frame =
//                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
//                
//            }
            _showView.frame = CGRectMake(0-_showView.frame.size.width,_showView.frame.origin.y,_showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        case PullviewRight:{
            if (_baseLineValue != 0){
                self.frame =
                CGRectMake(0,0,_baseLineValue,self.frame.size.height);
            }
//            else{
//                self.frame =
//                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
//                
//            }
            _showView.frame = CGRectMake(self.frame.size.width,_showView.frame.origin.y,_showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        default:{
            if (_baseLineValue!=0) {
                self.frame =
                CGRectMake(0,0,self.frame.size.width,_baseLineValue);
            }
//            else{
//                self.frame =
//                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
//            
//            }
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
            case PullViewLeft:
                _showView.frame = CGRectMake(0,_showView.frame.origin.y,_showView.frame.size.width,_showView.frame.size.height);
                break;
            case PullviewRight:
                _showView.frame = CGRectMake(self.frame.size.width-_showView.frame.size.width,_showView.frame.origin.y,_showView.frame.size.width,_showView.frame.size.height);
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
