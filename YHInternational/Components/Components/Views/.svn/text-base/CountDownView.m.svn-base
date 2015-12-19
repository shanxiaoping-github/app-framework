//
//  CountDownView.m
//  Demo
//
//  Created by Damon on 15/7/10.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import "CountDownView.h"
#import "Common.h"
@interface CountDownView ()

@property (nonatomic, assign) float length;

@property (nonatomic, strong) UILabel * label;

@property (nonatomic, strong) UIView * presentView;

@property (nonatomic, strong) UIView * backView;

@property (nonatomic, strong) NSString * timeStr;

@property (nonatomic, assign) NSTimeInterval currentTime;

@end

@implementation CountDownView

- (void)awakeFromNib{
    [super awakeFromNib];
    [[BBGCountdownManager sharedInstance] addObserver:self];
    
    self.layer.cornerRadius = self.frame.size.height / 2;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[BBGCountdownManager sharedInstance] addObserver:self];
        self.layer.cornerRadius = frame.size.height / 2;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.layer.cornerRadius = frame.size.height / 2;
    self.length = frame.size.width;
    
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:frame]; 
        _backView.layer.cornerRadius = frame.size.height / 2;
        [self addSubview:_backView];
    }
    
    if (!_presentView) {
        _presentView = [[UIView alloc]initWithFrame:frame];
        _presentView.layer.cornerRadius = frame.size.height / 2;
        [self addSubview:_presentView];
    }
    
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:frame];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = UICOLOR_BACKGROUND_GRAYWHITE;
        _label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_label];
    }
}

- (void)setPresentColor:(UIColor *)presentColor{
    _presentColor = presentColor;
    self.presentView.backgroundColor = presentColor;
}

- (void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.backView.backgroundColor = backColor;
}

- (void)setContentStr:(NSString *)contentStr{
    _label.text = contentStr;
    _label.font = APP_FONT(14.0);

}

- (void)setPercent:(double)percent{
    _percent = percent;
    CGRect frame = self.presentView.frame;
    frame.size.width = self.length * percent;
    
    self.presentView.frame = frame;
}

- (void)setIsCountDown:(BOOL)isCountDown{
    _isCountDown = isCountDown;
    if (_isCountDown) {
        if (self.percent == 0) {
            [self startCountDown];
        }
    }else{
        
    }
}

- (void)startCountDown{
    self.currentTime = self.endTime - [[BBGConfiguration sharedInstance] getCurrentServerTime].timeIntervalSince1970;
    self.allTime = self.endTime - self.beginTime;
    if (self.currentTime <= 0) {
        self.isCountDown = NO;
    }
    
    self.percent = self.currentTime / self.allTime;
    
    
    NSString * dayStr = [NSString dateWithTimeInterval:self.currentTime formatter:@"DD"];
    NSString * hourStr = [NSString dateWithTimeInterval:self.currentTime formatter:@"HH"];
    NSInteger hours = (dayStr.integerValue - 1) * 24;
    NSString * timeStr = [NSString dateWithTimeInterval:self.currentTime formatter:@":mm:ss"];
    [self.delegate countDowningStr:[NSString stringWithFormat:@"%ld%@",(hours + hourStr.integerValue),timeStr]];
}


#pragma mark - CountDownManager
- (void)countdown{
    if (self.isCountDown) {

        self.currentTime -= 1;
        if (self.delegate && [self.delegate respondsToSelector:@selector(countDowningStr:)]) {
            if (self.currentTime >= 0) {
                
                NSString * dayStr = [NSString dateWithTimeInterval:self.currentTime formatter:@"DD"];
                NSString * hourStr = [NSString dateWithTimeInterval:self.currentTime formatter:@"HH"];
                NSInteger hours = (dayStr.integerValue - 1) * 24;
                NSString * timeStr = [NSString dateWithTimeInterval:self.currentTime formatter:@":mm:ss"];
                [self.delegate countDowningStr:[NSString stringWithFormat:@"%ld%@",(hours + hourStr.integerValue),timeStr]];
            }
        }
        
        
        __weak CountDownView * weakSelf = self;
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            double currentPercent = weakSelf.currentTime/weakSelf.allTime;
            if (currentPercent <= .1) {
                weakSelf.percent = .1;
            }else{
                weakSelf.percent = currentPercent;
            }
            
        } completion:^(BOOL finished) {
            if (weakSelf.currentTime <= 0) {
                weakSelf.isCountDown = NO;
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(countdownFinished)]) {
                    [weakSelf.delegate countdownFinished];
                }
                return;
            }
        }];
    }
    
}

- (void)mCountdown{
//    if (self.isCountDown) {
//        
//        if (self.percent <= 0) {
//            
//            self.isCountDown = NO;
//            if (self.delegate && [self.delegate respondsToSelector:@selector(countdownFinished)]) {
//                [self.delegate countdownFinished];
//            }
//            return;
//        }
//        self.beginTime -= 100;
//        [self.delegate countDowningStr:[NSString dateWithTimeInterval:self.beginTime formatter:@"HH:mm:ss"]];
//        
//        __weak CountDownView * weakSelf = self;
//        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//            
//            weakSelf.percent = weakSelf.beginTime/weakSelf.allTime;
//            
//        } completion:^(BOOL finished) {
//            
//            if (weakSelf.beginTime <= 0) {
//                weakSelf.beginTime = 0;
//            }
//        }];
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc{
    [[BBGCountdownManager sharedInstance] removeObserver:self];
}

@end
