//
//  SXPViewController.h
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/7/15.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

/*基本UIviewController*/
#import <UIKit/UIKit.h>
@interface SXPViewController : UIViewController
//显示菊花条位置默认位置，一般为屏幕中央
-(void)showIndicatorView;
//显示菊花条指定位置
-(void)showIndicatorViewPointX:(CGFloat)x pointY:(CGFloat)y;
//隐藏菊花条
-(void)stopIndicatorView;
@end
