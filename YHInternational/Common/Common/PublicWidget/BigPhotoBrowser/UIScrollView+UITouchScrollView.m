//
//  UIScrollView+UITouchScrollView.m
//  Common
//
//  Created by yangjie on 15/5/11.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "UIScrollView+UITouchScrollView.h"

@implementation UIScrollView (UITouchScrollView)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

@end
