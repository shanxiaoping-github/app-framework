//
//  GSNoticeBoardView.m
//  NoticeBoard
//
//  Created by 小怪兽 on 15/3/5.
//  Copyright (c) 2015年 小怪兽. All rights reserved.
//

#import "GSNoticeBoardView.h"

@interface GSNoticeBoardView ()
{
    int     _index;
    UILabel *_label1;
    UILabel *_label2;
    NSTimer *_timer;
}

@end

@implementation GSNoticeBoardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createLabel];
    }
    return self;
}

#pragma mark--------创建控件
- (void)createLabel {
    self.clipsToBounds = YES;
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.width - 5, self.height)];
    _label1.textColor = UIColorFromHexadecimalRGB(0x333333);
    _label1.textAlignment = NSTextAlignmentLeft;
    _label1.font = APP_FONT(13);
    _label1.backgroundColor = [UIColor whiteColor];
    _label1.userInteractionEnabled = YES;
    
    
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, self.height, self.width - 5, self.height)];
    _label2.textColor = UIColorFromHexadecimalRGB(0x333333);
    _label2.textAlignment = NSTextAlignmentLeft;
    _label2.font = APP_FONT(13);
    _label2.backgroundColor = [UIColor whiteColor];
    _label2.userInteractionEnabled = YES;
    
    
    
    [self addSubview:_label1];
    [self addSubview:_label2];
    
    
    UITapGestureRecognizer* tapGestureRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_label1 addGestureRecognizer:tapGestureRecognizer1];
    
    UITapGestureRecognizer* tapGestureRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_label2 addGestureRecognizer:tapGestureRecognizer2];
    
}

#pragma mark--------开始滚动
- (void)startAnimation {
    if ( _contentArray.count >= 2) {

        _label1.text = [_contentArray ARRAY_OBJ_AT(0) ];
        _label2.text = [_contentArray ARRAY_OBJ_AT(1) ];
        _index = 1;
        
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        }
        

    }else{
        
        if (_contentArray.count == 1) {
            _label1.text = [_contentArray ARRAY_OBJ_AT(0) ];
        } 
    }
}

- (void)stopAnimation{
    [_timer invalidate];
    self.contentArray = nil;
    [_label1 removeFromSuperview];
    [_label2 removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark--------定时器方法
- (void)timerAction {
    
    _index ++;
    _index = _index % _contentArray.count;
    
    [UIView animateWithDuration:1 animations:^{
        _label1.top -= self.height;
        _label2.top -= self.height;
    } completion:^(BOOL finished) {
        if (_label1.top < 0) {
            _label1.top = self.height;
            _label1.text = [_contentArray ARRAY_OBJ_AT(_index) ];
            return;
        }
        if (_label2.top < 0) {
            _label2.top = self.height;
            _label2.text = [_contentArray ARRAY_OBJ_AT(_index) ];
           }
    }];
    
}

#pragma mark--------点击手势
- (void)tapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    int index;
    if (_index == 0) {
        index = (int)_contentArray.count - 1;
    }else {
        index = _index - 1;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectAtIndex:)]) {
        [self.delegate didSelectAtIndex:index];
    }
    
}

- (void)dealloc{
    [self stopAnimation];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
