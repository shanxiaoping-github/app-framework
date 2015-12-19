//
//  UIView+AmbiguityTests.m
//  Common
//
//  Created by 李泉 on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "UIView+AmbiguityTests.h"

@implementation UIView (AmbiguityTests)
// DEBUG ONLY. Do not ship with this code
- (void) testAmbiguity
{
    if([self hasAmbiguousLayout]){
        NSLog(@"<%@:0x%0x>: %@", self.class.description, (int)self,@"存在问题约束!!!");
    }
    for (UIView *view in self.subviews)
        [view testAmbiguity];
}
@end
