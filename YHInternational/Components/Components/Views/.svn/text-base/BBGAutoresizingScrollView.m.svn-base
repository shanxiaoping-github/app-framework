//
//  BBGAutoresizingScrollView.m
//  Components
//
//  Created by calvin on 14-8-14.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGAutoresizingScrollView.h"

@implementation BBGAutoresizingScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    CGRect oldFrame = self.frame;
    [super setFrame:frame];
    CGFloat deltaX = frame.size.width / oldFrame.size.width;
    CGFloat deltaY = frame.size.height / oldFrame.size.height;
    CGSize oldSize = self.contentSize;
    self.contentSize = CGSizeMake(oldSize.width * deltaX, oldSize.height * deltaY);
    CGPoint oldPoint = self.contentOffset;
    self.contentOffset = CGPointMake(oldPoint.x * deltaX, oldPoint.y * deltaY);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
