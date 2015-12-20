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
/*菊花圆圈*/
-(void)showIndicatorView;
-(void)showIndicatorViewPointX:(CGFloat)x pointY:(CGFloat)y;
-(void)stopIndicatorView;

/*提示*/
-(void)showMessage:(NSString*)message;
-(void)showLoadDialog:(NSString*)message;
-(void)stopLoadDialog;

/*导航栏颜色,子类重写*/
-(UIColor*)navigationColor;
@end
