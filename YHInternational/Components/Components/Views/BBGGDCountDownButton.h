//
//  BBGGDCountDownButton.h
//  Components
//
//  Created by 彭腾 on 15/10/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGGDCountDownButton : UIButton
/**
 *  开始时间
 */
@property (nonatomic, assign) NSTimeInterval startTime;
/**
 *  结束时间
 */
@property (nonatomic, assign) NSTimeInterval endTime;
/**
 *  显示文字
 */
@property (nonatomic, copy) NSString *buyButtonTips;
/**
 *  是否开始
 */
@property (nonatomic, assign) BOOL isBegin;

@end
