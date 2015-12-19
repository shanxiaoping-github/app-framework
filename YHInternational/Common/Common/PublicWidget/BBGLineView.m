//
//  BBGLineView.m
//  BBGAlertView
//
//  Created by yangjie on 15/4/21.
//  Copyright (c) 2015年 yangjie. All rights reserved.
//

#import "BBGLineView.h"

@implementation BBGLineView

+ (BBGLineView*)horizonlineWithStart:(CGPoint)start len:(float)len width:(float)width color:(UIColor*)color{
    BBGLineView* line = [[BBGLineView alloc] initWithFrame:CGRectMake(start.x,start.y - width/2.0, len,width)];
    line.lineType = horizon;
    line.startPoint = start;
    line.length = len;
    line.width = width;
    line.color = color;
    return line;
}

+ (BBGLineView*)verticallineWithStart:(CGPoint)start len:(float)len width:(float)width color:(UIColor*)color{
    BBGLineView* line = [[BBGLineView alloc] initWithFrame:CGRectMake(start.x - width/2.0,start.y, width,len)];
    line.lineType = vertical;
    line.startPoint = start;
    line.length = len;
    line.width = width;
    line.color = color;
    return line;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    return self;
}

- (void)reShape{
    if (_color == nil) {
        [self setBackgroundColor:[UIColor grayColor]];
    }else{
        [self setBackgroundColor:_color];
    }
    if (_lineType == horizon) {
        [self setFrame:CGRectMake(_startPoint.x,_startPoint.y - _width/2.0, _length,_width)];
    }
    if (_lineType == vertical) {
        [self setFrame:CGRectMake(_startPoint.x - _width/2.0,_startPoint.y, _width,_length)];
    }
    if (_lineType == none) {
    }
}
- (void)setStartPoint:(CGPoint)startPoint{
    _startPoint = startPoint;
    [self reShape];
}
- (void)setLength:(float)length{
    _length = length;
    [self reShape];
}
- (void)setWidth:(float)width{
    _width = width;
    [self reShape];
}
- (void)setColor:(UIColor *)color{
    _color = color;
    [self reShape];
}


@end
