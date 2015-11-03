//
//  CustomerProgressLableView.m
//  gigold
//
//  Created by 单小萍 on 15/10/31.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "CustomerProgressLableView.h"
#import "StringUtil.h"
#import "Fonts.h"
@interface CustomerProgressLableView(){
    BOOL isInitDefault;
}
@end
@implementation CustomerProgressLableView
@synthesize radian = _radian;
@synthesize backgoundCustomerColor = _backgoundCustomerColor;
@synthesize progressColor = _progressColor;
@synthesize progressValue = _progressValue;
@synthesize maxValue = _maxValue;
@synthesize leftlabelStr = _leftlabelStr;
@synthesize flowlabelStr = _flowlabelStr;
@synthesize leftlabelColor = _leftlabelColor;
@synthesize leftlabelFont = _leftlabelFont;
@synthesize flowlabelColor = _flowlabelColor;
@synthesize flowlabelFont = _flowlabelFont;
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initDefaultValue];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultValue];
    }
    return self;
}
/*
 *初始化默认值
 */
-(void)initDefaultValue{
    if (isInitDefault) {
        return;
    }else{
        isInitDefault = YES;
    }
    self.radian = 0;
    self.backgoundCustomerColor = [UIColor whiteColor];
    self.progressColor = [UIColor blueColor];
    self.progressValue = 50.f;
    self.maxValue = 100.f;
    
    self.leftlabelStr = @"";
    self.leftlabelColor = [UIColor whiteColor];
    self.leftlabelFont = normal_font;
    
    self.flowlabelStr = [NSString stringWithFormat:@"%lf",_progressValue];
    self.flowlabelColor = [UIColor whiteColor];
    self.flowlabelFont = normal_font;
}
-(void)drawProgress{
        self.backgroundColor = _backgoundCustomerColor;
        self.layer.cornerRadius = _radian;
        self.clipsToBounds = YES;
    
        CGSize viewSize = self.bounds.size;
        CGFloat progeressWidth = (_progressValue/_maxValue)*viewSize.width;
        UIView* progeressView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f,progeressWidth,viewSize.height+10)];
        progeressView.backgroundColor = _progressColor;
        progeressView.layer.cornerRadius = _radian;
        [self addSubview:progeressView];
    
        CGFloat leftLabelHeight = [StringUtil getStringHeight:_leftlabelStr font:_leftlabelFont size:viewSize];
        CGFloat leftLabelWidth = [StringUtil getStringWidth:_leftlabelStr font:_leftlabelFont size:viewSize];
        UILabel* leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.f, (viewSize.height-leftLabelHeight)/2,leftLabelWidth, leftLabelHeight)];
        leftLabel.font = _leftlabelFont;
        leftLabel.textColor = _leftlabelColor;
        leftLabel.text  = _leftlabelStr;
        [self addSubview:leftLabel];
    
        CGFloat flowLabelHeight = [StringUtil getStringHeight:_flowlabelStr font:_flowlabelFont size:viewSize];
        CGFloat flowLabelWidth = [StringUtil getStringWidth:_flowlabelStr font:_flowlabelFont size:viewSize];
        UILabel* flowLabel = [[UILabel alloc]initWithFrame:CGRectMake(progeressWidth - flowLabelWidth, (viewSize.height-flowLabelHeight)/2,flowLabelWidth, flowLabelHeight)];
        flowLabel.font = _flowlabelFont;
        flowLabel.textColor = _flowlabelColor;
        self.flowlabelStr = [NSString stringWithFormat:@"%lf",_progressValue];
        flowLabel.text  = _flowlabelStr;
        [self addSubview:flowLabel];
}
@end
