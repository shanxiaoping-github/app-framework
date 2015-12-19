//
//  BBGMenuNavigationView.h
//  BBGMenuNavigationView
//
//  Created by 程伟 on 13-10-10.
//  Copyright (c) 2013年 程伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGMenuItemView.h"

@protocol BBGMenuNavigationViewDataSource;
@protocol BBGMenuNavigationViewDelegate;

@interface BBGMenuNavigationView : UIView <UIScrollViewDelegate>

@property(nonatomic, assign) id <BBGMenuNavigationViewDataSource> dataSource;
@property(nonatomic, assign) id <BBGMenuNavigationViewDelegate> delegate;
/**
 *  分隔的图片
 */
@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, readonly, assign) NSInteger numberOfItems;
@property(nonatomic, readonly, assign) NSInteger currentSelectItemIndex;
/**
 *  导航按钮的起始位置,默认是0
 */
@property(nonatomic, assign) CGFloat itemBeginSpace;

- (BBGMenuItemView *)menuItemViewOfMenuNavigationViewAtIndex:(NSInteger)index;

- (void)selectItemAtIndex:(NSInteger)index animated:(BOOL)animated;

- (void)selectItemAtIndex:(NSInteger)index;

- (void)reloadData;

- (void)reloadDataWithItemIndex:(NSInteger)itemIndex;
@end

@protocol BBGMenuNavigationViewDataSource <NSObject>

@required
/**
 *  按钮的总个数
 *
 *  @param menuNavigationView 导航栏
 *
 *  @return 按钮的总个数
 */
- (NSInteger)numberOfItemsInMenuNavigationView:(BBGMenuNavigationView *)menuNavigationView;

/**
 *  获取每个按钮
 *
 *  @param menuNavigationView 导航栏
 *  @param index              导航栏按钮下标
 *
 *  @return 导航栏按钮
 */
- (BBGMenuItemView *)menuNavigationView:(BBGMenuNavigationView *)menuNavigationView itemForMenuNavigationViewAtIndex:(NSInteger)index;

@optional
/**
 *  按钮与按钮之间的间隔
 *
 *  @param menuNavigationView 导航栏
 *  @param index              导航栏按钮下标
 *
 *  @return 按钮与按钮之间的间隔
 */
- (CGFloat)menuNavigationView:(BBGMenuNavigationView *)menuNavigationView spaceForItemAtIndex:(NSInteger)index;

@end

@protocol BBGMenuNavigationViewDelegate <NSObject>

@optional
- (void)menuNavigationView:(BBGMenuNavigationView *)menuNavigationView didSelectItemAtIndex:(NSInteger)index animated:(BOOL)animated;

@end