//
//  BBGAdvView.h
//  TestAdvertisement
//
//  Created by calvin on 14-4-9.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBGAdvViewDataSource;
@protocol BBGAdvViewDelegate;

@interface BBGAdvView : UIView

@property (nonatomic, strong) UIView *currentView;

@property (nonatomic, strong, readonly) UIScrollView *loopScrollView;

@property(nonatomic, readonly) NSInteger numberOfPages;

@property(nonatomic, assign) NSInteger currentPage;
//焦点页码图片
@property(nonatomic, strong) UIImage *focusImage;
//普通页码图片
@property(nonatomic, strong) UIImage *pageImage;
@property(nonatomic, weak) id<BBGAdvViewDataSource> dataSource;
@property(nonatomic, weak) id<BBGAdvViewDelegate> delegate;
//设置页码显示的位置
@property(nonatomic, assign) UIEdgeInsets pageControlEdgeInsets;
//当只有一页时是否隐藏页码,默认为YES
@property(nonatomic, assign) BOOL hiddenPageControlWhenOnePage;
//是否允许自动滚动,默认为YES
@property(nonatomic, assign) BOOL enableAutoPage;


//重新加载数据
- (void)reloadData;
//返回对应页的视图
- (UIView *)viewForPage:(NSInteger)page;
//翻页
- (void)turnToPage:(NSInteger)page animated:(BOOL)animated;

@end

@protocol BBGAdvViewDataSource <NSObject>

@required
- (NSInteger)numberOfPagesInAdvView:(BBGAdvView *)advView;

- (UIView *)advView:(BBGAdvView *)advView viewForAdvViewAtPage:(NSInteger)page;

@optional
- (CGFloat)advView:(BBGAdvView *)advView heightForViewAtPage:(NSInteger)page;

@end

@protocol BBGAdvViewDelegate <NSObject>

@optional
- (void)advView:(BBGAdvView *)advView didSelectViewAtPage:(NSInteger)page;

- (void)advViewDidScroll:(BBGAdvView *)advView;

- (void)advViewWillBeginDragging:(BBGAdvView *)advView;

- (void)advViewDidEndDragging:(BBGAdvView *)advView willDecelerate:(BOOL)decelerate;

- (void)advViewWillBeginDecelerating:(BBGAdvView *)advView;

- (void)advViewDidEndDecelerating:(BBGAdvView *)advView;

- (void)advViewDidEndScrollingAnimation:(BBGAdvView *)advView;

@end