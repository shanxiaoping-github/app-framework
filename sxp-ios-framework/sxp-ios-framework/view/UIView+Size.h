//
//  UIView+Size.h
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/9/14.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//
/*
 *计算UIView的size
 */
#import <UIKit/UIKit.h>
//水平
#define HORIZONTAL 0
//垂直
#define VERTICAL 1

typedef NS_ENUM(NSInteger,NSDisplay){
    NSDisplayVisible = 1,
    NSDisplayInVisible = 1 << 1,
    NSDisplayGone = 1 << 2
};
@interface UIView (Size)
-(CGFloat)right;
-(CGFloat)left;
-(CGFloat)top;
-(CGFloat)bottom;
-(CGFloat)width;
-(CGFloat)height;

-(void)setVisible:(NSDisplay)visible orientation:(NSInteger)orientation;
-(void)setVisible:(NSDisplay)visible;
-(NSDisplay)visible;
@end


