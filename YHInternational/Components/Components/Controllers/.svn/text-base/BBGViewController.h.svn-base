//
//  BBGViewController.h
//  Components
//
//  Created by Damon on 15/4/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

#import "BBGSearchDisplayViewController.h"
#import "BBGDefaultView.h"
#import "BBGComponents.h"

typedef enum {
    BBGResponseSuccess =0,
    BBGResponseNetError,//网络错误 或者超时
    BBGResponseNotData,//服务器返回无数据
    BBGResponseError  //解析时错误 或者返回数据格式错误
}BBGResponseResult;

typedef NS_ENUM(NSInteger, BBGDataLoadType) {
    //刷新数据
    BBGDataLoadRefresh =0,
    //加载更多
    BBGDataLoadMore
};
typedef void (^goSettleMent) (BOOL sucessful);

typedef void (^LoadDataCallback) (BOOL sucessful, BBGResponse *response);

typedef void (^RequestDataCallback) (BOOL sucessful, NSDictionary *responseDict);

@interface BBGViewController : UIViewController

@property (nonatomic, strong) BBGResponse *response;
@property (nonatomic, strong, readonly) BBGSearchDisplayViewController *searchDisplayViewController;
@property (nonatomic, strong) BBGDefaultView *defaultView;
@property (nonatomic, assign) BBGDataLoadType dataLoadType;

@property (nonatomic, strong) UIImage * leftImage;

@property (nonatomic, assign) BOOL isMainViewController;

@property (nonatomic, assign) BOOL isFrom3DTouch;

/*!
 * 联系客服
 */
- (void)connectServer;
/*!
 *  重写此方法可以获取到dismisss程序后的Action
 */
- (void)dismissViewController;

/**
 *  更新数据
 */
- (void)updateData:(LoadDataCallback)callback;

/*!
 * 联系客服
 */
- (void)connectServer;

/**
 *  用于显示加载数据各种情况的默认页面
 *
 *  @param image       显示的图片，传入空值则会根据result来显示不同的默认图片
 *  @param tips        相关信息提示
 *  @param target      触发方法的target
 *  @param actionTitle 触发方法按钮的标题
 *  @param action      触发的方法
 *  @param result      加载数据的结果
 */
- (void)showDefaultViewWithStampImage:(UIImage *)image
                                 tips:(NSString *)tips
                               target:(id)target
                          actionTitle:(NSString *)actionTitle
                               action:(SEL)action
                   WithResponseResult:(BBGResponseResult)result;

/**
 *  用于显示加载数据各种情况的默认页面
 *
 *  @param image       显示的图片，传入空值则会根据result来显示不同的默认图片
 *  @param tips        相关信息提示
 *  @param target      触发方法的target
 *  @param actionTitle 触发方法按钮的标题
 *  @param action      触发的方法
 *  @param result      加载数据的结果
 *  @param offset      默认页位移
 */
- (void)showDefaultViewWithStampImage:(UIImage *)image
                                 tips:(NSString *)tips
                               target:(id)target
                          actionTitle:(NSString *)actionTitle
                               action:(SEL)action
                   WithResponseResult:(BBGResponseResult)result
                               offset:(CGPoint)offset;

/**
 *  用于显示加载数据各种情况的默认页面
 *
 *  @param image       显示的图片，传入空值则会根据result来显示不同的默认图片
 *  @param tips        相关信息提示
 *  @param target      触发方法的target
 *  @param actionTitle 触发方法按钮的标题
 *  @param action      触发的方法
 *  @param result      加载数据的结果
 *  @param offset      默认页位移
 *  @param view        用来add defaultView的view
 */
- (void)showDefaultViewWithStampImage:(UIImage *)image
                                 tips:(NSString *)tips
                               target:(id)target
                          actionTitle:(NSString *)actionTitle
                               action:(SEL)action
                   WithResponseResult:(BBGResponseResult)result
                               offset:(CGPoint)offset
                               onView:(UIView *)view;




- (void)showAlertViewWithTips:(NSString *)tips
                       target:(id)target
                       action:(SEL)action
           WithResponseResult:(BBGResponseResult)result;




- (void)dismissDefaultView;


/**
 *  创建导航栏右按钮
 *
 *  @param target target
 *  @param action 按钮触发的方法
 *  @param nImage 默认图片
 *  @param hImage 按下图片
 */
- (UIButton *)createRightBarButtonItemWithTarget:(id)target
                                    action:(SEL)action
                               normalImage:(UIImage *)nImage
                          highlightedImage:(UIImage *)hImage;
- (UIButton *)createRightBarButtonItemWithTarget:(id)target
                                    action:(SEL)action
                                     title:(NSString *)title;
- (UIButton *)createRightBarButtonItemWithTarget:(id)target
                                          action:(SEL)action
                                           title:(NSString *)title titleColor:(UIColor *)titleColor;

- (UIButton *)createLeftBarButtonItemWithTarget:(id)target action:(SEL)action normalImage:(UIImage *)nImage highlightedImage:(UIImage *)hImage;
- (UIButton *)createLeftBarButtonItemWithTarget:(id)target
                                    action:(SEL)action
                                     title:(NSString *)title;
/**
 *  创建BarButtonItem;如果title不为空，则创建文字item，否则就需要传入image，创建图片item(title和nImage必选其一)
 *
 *  @param target target
 *  @param action 按钮触发的方法
 *  @param title 文字按钮标题
 *  @param titleColor 标题颜色
 *  @param nImage 默认图片
 *  @param hImage 按下图片
 */
- (UIBarButtonItem *)createBarButtonItemWithTarget:(id)target
                                            action:(SEL)action
                                             title:(NSString *)title
                                        titleColor:(UIColor *)titleColor
                                       normalImage:(UIImage *)nImage
                                  highlightedImage:(UIImage *)hImage;

/**
 *  创建BarButtonItem;如果title不为空，则创建文字item，否则就需要传入image，创建图片item
 *
 *  @param target target
 *  @param action 按钮触发的方法
 *  @param width 宽度
 */
- (UIBarButtonItem *)createFlexSpacerBarButtonItemWithTarget:(id)target
                                                      action:(SEL)action
                                                       width:(CGFloat)width;
 

@end

