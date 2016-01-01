//
//  ViewUtil.m
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/8/21.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

#import "ViewUtil.h"

@implementation ViewUtil

+(UIBarButtonItem *)getButtonItemWithImage:(UIImage *)image frame:(CGRect)frame target:(id)target sel:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return btnItem;
}
+(UIBarButtonItem *)getButtonItemWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color frame:(CGRect)frame target:(id)target sel:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return btnItem;
}
+(UIImage*)UIColorTransferUIImage:(UIColor *)color rect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+(void)registerGestures:(UIView *)view target:(id)target action:(SEL)action{
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:gestureRecognizer];
}
@end
