//
//  ViewUtil.h
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/8/21.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ViewUtil : NSObject
/*
 *返回buttonitem image形式的
 */
+(UIBarButtonItem*)getButtonItemWithImage:(UIImage*)image frame:(CGRect)frame target:(id)target sel:(SEL)sel;
/*
 *返回buttonitem title形式的
 */
+(UIBarButtonItem*)getButtonItemWithTitle:(NSString*)title font:(UIFont*)font color:(UIColor*)color frame:(CGRect)frame target:(id)target sel:(SEL)sel;
/*uicolor 转为 uiimage*/
+(UIImage*)UIColorTransferUIImage:(UIColor*)color rect:(CGRect)rect;
/*为view添加手势动作*/
+(void)registerGestures:(UIView*)view target:(id)target action:(SEL)action;
@end
