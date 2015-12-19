//
//  FastMobileLoginFootView.m
//  YHInternational
//
//  Created by Holyjoy on 15/6/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "FastMobileLoginFootView.h"
 
@implementation FastMobileLoginFootView

- (void)awakeFromNib{

    [_fastMobileLoginOkBtn setBackgroundImage:[[UIImage imageNamed:@"RedBtn_normal"] stretchImage] forState:UIControlStateNormal];
    [_fastMobileLoginOkBtn setBackgroundImage:[[UIImage imageNamed:@"RedBtn_unable_2"] stretchImage] forState:UIControlStateDisabled];
    [_fastMobileLoginOkBtn setBackgroundImage:[[UIImage imageNamed:@"RedBtn_highlight"] stretchImage] forState:UIControlStateHighlighted];
}

- (IBAction)didOkBtn:(UIButton *)sender {
    
    /**
     *  @author holyjoy, 15-06-10 15:06:03
     *
     *  按钮tag 10/获取短信验证码 ，20/手机号快捷登录
     */
    if (sender.tag == 10) {
        if (_getAuthBtnBlock) {
            _getAuthBtnBlock();
        }
    }else{
        if (_okBtnBlock) {
            _okBtnBlock();
        }
    }
    
}


@end
