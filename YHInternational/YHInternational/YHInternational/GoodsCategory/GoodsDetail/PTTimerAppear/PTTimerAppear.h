//
//  PTTimerAppear.h
//  PTDemo
//
//  Created by 彭腾 on 15/8/19.
//  Copyright (c) 2015年 彭腾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButton)();

FOUNDATION_EXPORT NSTimeInterval const PTTimeZero;
FOUNDATION_EXPORT NSTimeInterval const PTTimeNine;
FOUNDATION_EXPORT NSTimeInterval const PTTimeTen;
FOUNDATION_EXPORT NSTimeInterval const PTTimeEleven;
FOUNDATION_EXPORT NSTimeInterval const PTTimeTwelve;
FOUNDATION_EXPORT NSTimeInterval const PTTimeFourteen;
FOUNDATION_EXPORT NSTimeInterval const PTTimeSixteen;
FOUNDATION_EXPORT NSTimeInterval const PTTimeTwenty;
FOUNDATION_EXPORT NSTimeInterval const PTTimeTwentyTwo;
FOUNDATION_EXPORT NSTimeInterval const PTTimeTwentyFour;

@interface PTTimerAppear : UIView
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UILabel *countDown;
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (copy, nonatomic) ClickButton button;
@property (strong, nonatomic) UIButton *clickBtn;

- (void)handlerButtonAction:(ClickButton)block;

@end
