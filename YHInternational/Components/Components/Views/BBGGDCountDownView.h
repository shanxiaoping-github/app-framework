//
//  BBGGDCountDownView.h
//  Components
//
//  Created by 彭腾 on 15/10/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBGGDCountDownViewDelegate <NSObject>
@optional
- (void)countDownFinish;
@end

@interface BBGGDCountDownView : UIView
/**
 *  开始时间
 */
@property (nonatomic, assign) NSTimeInterval startTime;
/**
 *  结束时间
 */
@property (nonatomic, assign) NSTimeInterval endTime;
/**
 *  是否开始
 */
@property (nonatomic, assign) BOOL isBegin;
/**
 *  营销配置的倒计时
 */
@property (nonatomic, assign) NSTimeInterval countdownTime;

@property (nonatomic, assign) id<BBGGDCountDownViewDelegate> delegate;

@end
