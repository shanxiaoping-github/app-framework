//
//  BBGChannelViewController.h
//  Components
//
//  Created by elvis.peng on 14-8-26.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGContentProtocol.h"
#import "BBGMenuItem.h"
@interface BBGChannelViewController : BBGViewController

@property (nonatomic,readonly,strong) NSArray *menus;
/**
 *  当前显示内容对应的菜单下标
 */
@property (nonatomic, assign) NSInteger currentMenuIndex;

- (id)initWithMenus:(NSArray *)menus;

- (UIViewController<BBGContentProtocol> *)buildContentByMenuItem:(BBGMenuItem *)item;
- (id)loadCustomDataWithMenu:(BBGMenuItem *)menu;
- (UINavigationController *)contentViewController;

- (void)loadSubPageContentAtIndex:(NSInteger)index;
/**
 *  根据菜单索引返回对应页面对象
 *
 *  @param index 菜单索引
 *
 *  @return 页面对象
 */
-(UIViewController *)viewControllerWithMenuIndex:(NSInteger) index;
/**
 *  是否显示数量图标
 *
 *  @param menu 菜单
 *
 *  @return 是否显示
 */
- (BOOL)isShowBadgeWithMenu:(BBGMenuItem *)menu;
- (NSInteger)badgeCountWithMenu:(BBGMenuItem *)menu;
/**
 *  刷新菜单
 */
- (void)reloadMenuView;
- (void)goToMenuAtIndex:(NSInteger)index animated:(BOOL)animated;

/**
 *  传递事件
 */
- (void)touchEventWithEventId:(id)sender;
@end
