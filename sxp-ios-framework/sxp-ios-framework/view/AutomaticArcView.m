//
//  AutomaticArcView.m
//  gigold
//
//  Created by 单小萍 on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//
#import "AutomaticArcView.h"
#import "MathUtil.h"
@interface AutomaticArcView(){
    CAShapeLayer* strokeShapeLayer;
    NSTimer* animationTimer;
    CGFloat currentRadian;
    BOOL add;
}
@end
@implementation AutomaticArcView
@synthesize strokeColor = _strokeColor;
@synthesize strokeWidth = _strokeWidth;
@synthesize startRadian = _startRadian;
@synthesize endRadian = _endRadian;
@synthesize deleget = _deleget;
@synthesize drawTime=_drawTime;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}
//初始化默认数据
-(void)initData{
    self.drawTime = 1.f;
    self.strokeColor = [UIColor greenColor];
    self.strokeWidth = 2.f;
    self.startRadian = 10;
    self.endRadian = 360;
    add = NO;
    
}
//初始化view
-(void)initView{
    strokeShapeLayer = [CAShapeLayer layer];
    strokeShapeLayer.frame = self.bounds;
    strokeShapeLayer.fillColor = [UIColor clearColor].CGColor;
    strokeShapeLayer.strokeColor = _strokeColor.CGColor;
    strokeShapeLayer.lineWidth = _strokeWidth;
    [self.layer addSublayer:strokeShapeLayer];
    add = YES;
}
//显示动画
-(void)showAnimation{
    if (!add) {
        [self initView];
    }
    CGFloat evenTime = _drawTime/((_endRadian - _startRadian)/5);
    currentRadian = _startRadian;
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:evenTime target:self selector:@selector(drawArc) userInfo:nil repeats:YES];
}
-(void)drawArc{
    
    if (currentRadian == _endRadian) {
        strokeShapeLayer.path = [UIBezierPath bezierPathWithArcCenter:self.center radius:(CGRectGetWidth(self.bounds)-_strokeWidth)/2.f startAngle:DEGREES_TO_RADIANS(_startRadian) endAngle:DEGREES_TO_RADIANS(currentRadian) clockwise:YES].CGPath;
        [animationTimer invalidate];
        [self endDrawAction];
        return;
    }
    strokeShapeLayer.path = [UIBezierPath bezierPathWithArcCenter:self.center radius:(CGRectGetWidth(self.bounds)-_strokeWidth)/2.f startAngle:DEGREES_TO_RADIANS(_startRadian) endAngle:DEGREES_TO_RADIANS(currentRadian) clockwise:YES].CGPath;
    currentRadian += 5;
    if(currentRadian > _endRadian) {
        currentRadian = _endRadian;
    }
}
//画完圆弧的响应
-(void)endDrawAction{
    if(_deleget){
        [_deleget automaticArcViewEndDraw];
    }
}
@end
