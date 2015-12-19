//
//  LoginBtnView.m
//  YHInternational
//
//  Created by Damon on 15/9/23.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "LoginBtnView.h"

@implementation LoginBtnView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(0, 30, self.frame.size.width, 40)];
        [self addSubview:_button];
        
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setFrame:CGRectMake(self.frame.size.width - 50, 0, 50, 30)];
        _forgetBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateHighlighted];
        _forgetBtn.titleLabel.font = APP_FONT(12.0);
        
        [self addSubview:_forgetBtn];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
