//
//  BBGJumpManager.m
//  Common
//
//  Created by Damon on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGJumpManager.h"
#import "BBGMacro.h"
#import "BBGObserverVector.h"

@interface BBGJumpManager ()
@property (nonatomic, strong) BBGObserverVector *observerVector;
@end

@implementation BBGJumpManager
DECLARE_SINGLETON(BBGJumpManager)
- (id)init {
    self = [super init];
    if (self) {
        _observerVector = [[BBGObserverVector alloc] init];
    }
    return self;
}

- (void)managerJumpTo:(BBGJumpType)type {
    [_observerVector notifyObserver:@selector(jumpTo:) object:[NSNumber numberWithInteger:type]];
}

- (void)addObserver:(id<BBGJumpObserver>)observer {
    [_observerVector addObserver:observer];
}

- (void)removeObserver:(id<BBGJumpObserver>)observer {
    [_observerVector removeObserver:observer];
}
@end
