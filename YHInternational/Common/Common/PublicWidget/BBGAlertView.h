//
//  BBGAlertView.h
//  BBGAlertView
//
//  Created by yangjie on 15/4/21.
//  Copyright (c) 2015年 yangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGAlertView : UIView

/**
 *  初始化方法
 *
 *  @param title        标题文字
 *  @param message      提示文字信息
 *  @param block        回调
 *  @param buttonTitles 按钮文字
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithTitle:(NSString *)title
            message:(NSString *)message
            handler:(void (^)(BBGAlertView *alertView, NSInteger buttonIndex))block
       buttonTitles:(NSString *)buttonTitles ,... NS_REQUIRES_NIL_TERMINATION;


/**
 *  初始化方法
 *
 *  @param title        标题文字
 *  @param message      提示文字信息
 *  @param block        回调
 *  @param buttonTitles 按钮文字
 *
 *  @return <#return value description#>
 */
+ (instancetype)showWithTitle:(NSString *)title
            message:(NSString *)message
            handler:(void (^)(BBGAlertView *alertView, NSInteger buttonIndex))block
       buttonTitles:(NSString *)buttonTitles ,... NS_REQUIRES_NIL_TERMINATION;


/**
 *  显示BBGAlertView
 */
- (void)show;

@end
