//
//  BBGGoodsListViewController_iPhone.m
//  YHInternational
//
//  Created by Timmy Ouyang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsListViewController_iPhone.h"
#import "BBGSearchViewController_iPhone.h"
#import "BBGGoodsListCell_iPhone.h"
#import "BBGGoodsListFilterView_iPhone.h"
#import "UIView+Animations.h"
#import "BBGSecondsKillProduct.h"
#import "UIViewController+SlideMenu.h"
#import "BBGGoodsCategoryViewController_iPhone.h"
#import "BBGSearchViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGGoodsCategoryViewController_iPhone.h"
#import "BBGPullTable.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGCategory.h"
#import "BBGPopAnimator.h"
#import "BBGGoodsPushAnimator.h"
#import "BBGShoppingCartViewController_iPhone.h"
#import "BBGShoppingCartViewController_iPhone.h"
#import "BBGAddCartAnimation.h"
#import "BBGPushAnimator.h"
#import "BBGGroupGoodsListCell.h"
#import "BBGSettlementViewController_iPhone.h"

#define MENU_SHADOW_RADIUS 5
#define MENU_SHADOW_OPACITY 1

@interface BBGGoodsListViewController_iPhone ()<BBGSearchViewDelegate,UITableViewDataSource,UITableViewDelegate,GoodsListCellDelegate,BBGGoodsListFilterViewDelegate,UISearchBarDelegate,BBGSearchViewDelegate,BBGGoodsFilterDelegate,BBGAddCartAnimationDelegate>

@property (assign, nonatomic) NSInteger currentDisplayCellIndex;
@property (assign, nonatomic) NSInteger currentDisplaySectionIndex;
@property (weak, nonatomic) IBOutlet BBGPullTable *tableView;
@property (nonatomic, strong) BBGSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet BBGGoodsListFilterView_iPhone *filterView;
@property (nonatomic, strong) BBGGoodsCategoryViewController_iPhone *categoryController;
/**
 *  购物车动画类
 */
@property (nonatomic, strong) BBGAddCartAnimation *addCartAnimation;
@property (nonatomic, strong) UIImageView *cartImage;
/**
 *  判断是否正在执行购物车动画
 */
@property (nonatomic, assign) BOOL isAnimation;

@property (nonatomic, strong) UIView *matteView;

@property (weak, nonatomic) IBOutlet UIButton *addCartButton;

@property (assign, nonatomic) CGPoint contentOff;

@property (assign, nonatomic) BOOL isBarHidden;

@property (assign, nonatomic) BOOL isBottomBarHidden;
//去结算按钮
@property (weak, nonatomic) IBOutlet UIButton *toSettlementButton;
//底部barView购物车数量提示标签
@property (weak, nonatomic) IBOutlet UILabel *cartCountLabel;
//底部barView
@property (weak, nonatomic) IBOutlet UIView *bottomBarView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterViewTopFromSuperViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopFromSuperViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomFromSuperViewConstraint;
@end

@implementation BBGGoodsListViewController_iPhone
//-(void)loadView{
//    [super loadView];
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.sourceViewController==BBGPhoneRecommendController) {
        self.tableViewTopFromSuperViewConstraint.constant = 0;
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = self.title;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"0" forKey:@"choose"];
    //设置底部bar数量
    [self SetBottomAmount];
    
    if (self.sourceViewController == BBGSearchController) {
        [self loadSearchResultsData];
    }else if (self.sourceViewController == BBGPhoneExtraController) {
        [self loadPhoneExtraData];
    }else if (self.sourceViewController == BBGPhoneRecommendController){
        [self loadPhoneRecommend];
    }
    
    self.toSettlementButton.layer.masksToBounds = YES;
    self.toSettlementButton.layer.cornerRadius = 3.0;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTheAdView) name:@"imageCompleted" object:nil];
    
}

- (void)removeTheAdView{
    [[BBGJumpManager sharedInstance].animationView removeFromSuperview];
    [BBGJumpManager sharedInstance].animationView = nil;
}

- (void)loadSearchResultsData {
    
    [self createLeftBarButtonItemWithTarget:self action:@selector(backUp) normalImage:[UIImage imageNamed:@"Cancel"] highlightedImage:[UIImage imageNamed:@"Cancel"]];
    _searchBar = [[BBGSearchBar alloc] initWithFrame:CGRectMake(0, 0, 2000, 35)];
    _searchBar.delegate = self;
    if ([BBGTools checkStringIsBlank:[BBGLaunchManager sharedInstance].searchText]) {
        _searchBar.placeholder = @"购全球，上云猴";
    }else{
        _searchBar.placeholder = [BBGLaunchManager sharedInstance].searchText;
        if (![BBGTools checkStringIsBlank:self.keyword]) {
            _searchBar.placeholder = self.keyword;
        }
    }
    self.navigationItem.titleView = _searchBar;
    [self createRightBarButtonItemWithTarget:self action:@selector(openMenu) title:@"筛选" titleColor:UIColorFromHexadecimalRGB(0xf34568)];
    
    self.isMainViewController = YES;
    self.showHaveStoreOnly = NO;
    __weak BBGGoodsListViewController_iPhone *weakSelf = self;
    
    [self.tableView refreshData:^(id data) {
        weakSelf.page = 1;
        weakSelf.dataLoadType = BBGDataLoadRefresh;
        [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
            [_tableView stopAnimationWithCompletion:^{
                if (sucessful) {
                    [weakSelf.tableView reloadData];
                    weakSelf.nowRows=weakSelf.products.count;
                    weakSelf.tableView.showsInfiniteScrolling = weakSelf.canLoadMore;
                    [weakSelf dismissDefaultView];
                    
                    //添加引导
                    [self addGuide];
                }else {
                    [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"Search_blank"]  tips:@"没有相关商品..." target:self actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:CGPointMake(0, 0) onView:self.view];
                }
            }];
            
        }];
    }];
    
    [self.tableView loadMore:^(id data) {
        
        weakSelf.page ++;
        weakSelf.dataLoadType = BBGDataLoadMore;
        [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {

            [weakSelf.tableView stopAnimationWithCompletion:^{
                if (sucessful) {
                    NSMutableArray *insertArray=[[NSMutableArray alloc]init];
                    for (NSInteger i=weakSelf.nowRows; i<weakSelf.products.count; i++) {
                        [insertArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                    }
                    if (insertArray.count > 0) {
                        [weakSelf.tableView beginUpdates];
                        [weakSelf.tableView insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationAutomatic];
                        [weakSelf.tableView endUpdates];
                    }
                    weakSelf.nowRows=weakSelf.products.count;
                }
                weakSelf.tableView.showsInfiniteScrolling = weakSelf.canLoadMore;
                [[BBGLoadingTips sharedInstance] hideTips];
             }];
            
        }];
    }];

    [self.tableView triggerPullToRefresh];

}

- (void)loadPhoneExtraData {

    __weak BBGGoodsListViewController_iPhone *weakSelf = self;
    [self.tableView refreshData:^(id data) {
        weakSelf.page = 1;
        weakSelf.dataLoadType = BBGDataLoadRefresh;
        [weakSelf loadPhoneExtra:^(BOOL sucessful, BBGResponse *response) {
            [_tableView stopAnimationWithCompletion:^{
                if (sucessful) {
                    [_tableView reloadData];
                    weakSelf.nowRows=weakSelf.products.count;
                    weakSelf.tableView.showsInfiniteScrolling = weakSelf.canLoadMore;
                    [weakSelf dismissDefaultView];
                    //添加引导
                    [self addGuide];
                }else {
                    [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"ExclusiveMobile phone"]  tips:@"新的手机专享正在筹备中，请期待..." target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:CGPointMake(0, 0) onView:self.view];
                }
            }];
            [[BBGLoadingTips sharedInstance] hideTips];

        }];
    }];
    
    [self.tableView loadMore:^(id data) {
        weakSelf.page ++;
        weakSelf.dataLoadType = BBGDataLoadMore;
        [weakSelf loadPhoneExtra:^(BOOL sucessful, BBGResponse *response) {
            [_tableView stopAnimationWithCompletion:^{
                if (sucessful) {
                    NSMutableArray *insertArray=[[NSMutableArray alloc]init];
                    for (NSInteger i=weakSelf.nowRows; i<weakSelf.products.count; i++) {
                        [insertArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                    }
                    if (insertArray.count>0) {
                        [weakSelf.tableView beginUpdates];
                        [weakSelf.tableView insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationAutomatic];
                        [weakSelf.tableView endUpdates];
                    }
                    weakSelf.nowRows=weakSelf.products.count;
                    
                }
                weakSelf.tableView.showsInfiniteScrolling = weakSelf.canLoadMore;
                [[BBGLoadingTips sharedInstance] hideTips];
                
            }];

        }];
    }];
    [self.tableView triggerPullToRefresh];

}

- (void)loadPhoneRecommend{
    
    __weak BBGGoodsListViewController_iPhone *weakSelf = self;
    [self.tableView refreshData:^(id data) {
        weakSelf.page = 1;
        weakSelf.dataLoadType = BBGDataLoadRefresh;
        [weakSelf loadPhoneRequest:^(BOOL sucessful, BBGResponse *response) {
            [_tableView stopAnimationWithCompletion:^{
                if (sucessful) {
                    [_tableView reloadData];
                    weakSelf.nowRows=weakSelf.products.count;
                    weakSelf.tableView.showsInfiniteScrolling = weakSelf.canLoadMore;
                    [weakSelf dismissDefaultView];
                    //添加引导
                    [self addGuide];
                }else {
                    [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"ExclusiveMobile phone"]  tips:@"一大波新品即将上架，敬请期待..." target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:CGPointMake(0, 0) onView:self.view];
                }
            }];
            [[BBGLoadingTips sharedInstance] hideTips];
            
        }];
    }];
    
    [self.tableView loadMore:^(id data) {
        weakSelf.page ++;
        weakSelf.dataLoadType = BBGDataLoadMore;
        [weakSelf loadPhoneRequest:^(BOOL sucessful, BBGResponse *response) {
            [_tableView stopAnimationWithCompletion:^{
                if (sucessful) {
                    NSMutableArray *insertArray=[[NSMutableArray alloc]init];
                    for (NSInteger i=weakSelf.nowRows; i<weakSelf.products.count; i++) {
                        [insertArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                    }
                    if (insertArray.count>0) {
                        [weakSelf.tableView beginUpdates];
                        [weakSelf.tableView insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationAutomatic];
                        [weakSelf.tableView endUpdates];
                    }
                    weakSelf.nowRows=weakSelf.products.count;
                }
                weakSelf.tableView.showsInfiniteScrolling = weakSelf.canLoadMore;
                [[BBGLoadingTips sharedInstance] hideTips];
                
            }];
        }];
    }];
    [self.tableView triggerPullToRefresh];

}

- (UIButton *)createRightBarButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor {
    
    CGSize defaultSize = CGSizeMake(40, 44);
    UIFont *font = APP_FONT(15);
    CGSize titleSize = [title sizeWithStringFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    titleSize.width = titleSize.width < defaultSize.width ? defaultSize.width : titleSize.width + 10;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    button.titleLabel.font = font;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    return button;
    
}


- (void)openMenu {
    
    if (!self.menuViewController) {
        BBGGoodsCategoryViewController_iPhone *categoryController = [[BBGGoodsCategoryViewController_iPhone alloc] init];
        categoryController.filterAttributes = self.filterAttributes;
        categoryController.delegate = self;
        categoryController.fcate = self.fCate;
        categoryController.keywords = self.keyword;
        _categoryController = categoryController;
        BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:categoryController];
        self.menuViewController = nav;
    }

    //重置筛选条件
    [self slideMenuViewController:self.menuViewController animationDuration:0.3 slideTyep:TMSlideTypeLeft completion:^(BOOL finished) {
        
    }];

}

- (IBAction)toCart:(UIButton *)sender {
    [BBGSessionManager sharedInstance].currentViewController = self;
    if ([BBGSessionManager sharedInstance].isLogin) {
        BBGShoppingCartViewController_iPhone *shopCartVC = [[BBGShoppingCartViewController_iPhone alloc]init] ;
        [self.navigationController pushViewController:shopCartVC animated:YES] ;

    }else {
    [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
        if (successful) {
            BBGShoppingCartViewController_iPhone *shopCartVC = [[BBGShoppingCartViewController_iPhone alloc]init] ;
            [self.navigationController pushViewController:shopCartVC animated:YES] ;

        }
    }];
    }
}

- (void)backUp {
    [self dismissViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
    
    //更新下方bar的数量
    [self SetBottomAmount];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[BBGGoodsDetailViewController_iPhone class]]) {
        if (operation == UINavigationControllerOperationPush) {
            BBGGoodsPushAnimator * animator = [[BBGGoodsPushAnimator alloc]init];
            return animator;
        }
    }else{
        if (operation == UINavigationControllerOperationPush) {
            BBGPushAnimator * pushAnimator = [[BBGPushAnimator alloc] init];
            return pushAnimator;
        }
    }
    
    if (operation == UINavigationControllerOperationPop) {
        BBGPopAnimator * animator = [[BBGPopAnimator alloc]init];
        return animator;
    }
    return nil;
}

#pragma mark-BBGGoodsFilterDelegate
- (void)clearFilterItem {
    
    self.categoryID = nil;
    self.brandIDs = nil;
    self.facetProps = nil;
    self.facetSpec = nil;
    self.minPrice = -1;
    self.maxPrice = -1;
    self.page = 1;
}

- (void)categoryController:(BBGGoodsCategoryViewController_iPhone *)catController allFilters:(NSDictionary *)filters hasStore:(BOOL)hasStore isProprietary:(BOOL)isProprietary {
    
    if (!filters) {
        [self clearFilterItem];
        self.showHaveStoreOnly = hasStore;
        self.showProprietaryOnly = isProprietary;
    }else {
        
        //分类信息
        BBGCategory *catFilter = [filters objectForKey:@"分类"];
        if (catFilter) {
            self.categoryID = catFilter.catId;
        }else {
            self.categoryID = nil;
        }
        
        //价格信息
        BBGCategory *priceFilter = [filters objectForKey:@"价格"];
        if (priceFilter) {
            self.minPrice = priceFilter.minPrice;
            self.maxPrice = priceFilter.maxPrice;
        }else {
            //清除价格筛选条件，和服务端约定传”-1“
            self.minPrice = -1;
            self.maxPrice = -1;
        }

        //品牌条件
        NSArray *brandsArray = [filters objectForKey:@"品牌"];
        if (brandsArray) {
            if (brandsArray.count>0) {
                NSMutableArray *results = [NSMutableArray array];
                for (int i = 0; i<brandsArray.count; i++) {
                    BBGCategory *cat = [brandsArray objectAtIndex:i];
                    [results addObject:cat.catId];
                }
                NSString *str = [results componentsJoinedByString:@"|"];
                self.brandIDs = str;
            }else {
                self.brandIDs = nil;
            }
        }else {
            self.brandIDs = nil;
        }

        //其它条件
        NSMutableArray *facetPropsArray = [NSMutableArray array];
        NSMutableArray *facetSpecArray = [NSMutableArray array];
        [filters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            //filters中有品牌的数组信息，有其它他的信息，通过class判断过滤掉数组信息
            if ([obj isKindOfClass:[BBGCategory class]]) {
                BBGCategory *selectedCat = (BBGCategory *)obj;
                if ([selectedCat.parentName isEqualToString:@"facetProps"]) {
                    NSString *str = [NSString stringWithFormat:@"%@|%@",selectedCat.parentId,selectedCat.catId];
                    [facetPropsArray addObject:str];
                }else if ([selectedCat.parentName isEqualToString:@"facetSpec"]) {
                    NSString *str = [NSString stringWithFormat:@"%@|%@",selectedCat.parentId,selectedCat.catId];
                    [facetSpecArray addObject:str];
                }
            }
        }];
        if (facetPropsArray.count>0) {
            self.facetProps = [facetPropsArray componentsJoinedByString:@"_"];
        }else {
            self.facetProps = nil;
        }
        if (facetSpecArray.count>0) {
            self.facetSpec = [facetSpecArray componentsJoinedByString:@"_"];
        }else {
            self.facetSpec = nil;
        }
        self.dataLoadType = BBGDataLoadRefresh;
    }
    
    self.showHaveStoreOnly = hasStore;
    self.showProprietaryOnly = isProprietary;
    //切换筛选条件时，将page还原
    self.page = 1;
    
    self.dataLoadType = BBGDataLoadRefresh; 
    [self.tableView setContentOffset:CGPointMake(0, 0)];
    [self.tableView triggerPullToRefresh];
//    [self updateData:^(BOOL sucessful, BBGResponse *response) {
//        [_tableView stopAnimationWithCompletion:^{
//            if (sucessful) {
//                [_tableView reloadData];
//                self.tableView.showsInfiniteScrolling = self.canLoadMore;
//                [self dismissDefaultView];
//            }else {
//                [self showDefaultViewWithStampImage:[UIImage imageNamed:@"Search_blank"]  tips:@"没有相关商品..." target:self actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:CGPointMake(0, 0) onView:self.view];
//            }
//        }];
//        
//    }];

    [self openMenu];
}


#pragma mark- UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    BBGSearchViewController_iPhone *seachrController = [[BBGSearchViewController_iPhone alloc] init];
    seachrController.delegate = self;
    seachrController.isFormFindCenterCtrl = NO;
    
    [BBGSessionManager sharedInstance].currentViewController = self;
    [self.navigationController pushViewController:seachrController animated:YES];

    return NO;
}

#pragma mark- BBGSearchViewDelegate
- (void)searchView:(BBGSearchViewController_iPhone *)searchViewController didSelectedKeywords:(NSString *)keywords {
    
    //清除搜索筛选条件、按关键字搜索
    [self clearFilterItem];
    //清除筛选页面的信息
    [_categoryController clearFilter];
    self.fCate = nil;
    self.keyword = keywords;
    self.searchBar.placeholder = keywords;
    [self.filterView reloadView];
    self.type = SortTypeDefault;
    
    //重置筛选刷新条件(根据keywords获取分类信息)
    _categoryController.fcate = nil;
    _categoryController.keywords = keywords;

    __weak BBGGoodsListViewController_iPhone *weakSelf = self;
    self.dataLoadType = BBGDataLoadRefresh;
    
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            _categoryController.filterAttributes = self.filterAttributes;
            weakSelf.nowRows = weakSelf.products.count;
            [weakSelf dismissDefaultView];
        }else {
            [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"Search_blank"]  tips:@"没有相关商品..." target:self actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:CGPointMake(0, 0) onView:weakSelf.view];
        }
        [weakSelf.tableView reloadData];
    }];
}

# pragma mark- BBGGoodsListFilterViewDelegate
- (void)goodsListFilterView:(BBGGoodsListFilterView_iPhone *)filterView selectedSortType:(SortType)type {

    self.type = type;     
    __weak BBGGoodsListViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    
    self.dataLoadType = BBGDataLoadRefresh;
    if (self.sourceViewController == BBGSearchController) {
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                
                [weakSelf.tableView reloadData];
                [weakSelf.tableView setContentOffset:CGPointMake(0, 0)];
                [[BBGLoadingTips sharedInstance] hideTips];
                weakSelf.tableView.showsInfiniteScrolling=weakSelf.canLoadMore;
                weakSelf.nowRows = weakSelf.products.count;
            }
        }];
    }else if (self.sourceViewController == BBGPhoneExtraController) {
        [self loadPhoneExtra:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                [weakSelf.tableView reloadData];
                [weakSelf.tableView setContentOffset:CGPointMake(0, 0)];
                [[BBGLoadingTips sharedInstance] hideTips];
                weakSelf.tableView.showsInfiniteScrolling=weakSelf.canLoadMore;
                weakSelf.nowRows = weakSelf.products.count;
            }
        }];
    }
}

#pragma mark- UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.contentOff = scrollView.contentOffset;
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    __weak BBGGoodsListViewController_iPhone *weakSelf = self;
    //向上滑动逻辑
    if (scrollView.contentOffset.y > self.contentOff.y) {
        //隐藏上下barView
        if (!weakSelf.isBarHidden) {
            [weakSelf.view layoutIfNeeded];
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.filterViewTopFromSuperViewConstraint.constant = -42;
                weakSelf.tableViewTopFromSuperViewConstraint.constant = 0;
                weakSelf.bottomViewBottomFromSuperViewConstraint.constant = -55;
                [weakSelf.view layoutIfNeeded];
            }];
            weakSelf.isBarHidden = YES;
        }
    }else {
        //显示上下barView
        if (weakSelf.isBarHidden) {
            [weakSelf.view layoutIfNeeded];
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.filterViewTopFromSuperViewConstraint.constant = 0;
                if (self.sourceViewController==BBGPhoneRecommendController) {
                    weakSelf.tableViewTopFromSuperViewConstraint.constant = 0;
                }
                else
                {
                    weakSelf.tableViewTopFromSuperViewConstraint.constant = 42;
                }
                weakSelf.bottomViewBottomFromSuperViewConstraint.constant = 0;
                [weakSelf.view layoutIfNeeded];
            }];
            weakSelf.isBarHidden = NO;
        }
    }
    
}


#pragma mark- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row > self.currentDisplayCellIndex){
        [cell animationOfScaleWithDuration:0.3];
    }
    
    self.currentDisplayCellIndex = indexPath.row;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[self.products ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"array"] count]>1) {
        return [BBGGroupGoodsListCell cellHeight];
    }
    return [BBGGoodsListCell_iPhone cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.products) {
        return self.products.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[self.products ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"array"] count]>1) {
        //返回多规格cell
        BBGGroupGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsGroup"];
        if (!cell) {
            cell = [[BBGGroupGoodsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBGGoodsGroup"];
        }
        cell.delegate =self;
        if (self.products.count>indexPath.row) {
            [cell updateCellWith:[self.products ARRAY_OBJ_AT(indexPath.row)]];
            //手机专享-活动label显示逻辑
            if (self.sourceViewController == BBGPhoneExtraController) {
                cell.goodsListCell.activityContent.hidden = NO;
            }else {
                cell.goodsListCell.activityContent.hidden = YES;
            }
        }
        
        return cell;
        
    }else{
        //返回普通cell
        [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsListCell_iPhone" bundle:nil] forCellReuseIdentifier:@"BBGGoodsListCell_iPhone"];
        BBGGoodsListCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsListCell_iPhone"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGGoodsListCell_iPhone" owner:nil options:nil] firstObject];
        }
        cell.delegate = self;
        if (self.products.count>indexPath.row) {
            [cell updateCellWith:[[self.products ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"array"][0]];
            
            //手机专享-活动label显示逻辑
            if (self.sourceViewController == BBGPhoneExtraController) {
                cell.activityContent.hidden = NO;
            }else {
                cell.activityContent.hidden = YES;
            }
        }
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BBGGoodsDetailViewController_iPhone *goodsDetail = [[BBGGoodsDetailViewController_iPhone alloc] init];
    NSArray *tempArray = [[self.products ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"array"];
    NSInteger temp = [[[self.products ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"choose"] integerValue];
    BBGSearchProduct *product = tempArray[temp];
    goodsDetail.productId = product.productID ;
    if ([tempArray count]>1) {
        //表示为多规格
        BBGGroupGoodsListCell *selectioncell = (BBGGroupGoodsListCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.currentImageView = selectioncell.goodsListCell.productImage;
        
    }else{
        BBGGoodsListCell_iPhone *selectionCell = (BBGGoodsListCell_iPhone *)[tableView cellForRowAtIndexPath:indexPath];
        self.currentImageView = selectionCell.productImage;

    }
       [self.navigationController pushViewController:goodsDetail animated:YES] ;
}

#pragma mark- GoodsListCellDelegate
- (void)goodsListCell:(UITableViewCell *)listCell itemDidSelectedWith:(CellItemIndex)itemIndex {
    NSIndexPath *indexPath = [_tableView indexPathForCell:listCell];
    NSInteger temp  =[[[self.products ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"choose"] integerValue];
    BBGSearchProduct *product = [[self.products ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"array"][temp];
    switch (itemIndex) {
        case PraiseItem:
            NSLog(@"暂时不做商品列表点赞");
            break;
        case CommentItem:
            
            break;
        case AddCartItem:
            self.productId = product.productID;
            self.quantity = 1;
            [BBGSessionManager sharedInstance].currentViewController = self;
            
            //普通商品添加购物车逻辑
            if (product.productType == 0) {
                if ([BBGSessionManager sharedInstance].isLogin) {
                    __weak BBGGoodsListViewController_iPhone * weakSelf =self;
                    [self addCartRequet:^(BOOL sucessful, BBGResponse *response) {
                        if (sucessful) {
                            
                            [[BBGLoadingTips sharedInstance] showTips:@"加入购物车成功"];
                           //设置底部bar数量
                            [weakSelf SetBottomAmount];
                            //显示上下barView
                            if (weakSelf.isBarHidden) {
                                [weakSelf.view layoutIfNeeded];
                                [UIView animateWithDuration:0.5 animations:^{
                                    weakSelf.filterViewTopFromSuperViewConstraint.constant = 0;
                                    weakSelf.tableViewTopFromSuperViewConstraint.constant = 42;
                                    weakSelf.bottomViewBottomFromSuperViewConstraint.constant = 0;
                                    [weakSelf.view layoutIfNeeded];
                                }];
                                weakSelf.isBarHidden = NO;
                            }
                        }
                    }];
                }else {
                    __weak BBGGoodsListViewController_iPhone * weakSelf =self;
                    
                    [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                        if (successful) {
                            [self addCartRequet:^(BOOL sucessful, BBGResponse *response) {
                                if (sucessful) {
                                    /**
                                     *  设置底部bar数量
                                     */
                                    [weakSelf SetBottomAmount];
                                    if (weakSelf.isBottomBarHidden) {
                                        [UIView animateWithDuration:0.5 animations:^{
                                            weakSelf.bottomBarView.center=CGPointMake(weakSelf.bottomBarView.center.x, weakSelf.view.frame.size.height-weakSelf.bottomBarView.frame.size.height/2);
                                        }];
                                        weakSelf.isBottomBarHidden=NO;
                                    }
                                    
                                    [[BBGLoadingTips sharedInstance] showTips:@"加入购物车成功"];
                                }
                            }];
                        }
                    }];
                }
            }else {
                [self cartDirectRequest:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        BBGSettlementViewController_iPhone *settlement = [[BBGSettlementViewController_iPhone alloc] init];
                        settlement.buyType = BBGBuyTypeDirect;
                        [self.navigationController pushViewController:settlement animated:YES];
                    }
                }];
                
            }
            break;

        default:
            break;
    }
}

-(BBGAddCartAnimation *)addCartAnimation{
    
    if (!_addCartAnimation) {
        _addCartAnimation = [[BBGAddCartAnimation alloc] init];
        _addCartAnimation.delegate = self;
    }
    return _addCartAnimation;
}

#pragma mark -  加入购物袋动画
- (void)addToCartAnimation:(CGPoint) piPoint{
    _isAnimation = YES;
    CGRect frame = CGRectMake(piPoint.x-10,piPoint.y-10, 1, 1);
    self.cartImage = [[UIImageView alloc] initWithFrame:frame];
    _cartImage.image = [UIImage imageNamed:@"goods_add_cart"];
    _cartImage.alpha = 0.8;
    _cartImage.frame = frame;
    [self.view addSubview:_cartImage];
    [self.view bringSubviewToFront:_cartImage];
    CGRect addCartButtonFrame =_addCartButton.frame;
    [[UIApplication sharedApplication].keyWindow addSubview:self.matteView];
    [self.addCartAnimation addCartAnimationWithCartImg:self.cartImage cartButtonFrame:addCartButtonFrame];
}



-(UIView *)matteView{
    
    if (!_matteView) {
        CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
        
        _matteView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - 44)];
        _matteView.backgroundColor = [UIColor clearColor];
    }
    return _matteView;
}

/**
 *  购物车动画结束
 */
-(void)addCartAimationDone{
    [_cartImage removeFromSuperview];
    [self.matteView removeFromSuperview];
    self.cartImage = nil;
   // self.scrollView.scrollEnabled = YES;
    _isAnimation = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 结算
- (IBAction)toSettleMent:(id)sender {
    [BBGSessionManager sharedInstance].currentViewController = self;
    if ([BBGSessionManager sharedInstance].isLogin) {
        if ([BBGCartManager sharedInstance].cartCount > 0) {
            BBGShoppingCartViewController_iPhone *shop = [[BBGShoppingCartViewController_iPhone alloc] init];
            
            [self.navigationController pushViewController:shop animated:YES];
        }else{
            [[BBGLoadingTips sharedInstance] showTips:@"至少选择一件商品"];
        }
    }else{
        __weak BBGGoodsListViewController_iPhone * weakSelf =self;
        
        [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
            
            [weakSelf toSettleMent:nil];
        }];
        
    }
    
    
}
#pragma mark -添加引导
-(void)addGuide{
    //当APP首次进入列表页  有一个引导
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *temp = [defaults objectForKey:@"GoodsListGuideTemp"];
    if (temp) {
        return;
    }else{
        [defaults setObject:@"exist" forKey:@"GoodsListGuideTemp"];
    }

    UIView *view = [[UIView alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(window);
        make.center.equalTo(window);
    }];
    
    animationImage= [[UIImageView alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i =1;i<=35;i++) {
        NSString *str;

        if (i==1) {
            str = [NSString stringWithFormat:@"tu000%d",i];
            NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            [array addObject:image];
        }
        if (i>0&&i<6) {
            array[i]=array[0];
        }
        if (i>5&&i<16) {
            if (i-5<10) {
                str = [NSString stringWithFormat:@"tu000%d",i-5];
            }else{
                str = [NSString stringWithFormat:@"tu00%d",i-5];
            }
            NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            [array addObject:image];

        }
        if (i>15&&i<21) {
            array[i] = array[15];
        }
        if (i>20&&i<31) {
            str = [NSString stringWithFormat:@"tu00%d",i-10];
            NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            [array addObject:image];

        }
        
        if (i>30) {
            array[i] =array[30];
        }
        
        
    }
    animationImage.animationImages = array;
    animationImage.image = [UIImage imageNamed:@"tu0020"];
    [view addSubview:animationImage];
    
    [animationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(0.9*IPHONE_WIDTH, 0.9*IPHONE_WIDTH*620/1110));
    }];
    animationImage.tag =20001;
    animationImage.animationDuration = 5;//设置动画时间
    animationImage.animationRepeatCount = 0;//设置动画次数 0 表示无限
    [animationImage startAnimating];//开始播放动画
    topLeftImage  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tip"]];
    [view addSubview:topLeftImage];
    [topLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(animationImage.mas_left).offset(0.05*IPHONE_WIDTH);
        make.bottom.equalTo(animationImage.mas_top);
        make.size.mas_equalTo(CGSizeMake(0.5*IPHONE_WIDTH, 0.5*IPHONE_WIDTH*294/640));
    }];
    topRightImage  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x"]];
    [view addSubview:topRightImage];
    [topRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(animationImage.mas_right).offset(-0.05*IPHONE_WIDTH);
        make.bottom.equalTo(animationImage.mas_top).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [topRightImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taped:)];
    [topRightImage addGestureRecognizer:gesture];
    
    

}
#pragma mark - 引导图的点击
-(void)taped:(UITapGestureRecognizer *)sender{
    UIView *view = animationImage.superview;
    [animationImage removeFromSuperview];
    animationImage = nil;
    [topRightImage removeFromSuperview];
    topRightImage =nil;
    [topLeftImage removeFromSuperview];
    topLeftImage =nil;
    
    [view removeFromSuperview];
    view =nil;
    
    
}

#pragma mark -设置底部bar数量
- (void)SetBottomAmount{
    /**
     *  设置底部bar数量
     */
    
    NSString *SettleStr = [NSString stringWithFormat:@"已添加%@件商品",[BBGCartManager sharedInstance].cartCount];
    
    NSMutableAttributedString *selectAttStr = [[NSMutableAttributedString alloc] initWithString:SettleStr];
    [selectAttStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_BLACK range:NSMakeRange(0,3)];
    [selectAttStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange(3,SettleStr.length-6)];
    
    self.cartCountLabel.attributedText=selectAttStr;
}
@end
