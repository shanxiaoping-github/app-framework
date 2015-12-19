//
//  BBGTableView.h
//  BBGCustomTableView
//
//  Created by 程伟 on 13-10-16.
//  Copyright (c) 2013年 程伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVPullToRefresh.h"

typedef enum {
    BBGTableViewCellSeparatorStyleNone = 1,   //行与行间无分隔
    BBGTableViewCellSeparatorStyleSolid = 2,  //行与行间用实线分隔
    BBGTableViewCellSeparatorStyleDashed = 3, //行与行间用虚线分隔
} BBGTableViewCellSeparatorStyle;

typedef NS_ENUM(NSInteger, BBGTableViewStyle) {
    BBGTableViewStylePlain,                  // regular table view
    BBGTableViewStyleGrouped                 // preferences style table view
};

typedef NS_ENUM(NSInteger, BBGTableViewRowAnimation) {
    BBGTableViewRowAnimationFade,
    BBGTableViewRowAnimationRight,           // slide in from right (or out to right)
    BBGTableViewRowAnimationLeft,
    BBGTableViewRowAnimationTop,
    BBGTableViewRowAnimationBottom,
    BBGTableViewRowAnimationNone,            // available in iOS 3.0
    BBGTableViewRowAnimationMiddle,          // available in iOS 3.2.  attempts to keep cell centered in the space it will/did occupy
    BBGTableViewRowAnimationAutomatic = 100  // available in iOS 5.0.  chooses an appropriate animation style for you
};

@interface BBGTableViewCell : UITableViewCell

//是否需要背景图片默认为YES
@property(nonatomic, assign) BOOL needBackground;

@end

@protocol BBGTableViewDataSource;
@protocol BBGTableViewDelegate;

@interface BBGTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIImage *backgoundImage;
@property(nonatomic, strong) UIView *tableHeaderView;
@property(nonatomic, strong) UIView *tableFooterView;
@property(nonatomic, weak) id <BBGTableViewDataSource> dataSource;
@property(nonatomic, weak) id <BBGTableViewDelegate> delegate;
//tableView行与行间的分隔线,可以是实线,可以是虚线,或是无分隔线 默认为实线BBGTableViewCellSeparatorStyleSolid
@property(nonatomic, assign) BBGTableViewCellSeparatorStyle separatorStyle;
//tableView行与行间分隔线的颜色 默认为浅灰色[UIColor colorWithRed:224.0 / 255.0 green:224.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
@property(nonatomic, strong) UIColor *separatorColor;
@property(nonatomic, assign) CGPoint contentOffSet;
@property(nonatomic, assign) CGSize contentSize;
@property(nonatomic, assign) CGFloat rowHeight;
@property(nonatomic,getter=isScrollEnabled) BOOL scrollEnabled;
@property(nonatomic, assign) BOOL bounces;
@property(nonatomic, assign) UIEdgeInsets edgeInset;
//separator inset, when separator style is solid or dash, it will work.
@property(nonatomic, assign) UIEdgeInsets separatorInset;

- (id)initWithFrame:(CGRect)frame style:(BBGTableViewStyle)style backgoundImage:(UIImage *)image notAutoSizeMask:(BOOL)notAuto;

- (id)initWithFrame:(CGRect)frame style:(BBGTableViewStyle)style backgoundImage:(UIImage *)image;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

//重新加载数据
- (void)reloadData;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGRect)rectForSection:(NSInteger)section;

- (CGRect)rectForHeaderInSection:(NSInteger)section;

- (CGRect)rectForFooterInSection:(NSInteger)section;

- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;

- (NSIndexPath *)indexPathForCell:(BBGTableViewCell *)cell;

- (NSArray *)indexPathsForRowsInRect:(CGRect)rect;

- (BBGTableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)visibleCells;

- (NSArray *)indexPathsForVisibleRows;

- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(BBGTableViewRowAnimation)animation;

- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(BBGTableViewRowAnimation)animation;

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(BBGTableViewRowAnimation)animation;

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(BBGTableViewRowAnimation)animation;

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(BBGTableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated;

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

@end

@protocol BBGTableViewDataSource <NSObject>

@required

- (NSInteger)tableView:(BBGTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (BBGTableViewCell *)tableView:(BBGTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInTableView:(BBGTableView *)tableView;

- (NSString *)tableView:(BBGTableView *)tableView titleForHeaderInSection:(NSInteger)section;

- (NSString *)tableView:(BBGTableView *)tableView titleForFooterInSection:(NSInteger)section;

@end

@protocol BBGTableViewDelegate <NSObject>

@optional

- (CGFloat)tableView:(BBGTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(BBGTableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(BBGTableView *)tableView heightForFooterInSection:(NSInteger)section;

- (UIView *)tableView:(BBGTableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (UIView *)tableView:(BBGTableView *)tableView viewForFooterInSection:(NSInteger)section;

- (void)tableView:(BBGTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)scrollViewDidScroll:(BBGTableView *)scrollView;

- (void)scrollViewWillBeginDragging:(BBGTableView *)scrollView;

- (void)scrollViewDidEndDragging:(BBGTableView *)scrollView willDecelerate:(BOOL)decelerate;

- (void)scrollViewWillBeginDecelerating:(BBGTableView *)scrollView;

- (void)scrollViewDidEndDecelerating:(BBGTableView *)scrollView;

- (void)scrollViewDidEndScrollingAnimation:(BBGTableView *)scrollView;

- (BOOL)scrollViewShouldScrollToTop:(BBGTableView *)scrollView;

- (void)scrollViewDidScrollToTop:(BBGTableView *)scrollView;

@end