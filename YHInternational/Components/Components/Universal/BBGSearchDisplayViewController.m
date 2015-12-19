//
//  BBGSearchDisplayViewController.m
//  Components
//
//  Created by calvin on 14-8-27.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSearchDisplayViewController.h"

@interface BBGSearchDisplayViewController () <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id<UISearchBarDelegate> preDelegate;
@property (nonatomic, weak) id<UITableViewDataSource> preTableDataSource;
@property (nonatomic, weak) id<UITableViewDelegate> preTableDelegate;

@end

@implementation BBGSearchDisplayViewController
@synthesize searchResultsTableView = _searchResultsTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSearchBar:(BBGSearchBar *)searchBar contentsController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _searchBar = searchBar;
        _preDelegate = searchBar.delegate;
        _searchBar.delegate = self;
        _searchContentsController = viewController;
    }
    return self;
}

- (void)setSearchResultsDataSource:(id<UITableViewDataSource>)searchResultsDataSource {
    _searchResultsDataSource = searchResultsDataSource;
    _preTableDataSource = searchResultsDataSource;
    _searchResultsTableView.dataSource = self;
}

- (void)setSearchResultsDelegate:(id<UITableViewDelegate>)searchResultsDelegate {
    _searchResultsDelegate = searchResultsDelegate;
    _preTableDelegate = searchResultsDelegate;
    _searchResultsTableView.delegate = self;
}

- (IBAction)endEditingWhenBackgroundTapped:(id)sender {
    [self.searchBar endEditing:YES];
}

- (UITableView *)searchResultsTableView {
    if (!_searchResultsTableView) {
        _searchResultsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _searchResultsTableView.dataSource = self;
        _searchResultsTableView.delegate = self;
        _searchResultsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if ([_searchResultsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_searchResultsTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        [self.view addSubview:_searchResultsTableView];
    }
    return _searchResultsTableView;
}

- (void)dismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        self.view.alpha = 1.0;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingWhenBackgroundTapped:)];
    tapGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingWhenBackgroundTapped:)];
    panGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self.view addGestureRecognizer:panGestureRecognizer];
}

#pragma mark - UITableViewDataSource And UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_preTableDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 1;
    if ([_preTableDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        section = [_preTableDataSource numberOfSectionsInTableView:tableView];
    }
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_preTableDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_preTableDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismiss];
    if ([_preTableDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_preTableDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (_preDelegate && [_preDelegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [_preDelegate searchBarTextDidBeginEditing:searchBar];
    }
    self.view.frame = _searchContentsController.view.bounds;
    [_searchContentsController.view addSubview:self.view];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if (_searchResultsTableView) {
        
    }else{
        [self dismiss];
    }
    if (_preDelegate && [_preDelegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [_preDelegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (_preDelegate && [_preDelegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [_preDelegate searchBar:searchBar textDidChange:searchText];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (_preDelegate && [_preDelegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        [_preDelegate searchBarSearchButtonClicked:searchBar];
    }
}

#pragma mark - UIGestureRecognizerDelegate Methods
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    [self performSelector:@selector(endEditingWhenBackgroundTapped:) withObject:nil afterDelay:0.01];
    return ![gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] && [[gestureRecognizer class] isSubclassOfClass:[UIPanGestureRecognizer class]];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(endEditingWhenBackgroundTapped:) object:nil];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
