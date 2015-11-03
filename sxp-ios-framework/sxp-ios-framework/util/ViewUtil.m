//
//  ViewUtil.m
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/8/21.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

#import "ViewUtil.h"

@implementation ViewUtil

+(UIBarButtonItem *)getBackButtonItemWithImage:(UIImage *)image frame:(CGRect)frame target:(id)target sel:(SEL)sel{
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = frame;
    [leftbtn setImage:image forState:UIControlStateNormal];
    [leftbtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    return leftItem;
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
@end
