//
//  PTTimerAppear.m
//  PTDemo
//
//  Created by 彭腾 on 15/8/19.
//  Copyright (c) 2015年 彭腾. All rights reserved.
//

#import "PTTimerAppear.h"

NSTimeInterval const PTTimeZero = 1442678400;
NSTimeInterval const PTTimeNine = 1442710800;
NSTimeInterval const PTTimeTen = 1442714400;
NSTimeInterval const PTTimeEleven = 1442718000;
NSTimeInterval const PTTimeTwelve = 1442721600;
NSTimeInterval const PTTimeFourteen = 1442728800;
NSTimeInterval const PTTimeSixteen = 1442736000;
NSTimeInterval const PTTimeTwenty = 1442750400;
NSTimeInterval const PTTimeTwentyTwo = 1442757600;
NSTimeInterval const PTTimeTwentyFour = 1442764800;

@interface PTTimerAppear ()
@property (nonatomic, weak) NSTimer *timer;
@end


@implementation PTTimerAppear

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (void)initObject {
    self.bgImage = [UIImageView new];
    self.countDown = [UILabel new];
//    self.clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.bgImage];
    [self addSubview:self.countDown];
//    [self addSubview:self.clickBtn];
}

- (void)setCurrentTime:(NSTimeInterval )currentTime {
    _currentTime = currentTime;
    if (_currentTime) {
        [self start];
    }else {
        self.hidden = YES;
    }
}

- (void)start {
    NSTimeInterval differ;
    self.hidden = NO;
    if (_currentTime >= PTTimeZero&&_currentTime <= PTTimeZero + 900 ) {
        differ = PTTimeZero + 900 - _currentTime;
        [self countdown:differ];
    }else if (_currentTime >= PTTimeNine&&_currentTime <= PTTimeNine + 900) {
        differ = PTTimeNine + 900 - _currentTime;
        [self countdown:differ];
    }else if (_currentTime >= PTTimeTen&&_currentTime <= PTTimeTen + 900) {
        differ = PTTimeTen + 900 - _currentTime;
        [self countdown:differ];
    }else if (_currentTime >= PTTimeEleven&&_currentTime <= PTTimeEleven + 900) {
        differ = PTTimeEleven + 900 - _currentTime;
        [self countdown:differ];
    }else if (_currentTime >= PTTimeTwelve&&_currentTime <= PTTimeTwelve + 900) {
        differ = PTTimeTwelve + 900 - _currentTime;
        [self countdown:differ];
    }else if (_currentTime >= PTTimeFourteen&&_currentTime <= PTTimeFourteen + 900) {
        differ = PTTimeFourteen + 900 - _currentTime;
        [self countdown:differ];
    }else if (_currentTime >= PTTimeSixteen&&_currentTime <= PTTimeSixteen + 900) {
        differ = PTTimeSixteen + 900 - _currentTime;
        [self countdown:differ];
    }else if (_currentTime >= PTTimeTwenty&&_currentTime <= PTTimeTwenty + 900) {
        differ = PTTimeTwenty + 900 - _currentTime;
        [self countdown:differ];
    }else if (_currentTime >= PTTimeTwentyTwo&&_currentTime <= PTTimeTwentyTwo + 900) {
        differ = PTTimeTwentyTwo + 900 - _currentTime;
        [self countdown:differ];
    }else if (_currentTime >= PTTimeTwentyFour&&_currentTime <= PTTimeTwentyFour + 900) {
        differ = PTTimeTwentyFour + 900 - _currentTime;
        [self countdown:differ];
    }else {
        self.hidden = YES;
        if ([_timer isValid]) {
            [_timer invalidate];
            _timer = nil;
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)countdown:(NSTimeInterval )time {
    __block int timeout = time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                _currentTime += 1;
                self.hidden = YES;
                [self start];
            });
        }else{
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *min;
            NSString *sec;
            if (minutes<10) {
                min = [NSString stringWithFormat:@"0%d",minutes];
            }else {
                min = [NSString stringWithFormat:@"%d",minutes];
            }
            if (seconds<10) {
                sec = [NSString stringWithFormat:@"0%d",seconds];
            }else {
                sec = [NSString stringWithFormat:@"%d",seconds];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.countDown.text = [NSString stringWithFormat:@"%@:%@",min,sec];
            });
            timeout--;
            _currentTime += 1;
        }
    });
    dispatch_resume(timer);
}

- (void)timerStart {
    if (_currentTime == PTTimeZero) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else if (_currentTime == PTTimeNine) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else if (_currentTime == PTTimeTen) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else if (_currentTime == PTTimeEleven) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else if (_currentTime == PTTimeTwelve) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else if (_currentTime == PTTimeFourteen) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else if (_currentTime == PTTimeSixteen) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else if (_currentTime == PTTimeTwenty) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else if (_currentTime == PTTimeTwentyTwo) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else if (_currentTime == PTTimeTwentyFour) {
        [_timer invalidate];
        _timer = nil;
        [self start];
    }else {
        _currentTime += 1;
    }
}

- (void)layoutSubviews {
    self.bgImage.frame = self.bounds;
    [self.bgImage setImage:[UIImage imageNamed:@"sc_arbitrarydoor"]];
    self.countDown.frame = CGRectMake(25, self.bounds.size.height-22, self.bounds.size.width, 20);
    self.countDown.contentMode = NSTextAlignmentCenter;
    self.countDown.textColor = UIColorFromHexadecimalRGB(0xcccccc);
    self.countDown.font = APP_FONT_DEMI_LIGHT(15.0f);
//    self.clickBtn.bounds = self.bgImage.bounds;
//    self.clickBtn.backgroundColor = [UIColor blackColor];
//    [self.clickBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    self.bgImage.userInteractionEnabled = YES;
    [self.bgImage addGestureRecognizer:tap];
}

- (void)handlerButtonAction:(ClickButton)block {
    self.button = block;
}

//- (void)btnClick {
//    if (self.button) {
//        self.button();
//    }
//}

- (void)tap:(UITapGestureRecognizer *)sender {
    if (self.button) {
        self.button();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
