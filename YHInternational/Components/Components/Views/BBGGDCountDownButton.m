//
//  BBGGDCountDownButton.m
//  Components
//
//  Created by 彭腾 on 15/10/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGDCountDownButton.h"
#import "Common.h"
#import "BBGCountdownManager.h"

@interface BBGGDCountDownButton ()<BBGCountdownObserver>
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, assign) NSTimeInterval allTime;
@end

@implementation BBGGDCountDownButton

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
    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UICOLOR_FONT_IMPORTANT_RED CGColor];
    self.clipsToBounds = YES;
    self.timeLab = [UILabel new];
    self.titleLab = [UILabel new];
    [self addSubview:self.timeLab];
    [self addSubview:self.titleLab];
}

- (void)initUI {
    _allTime = _endTime - _startTime;
    [[BBGCountdownManager sharedInstance]addObserver:self];
}

- (void)countdown {
    _allTime -= 1;
    if (self.allTime >= 0) {
        NSString *dayStr = [NSString dateWithTimeInterval:self.allTime formatter:@"DD"];
        NSString *hourStr = [NSString dateWithTimeInterval:self.allTime formatter:@"HH"];
        NSString *timeStr = [NSString dateWithTimeInterval:self.allTime formatter:@"mm:ss"];
        
        NSInteger day = [dayStr integerValue]-1;
        NSInteger hour = [hourStr integerValue];
        
        if ((day*24+hour)>48) {
            self.timeLab.hidden = YES;
            self.titleLab.frame = self.bounds;
            self.titleLab.textAlignment = NSTextAlignmentCenter;
            self.titleLab.font = APP_FONT(14.0f);
            self.titleLab.text = self.buyButtonTips;
            self.titleLab.textColor = UICOLOR_FONT_IMPORTANT_RED;
        }else {
            self.timeLab.hidden = NO;
            self.timeLab.frame = CGRectMake(0, 5.0f, self.frame.size.width, (self.frame.size.height-15.0f)/2.0f);
            self.timeLab.textAlignment = NSTextAlignmentCenter;
            self.timeLab.font = APP_FONT(14.0f);
            self.timeLab.text = [NSString stringWithFormat:@"%ld:%@",(day*24+hour),timeStr];
            self.timeLab.textColor = UICOLOR_FONT_IMPORTANT_RED;
            self.titleLab.frame = CGRectMake(0, self.timeLab.frame.origin.y+self.timeLab.frame.size.height+5.0f, self.frame.size.width, (self.frame.size.height-15.0f)/2.0f);
            self.titleLab.textAlignment = NSTextAlignmentCenter;
            self.titleLab.font = APP_FONT(14.0f);
            self.titleLab.text = self.buyButtonTips;
            self.titleLab.textColor = UICOLOR_FONT_IMPORTANT_RED;
        }
    }else {
        self.timeLab.hidden = YES;
        self.titleLab.frame = self.bounds;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.font = APP_FONT(14.0f);
        self.titleLab.text = self.buyButtonTips;
        self.titleLab.textColor = UICOLOR_FONT_IMPORTANT_RED;
        [[BBGCountdownManager sharedInstance] removeObserver:self];
    }
}

- (void)setStartTime:(NSTimeInterval)startTime {
    _startTime = startTime;
}

- (void)setEndTime:(NSTimeInterval)endTime {
    _endTime = endTime;
}

- (void)setBuyButtonTips:(NSString *)buyButtonTips {
    _buyButtonTips = buyButtonTips;
}

- (void)setIsBegin:(BOOL)isBegin {
    _isBegin = isBegin;
    if (_isBegin) {
        [self initUI];
    }
}

- (void)dealloc {
    [[BBGCountdownManager sharedInstance] removeObserver:self];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
