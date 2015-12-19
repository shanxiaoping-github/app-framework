//
//  BBGGDCountDownView.m
//  Components
//
//  Created by 彭腾 on 15/10/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGDCountDownView.h"
#import "BBGCountdownManager.h"
#import "Common.h"

@interface BBGGDCountDownView ()<BBGCountdownObserver>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, assign) NSTimeInterval allTime;

@property (nonatomic, assign) NSTimeInterval presentTime;
/**
 *  0为据开始，1为据结束
 */
@property (nonatomic, assign) NSInteger status;
/**
 *  准确的开始时间
 */
@property (nonatomic, assign) NSTimeInterval currentTime;

@end

@implementation BBGGDCountDownView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (void)initObject {
    self.imageView = [UIImageView new];
    self.timeLab = [UILabel new];
    self.label = [UILabel new];
    [self addSubview:self.imageView];
    [self addSubview:self.timeLab];
    [self addSubview:self.label];
}

- (void)setStartTime:(NSTimeInterval)startTime {
    _startTime = startTime;
}

- (void)setEndTime:(NSTimeInterval)endTime {
    _endTime = endTime;
}

- (void)setCountdownTime:(NSTimeInterval)countdownTime {
    _countdownTime = countdownTime;
}

- (void)setIsBegin:(BOOL)isBegin {
    _isBegin = isBegin;
    if (_isBegin) {
        [self initUI];
    }
}

- (void)initUI {
    self.presentTime = [[BBGConfiguration sharedInstance] getCurrentServerTime].timeIntervalSince1970;
    self.currentTime = self.startTime + 8*3600;
    if (self.presentTime < self.startTime) {
        self.allTime = self.startTime - self.presentTime;
        self.status = 0;
    }else {
        self.allTime = self.endTime - self.presentTime;
        self.status = 1;
    }
    [[BBGCountdownManager sharedInstance]addObserver:self];
}

- (void)countdown {
    NSString *dayStr = [NSString dateWithTimeInterval:self.allTime formatter:@"DD"];
    NSString *hourStr = [NSString dateWithTimeInterval:self.allTime formatter:@"HH"];
    NSInteger day = [dayStr integerValue]-1;
    NSInteger hour = [hourStr integerValue];
    
    if (self.status == 0) {
        self.allTime -= 1;
        
        if (self.allTime>=0) {
            if ((day*24+hour)>48) {
                self.hidden = YES;
            }else {
                self.hidden = NO;
                NSString *hourStr = [NSString dateWithTimeInterval:self.allTime formatter:@"HH"];
                NSString *timeStr = [NSString dateWithTimeInterval:self.allTime formatter:@":mm:ss"];
                self.timeLab.text = [NSString stringWithFormat:@"%@%@",hourStr,timeStr];
                self.timeLab.font = APP_FONT(16.0f);
                self.timeLab.textColor = UIColorFromHexadecimalRGB(0xfaa9bf);
                [self.timeLab sizeToFit];
                CGRect frame = self.timeLab.frame;
                frame.origin.x = self.frame.size.width-self.timeLab.frame.size.width;
                frame.origin.y = 5.0f;
                self.timeLab.frame = frame;
                self.imageView.frame = CGRectMake(self.timeLab.frame.origin.x-24.0f, self.timeLab.frame.origin.y-1.0f, 20.0f, 20.0f);
                [self.imageView setImage:[UIImage imageNamed:@"gd_Lightning_notbegin"]];
                self.label.text = @"后开始";
                self.label.font = APP_FONT(11.0f);
                self.label.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT;
                [self.label sizeToFit];
                CGRect frame1 = self.label.frame;
                frame1.origin.y = self.timeLab.frame.size.height+self.timeLab.frame.origin.y+5.0f;
                frame1.origin.x = self.frame.size.width-self.label.frame.size.width;
                self.label.frame = frame1;
            }
        }else {
            if ([self.delegate conformsToProtocol:@protocol(BBGGDCountDownViewDelegate)]&&[self.delegate respondsToSelector:@selector(countDownFinish)]) {
                [self.delegate countDownFinish];
            }
            [[BBGCountdownManager sharedInstance]removeObserver:self];
            [self initUI];
        }
    }else {
        self.allTime -= 1;
        if (self.allTime >= 0) {
            if ((day*24+hour)>48) {
                self.hidden = YES;
            }else {
                NSString *dayStr = [NSString dateWithTimeInterval:self.allTime formatter:@"DD"];
                NSString *hourStr = [NSString dateWithTimeInterval:self.allTime formatter:@"HH"];
                NSString *timeStr = [NSString dateWithTimeInterval:self.allTime formatter:@":mm:ss"];
                NSString *string = [NSString stringWithFormat:@"%ld",(dayStr.integerValue-1)*24+hourStr.integerValue];
                self.timeLab.text = [NSString stringWithFormat:@"%@%@",string,timeStr];
                self.timeLab.font = APP_FONT(16.0f);
                self.timeLab.textColor = UICOLOR_FONT_IMPORTANT_RED;
                [self.timeLab sizeToFit];
                CGRect frame = self.timeLab.frame;
                frame.origin.x = self.frame.size.width-self.timeLab.frame.size.width;
                frame.origin.y = 5.0f;
                self.timeLab.frame = frame;
                self.imageView.frame = CGRectMake(self.timeLab.frame.origin.x-24.0f, self.timeLab.frame.origin.y-1.0f, 20.0f, 20.0f);
                [self.imageView setImage:[UIImage imageNamed:@"gd_Lightning"]];
                self.label.text = @"后结束";
                self.label.font = APP_FONT(11.0f);
                self.label.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT;
                [self.label sizeToFit];
                CGRect frame1 = self.label.frame;
                frame1.origin.y = self.timeLab.frame.size.height+self.timeLab.frame.origin.y+5.0f;
                frame1.origin.x = self.frame.size.width-self.label.frame.size.width;
                self.label.frame = frame1;
            }
        }else {
            self.hidden = YES;
            [[BBGCountdownManager sharedInstance]removeObserver:self];
        }
    }
}

- (void)dealloc {
    [[BBGCountdownManager sharedInstance]removeObserver:self];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
