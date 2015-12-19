//
//  BBGLoadingTips.m
//  Common
//
//  Created by Damon on 15/5/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLoadingTips.h"
#import "BBGMacro.h"
#import "MBProgressHUD.h"

@interface BBGLoadingTips ()
@property (nonatomic, strong) MBProgressHUD * hud;
@end
@implementation BBGLoadingTips

DECLARE_SINGLETON(BBGLoadingTips)

-(void)showLoading:(NSString *)str{
    
    
    [_hud removeFromSuperview];
    _hud = nil;
    
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    
    _hud = [[MBProgressHUD alloc]initWithView:keyWindow];
    
    UIImageView *customImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading"]];
    customImgView.frame = CGRectMake(0, 0, 50, 50);
    
    _hud.customView = customImgView;
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.color = [UIColor clearColor];
    [keyWindow addSubview:_hud];
    
    [_hud show:YES];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 10000;
    [customImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

-(void)showTips:(NSString *)str{
    
    [_hud removeFromSuperview];
    _hud = nil;
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    _hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];

    _hud.mode = MBProgressHUDModeCustomView;
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 0;
   label.font = APP_FONT(17);
    label.textColor = [UIColor whiteColor];
    if (str.length > 0) {
        label.text = str;
        CGSize size =  [self sizeWithString:label.text font:label.font];
        label.frame = CGRectMake(0, 0, size.width, size.height);
        label.textAlignment = NSTextAlignmentCenter;
        _hud.customView = label;
        
        [keyWindow addSubview:_hud];
        
        [_hud show:YES];
        [self hideTips:[self displayDurationForString:label.text]];

        
    }else{
        [_hud hide:YES];
    }

    
    
    
    
}

- (void)showLoadingOnView:(UIView *)view{
    [self showLoadingOnView:view hideAfterTimeval:10000];
}

- (void)showLoadingOnView:(UIView *)view hideAfterTimeval:(NSTimeInterval)seconds{
    [_hud removeFromSuperview];
    _hud = nil;
    
    
    _hud = [[MBProgressHUD alloc] initWithView:view];
    _hud.removeFromSuperViewOnHide = YES;
    
    UIImageView *customImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading"]];
    customImgView.frame = CGRectMake(0, 0, 50, 50);
    
    _hud.customView = customImgView;
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.color = [UIColor clearColor];
    [view addSubview:_hud];
    
    [_hud show:YES];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 10000;
    [customImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    [_hud hide:YES afterDelay:seconds];
}

-(void)showLoadingCustomView:(UIImageView *)customImgView   withText:(NSString *)string  inBackgroundView:(UIView *)bgView withTime:(NSTimeInterval)tseconds
{
    
    
    [_hud removeFromSuperview];
    _hud = nil;
    _hud = [[MBProgressHUD alloc]initWithView:bgView];
    
    UIView *customView = [[UIView alloc]init];
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 0;
    label.font = APP_FONT(17);
    label.text = string;
    CGSize size =  [self sizeWithString:label.text font:label.font];
    label.frame = CGRectMake(0, 0, 50, size.height);
    label.textAlignment = NSTextAlignmentCenter;
    [customView addSubview:label];
    customImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading"]];
    customImgView.frame = CGRectMake(0, size.height, 50, 50);
    [customView addSubview:customImgView];
    customView.frame = CGRectMake(0, 0, 50, size.height+50);
    _hud.customView = customView;
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.color = [UIColor clearColor];
    [bgView addSubview:_hud];

    [_hud show:YES];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1000;
    [customImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//    _hud.removeFromSuperViewOnHide = YES;
//    [_hud hide:YES afterDelay:tseconds];
//    _hud = nil;
    
}
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(200, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
- (NSTimeInterval)displayDurationForString:(NSString*)string {
    return MIN((float)string.length*0.06 + 0.5, 3.0);
}

-(void)hideTips{
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES];
    _hud = nil;
}

-(void)hideTips:(NSTimeInterval)delay{
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES afterDelay:delay];
    _hud = nil;
}

- (void)dealloc{
    [_hud hide:YES afterDelay:0];
    [_hud removeFromSuperview];
    _hud = nil;
}

@end
