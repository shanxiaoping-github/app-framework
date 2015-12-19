//
//  BBGPullTable.h
//  Components
//
//  Created by Damon on 15/4/29.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVPullToRefresh.h"

typedef void (^RefreshBlock)(id data);

@protocol PullDelegate <NSObject,UITableViewDelegate>
/*!
 *  预留方法
 */
@optional
- (UITableViewCell *)tableView:(UITableView *)tableView headerView:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView footerView:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightOfHeaderView:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(UITableView *)tableView heightOfFooterView:(NSIndexPath *)indexPath;

- (void)didSelectedHeaderFooterView:(NSIndexPath *)indexPath;

@end

@interface BBGPullTable : UITableView

@property (nonatomic, assign) BOOL openDeleteCell;

@property (nonatomic, assign) BOOL notOpenSticky;

@property (nonatomic,weak) id<PullDelegate> pullDelegate;

- (void)loadMore:(RefreshBlock)block;
- (void)refreshData:(RefreshBlock)block;

- (void)stopAnimation;
- (void)stopAnimationWithCompletion:(void (^)(void))actionHandler;
@end
