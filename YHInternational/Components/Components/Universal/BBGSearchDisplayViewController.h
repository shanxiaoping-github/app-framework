//
//  BBGSearchDisplayViewController.h
//  Components
//
//  Created by calvin on 14-8-27.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSearchBar.h"

@class BBGSearchDisplayViewController;

@protocol BBGSearchDisplayDelegate <NSObject>

@optional
- (void)searchDisplayControllerCanceled:(BBGSearchDisplayViewController *)searchDisplayController;

@end

@interface BBGSearchDisplayViewController : UIViewController

@property (nonatomic, readonly) BBGSearchBar *searchBar;
@property (nonatomic, weak, readonly) UIViewController *searchContentsController;
@property (nonatomic, weak) id<BBGSearchDisplayDelegate> delegate;
@property(nonatomic, readonly) UITableView  *searchResultsTableView;
@property(nonatomic, weak) id<UITableViewDataSource> searchResultsDataSource;
@property(nonatomic, weak) id<UITableViewDelegate> searchResultsDelegate;

- (id)initWithSearchBar:(BBGSearchBar *)searchBar contentsController:(UIViewController *)viewController;

@end
