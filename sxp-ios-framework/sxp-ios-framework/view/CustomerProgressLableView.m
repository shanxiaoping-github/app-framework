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
#import "Colors.h"
#import "appliacation_attribute.h"
@interface CustomerProgressLableView(){
    BOOL isInitDefault;
    
    UIView* backgroundView;
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
@synthesize isRate =_isRate;
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
    self.backgoundCustomerColor = [UIColor clearColor];
    self.progressColor = lightBlueColor;
    self.progressValue = 50.f;
    self.maxValue = 100.f;
    
    self.leftlabelStr = @"";
    self.leftlabelColor = [UIColor whiteColor];
    self.leftlabelFont = last_small_font;
    
    self.flowlabelStr = [NSString stringWithFormat:@"%.2lf",_progressValue];
    self.flowlabelColor = [UIColor whiteColor];
    self.flowlabelFont = last_small_font;
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 0,screenWidth-2*10, self.bounds.size.height)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
}
-(void)drawProgress{
    self.backgroundColor = _backgoundCustomerColor;
    self.layer.cornerRadius = _radian;
    self.clipsToBounds = YES;
    
    CGFloat leftLabelWidth = [StringUtil getStringWidth:_leftlabelStr font:_leftlabelFont size:backgroundView.frame.size];
    CGSize viewSize = CGSizeMake(backgroundView.frame.size.width-(leftLabelWidth+10), backgroundView.frame.size.height);
    CGFloat progeressWidth = MAX((_progressValue/_maxValue)*viewSize.width, 80);
    UIView* progeressView = [[UIView alloc]initWithFrame:CGRectMake(leftLabelWidth+10, 0.f,progeressWidth,viewSize.height)];
    progeressView.backgroundColor = _progressColor;
    progeressView.layer.cornerRadius = _radian;
    [backgroundView addSubview:progeressView];
    
    UIView* leftView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0,(NSInteger)leftLabelWidth+11, viewSize.height)];
    leftView.backgroundColor = _progressColor;
    [backgroundView addSubview:leftView];
    
    UILabel* leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 0,leftView.frame.size.width-10, leftView.frame.size.height)];
    leftLabel.backgroundColor = _progressColor;
    leftLabel.font = _leftlabelFont;
    leftLabel.textColor = _leftlabelColor;
    leftLabel.text  = _leftlabelStr;
    [leftView addSubview:leftLabel];
    if (_isRate) {
        self.flowlabelStr = [NSString stringWithFormat:@"%.4f%%",_progressValue*100];
    }else{
        self.flowlabelStr = [NSString stringWithFormat:@"%.4lf",_progressValue];
    }
    
    UILabel* flowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,progeressView.frame.size.width-10, progeressView.frame.size.height)];
    flowLabel.adjustsFontSizeToFitWidth = YES;
    flowLabel.textAlignment = NSTextAlignmentRight;
    flowLabel.font = _flowlabelFont;
    flowLabel.textColor = _flowlabelColor;
    flowLabel.text  = _flowlabelStr;
    [progeressView addSubview:flowLabel];
}
@end
