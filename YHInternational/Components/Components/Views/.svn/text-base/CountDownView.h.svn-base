//
//  CountDownView.h
//  Demo
//
//  Created by Damon on 15/7/10.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGCountdownManager.h"
#import "BBGObserverVector.h"

@protocol CountDownDelegate <NSObject>
@optional
- (void)countdownFinished;
- (void)countDowningStr:(NSString *)str;
@end

@interface CountDownView : UIView<BBGCountdownObserver>

@property (nonatomic, assign) BOOL isCountDown;

@property (nonatomic, assign) NSTimeInterval beginTime;

@property (nonatomic, assign) NSTimeInterval endTime;

@property (nonatomic, assign) NSTimeInterval allTime;

@property (nonatomic, assign) double percent;

@property (nonatomic, strong) NSString * contentStr;

@property (nonatomic, strong) UIColor * presentColor;

@property (nonatomic, strong) UIColor * backColor;

@property (nonatomic, weak) id<CountDownDelegate> delegate;

@end
