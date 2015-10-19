//
//  HttpEvent.m
//  mqsystem
//
//  Created by shanxiaoping on 15-1-31.
//  Copyright (c) 2015年 yicai. All rights reserved.
//

#import "HttpEvent.h"

@implementation HttpEvent
@synthesize actionUrl=_actionUrl;
@synthesize parames=_parames;
@synthesize callBack=_callBack;
-(void)addParame:(NSString *)value{
    if (!_parames) {
        self.parames = [NSMutableArray new];
    }
    [_parames addObject:value];
}
@end
