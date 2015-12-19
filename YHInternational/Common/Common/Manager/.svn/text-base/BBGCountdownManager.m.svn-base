//
//  BBGCountdownManager.m
//  Common
//
//  Created by calvin on 14-5-9.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGCountdownManager.h"
#import "BBGObserverVector.h"
#import "BBGMacro.h"

@interface BBGCountdownManager ()

@property (nonatomic, strong) BBGObserverVector *observerVector;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation BBGCountdownManager

DECLARE_SINGLETON(BBGCountdownManager)

- (id)init {
    self = [super init];
    if (self) {
        _observerVector = [[BBGObserverVector alloc] init];
    }
    return self;
}


- (void)addObserver:(id<BBGCountdownObserver>)observer {
    [_observerVector addObserver:observer];
}

- (void)removeObserver:(id<BBGCountdownObserver>)observer {
    [_observerVector removeObserver:observer];
}

- (void)notifyObserver {
    [_observerVector notifyObserver:@selector(countdown)];
}

- (void)handleTimer:(NSDictionary *)userInfo {
    [self notifyObserver];
}

#pragma mark - BBGLaunchTask
- (void)launchTask:(BBGLaunchTaskFinished)finished {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    finished(YES);
}

- (NSString *)taskName {
    return @"倒计时管理";
}

@end
