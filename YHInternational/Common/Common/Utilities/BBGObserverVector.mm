//
// Created by William Zhao on 13-11-13.
// Copyright (c) 2013 Vipshop Holdings Limited. All rights reserved.
//


#import "BBGObserverVector.h"
#include <vector>

@interface BBGObserverVector ()

@property(nonatomic, strong) NSLock *lock;
@property (nonatomic, assign) NSInteger triggerCount;

@end

@implementation BBGObserverVector {
    std::vector<void*>* _vector;
}

-(id)init {
    self = [super init];
    if(self){
        _vector = new std::vector<void*>();
    }
    return self;
}

-(void)dealloc {
    delete _vector;
}

-(BOOL)addObserver:(id)observer {
    BOOL result = NO;
    [_lock lock];
    std::vector<void*>::iterator it = std::find(_vector->begin(), _vector->end(), (__bridge void*)observer);
    if(it == _vector->end()) {
        _vector->push_back((__bridge void*)observer);
        result = YES;
    }
    [_lock unlock];
    return result;
}

-(BOOL)removeObserver:(id)observer {
    BOOL result = NO;
    [_lock lock];
    std::vector<void*>::iterator it = std::find(_vector->begin(), _vector->end(), (__bridge void*)observer);
    if(it != _vector->end()) {
        _vector->erase(it);
        result = YES;
    }
    [_lock unlock];
    return result;
}

-(BOOL)isExistObserver:(id)observer {
    BOOL result = NO;
    [_lock lock];
    std::vector<void*>::iterator it = std::find(_vector->begin(), _vector->end(), (__bridge void*)observer);
    if(it != _vector->end()) {
        result = YES;
    }
    [_lock unlock];
    return result;
}

-(void)clearAllObserver{
    [_lock lock];
    if (!_vector->empty()) {
        _vector->clear();
    }
    [_lock unlock];
}


-(void)notifyObserver:(SEL)selector {
    [self notifyObserver:selector object:nil];
}

-(void)notifyObserver:(SEL)selector object:(id)object {
    [_lock lock];
    
    self.triggerCount ++;
    if (self.triggerCount < (int)(self.triggerPeriod / _TenthSecond)) {
        [self.lock unlock];
        return;
    }
    else {
        self.triggerCount = 0;
    }
    
    for(std::vector<void*>::const_iterator it = _vector->begin(); it < _vector->end(); ++it){
        void* a = *it;
        id observer = (__bridge id)a;
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector onThread:[NSThread currentThread] withObject:object waitUntilDone:YES];
        }
    }
    [_lock unlock];
}

- (void)setTriggerPeriod:(float)triggerPeriod
{
    _triggerPeriod = MAX(_TenthSecond, triggerPeriod);
    self.triggerCount = 0;
}

@end