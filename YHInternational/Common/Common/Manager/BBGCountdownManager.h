//
//  BBGCountdownManager.h
//  Common
//  用于所有的倒计时管理
//  Created by calvin on 14-5-9.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGLaunchTask.h"

@protocol BBGCountdownObserver <NSObject>

/*!
 * 每秒调用一次
 */
- (void)countdown;

@end

@interface BBGCountdownManager : NSObject <BBGLaunchTask>

+ (BBGCountdownManager *)sharedInstance;

- (void)addObserver:(id<BBGCountdownObserver>)observer;
- (void)removeObserver:(id<BBGCountdownObserver>)observer;

@end
