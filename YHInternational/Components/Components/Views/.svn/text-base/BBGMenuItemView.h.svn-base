//
//  BBGMenuItemView.h
//  BBGMenuNavigationView
//
//  Created by 程伟 on 13-10-10.
//  Copyright (c) 2013年 程伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGBadgeView.h"
@interface BBGMenuItemView : UIControl

/**
 *  菜单按钮文字
 */
@property(nonatomic, readonly, strong) UILabel *titleLabel;
/**
 *  菜单按钮选中时的颜色,默认为whiteColor
 */
@property(nonatomic, strong) UIColor *itemViewFoucusColor;
/**
 *  菜单按钮未选中时的颜色,默认为grayColor
 */
@property(nonatomic, strong) UIColor *itemViewCommonColor;
/**
 *  菜单按钮选中时的字体,默认为Bold 17 如果想要使title所占空间与控件大小相匹配,请调用sizeToFit方法
 */
@property(nonatomic, strong) UIFont *itemViewFocusFont;
/**
 *  菜单按钮未选中时的字体,默认为15
 */
@property(nonatomic, strong) UIFont *itemViewCommonFont;
/**
 *  小圆标 显示数量
 */
@property(nonatomic, strong) BBGBadgeView *badgeView;

@property(nonatomic, assign) NSInteger badgeCount;
/**
 *  彩单选中图片
 */
@property(nonatomic, strong) UIImageView *backgroundView;

- (id)initWithFrame:(CGRect)frame itemTitle:(NSString *)title;

- (void)select:(BOOL)selected Animated:(BOOL)animated;

@end
