//
//  BBGSearchViewController_iPhone.m
//  BuBuGao
//
//  Created by Holyjoy on 15/3/19.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGSearchViewController_iPhone.h"
#import "SearchHistoryCollectionViewCell.h"
#import "SearchHistoryCollectionHeadView.h"
#import "SearchResultTableViewCell.h"
#import "BBGGoodsListViewController_iPhone.h"
#import "BBGDefaultView.h"
//#import "BBGNavigationViewController.h"

@interface BBGSearchViewController_iPhone ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,SearchHistoryCollectionHeadViewDelegate>
{

    BBGSearchBar *searchBar;
}
//搜索历史
@property (nonatomic,strong)UICollectionView *historyCollectionView;

@end

static NSString *indentify = @"collectionIndentify";

@implementation BBGSearchViewController_iPhone
@synthesize searchDisplayViewController = _searchDisplayViewController;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(actionOfCancel) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
    [closeBtn sizeToFit];
    UIBarButtonItem *closeBarBtn = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:self
                                                                               action:nil];
    flexSpacer.width = 10.0;
    
    float searchbarWith = IPHONE_WIDTH - 45 - 10;
    searchBar = [[BBGSearchBar alloc] initWithFrame:CGRectMake(0, 0, searchbarWith, 35)];
    searchBar.delegate = self;
    searchBar.enablesReturnKeyAutomatically = NO;
    if ([BBGTools checkStringIsBlank:[BBGLaunchManager sharedInstance].searchText]) {
        searchBar.placeholder = @"购全球，上云猴";
    }else{
        searchBar.placeholder = [BBGLaunchManager sharedInstance].searchText;
    }
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    [self.navigationItem setLeftBarButtonItems:@[closeBarBtn,flexSpacer,searchBarItem]];

    
    _searchDisplayViewController = [[BBGSearchDisplayViewController alloc] initWithSearchBar:searchBar contentsController:self];
    _searchDisplayViewController.searchResultsDataSource = self;
    _searchDisplayViewController.searchResultsDelegate = self;
    _searchDisplayViewController.searchResultsTableView.tableFooterView = [[UIView alloc] init];
    _searchDisplayViewController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchDisplayViewController.view.hidden = YES;
    
    //3DTouch启动 收起键盘
    if (!_isForm3DTouch) {
        [searchBar becomeFirstResponder];
    }

    [self addHistoryCollectionView];
    [self loadSearchHistory];
}

- (void)actionOfCancel{
    if (searchBar != nil) {
        [searchBar resignFirstResponder];
    }
    [self dismissViewController];
    
}


- (void)addHistoryCollectionView{

    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    flowL.itemSize = CGSizeMake((self.view.bounds.size.width - 50)/4, 35);
    flowL.minimumLineSpacing = 10.f;
    flowL.minimumInteritemSpacing = 10;
    flowL.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
/// 头部大小设置
    [flowL setHeaderReferenceSize:CGSizeMake(_historyCollectionView.frame.size.width, 43)];
    
    _historyCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowL];
    _historyCollectionView.dataSource = self;
    _historyCollectionView.delegate = self;
    _historyCollectionView.backgroundColor = UIColorFromRGB(239, 239, 239);

/// 注册单元格
    [_historyCollectionView registerClass:[SearchHistoryCollectionViewCell class] forCellWithReuseIdentifier:indentify];
///注册头部视图
    [_historyCollectionView registerClass:[SearchHistoryCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    [self.view addSubview:_historyCollectionView];
}

#pragma mark -- UICollection dataSource and delegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.searchHistoryArray.count > 0? 1 : 0 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchHistoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchHistoryCollectionViewCell *cell = (SearchHistoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    if ([self.searchHistoryArray count] > indexPath.row) {
        cell.titleLabel.text = [self.searchHistoryArray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
         SearchHistoryCollectionHeadView *headerView = (SearchHistoryCollectionHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.delegate = self;
        reusableView = headerView;
    }
    
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    //搜索请求并跳转
    [self didActionSearchBtn:[self.searchHistoryArray ARRAY_OBJ_AT(indexPath.row)]];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


#pragma mark - UITableViewDataSource And UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.phraseAssociationArray.count > 10? 10:self.phraseAssociationArray.count;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"BBGSearchViewController_iPhone";
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchResultTableViewCell" owner:nil options:nil] firstObject];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if ([self.phraseAssociationArray count] > indexPath.row) {
        BBGPhraseAssociation *phraseAssociation = [self.phraseAssociationArray objectAtIndex:indexPath.row];
        [cell updateCellData:phraseAssociation];
        
        //关键字飘红
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:cell.nameLabel.text];
        NSString *keyword = [_searchDisplayViewController.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSRange range = [cell.nameLabel.text rangeOfString:keyword];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        cell.nameLabel.attributedText = attrString;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchResultTableViewCell *cell = (SearchResultTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    //搜索请求并跳转
    [self didActionSearchBtn:cell.nameLabel.text];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *text = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (text.length > 0) {
        _historyCollectionView.hidden = YES;
        _searchDisplayViewController.view.hidden = NO;
        __weak BBGSearchViewController_iPhone *weakself = self;

        weakself.keyWords = text;
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {

                [self.defaultView dismiss];
                [weakself.searchDisplayViewController.searchResultsTableView reloadData];
            }
        }];
    }else{
        _historyCollectionView.hidden = NO;
        _searchDisplayViewController.view.hidden = YES;
        [_historyCollectionView reloadData];
        if (self.searchHistoryArray.count > 0) {
            [self.defaultView dismiss];
        }else{
            NSString *tips = @"暂无搜索历史记录哦～";
            [self showDefaultViewWithStampImage:[UIImage imageNamed:@"searchHistoryNull"] tips:tips target:self actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
        }
    }
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)bbgSearchBar {
    
    [searchBar resignFirstResponder];
    NSString *text = [bbgSearchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([BBGTools checkStringIsBlank:text]) {
        if (![BBGTools checkStringIsBlank:[BBGLaunchManager sharedInstance].searchText]) {
            text = [BBGLaunchManager sharedInstance].searchText;
        }
    }
    if (text.length > 0) {
        //搜索请求并跳转
        [self didActionSearchBtn:text];
        
    }
    
}

/**
 *  @author holyjoy, 15-03-26 10:03:54
 *
 *  将点击的关键字添加到缓存
 *、
 *  @param keyword 点击的关键字
 */
- (void)addSearchHistoryCache:(NSString *)keyword {
    
    //最多保存12条历史纪录，添加搜索历史前返回最多11条再添加
    self.searchHistoryArray = (NSMutableArray *)[[BBGCache queryCacheForType:BBGCacheTypeSearchHistory maxCount:11] firstObject];
    if (!self.searchHistoryArray) {
        self.searchHistoryArray = [NSMutableArray array];
    }
    if (self.searchHistoryArray.count > 11) {
        self.searchHistoryArray = [NSMutableArray arrayWithArray:[self.searchHistoryArray subarrayWithRange:NSMakeRange(0, 11)]];
    }
    if (![self.searchHistoryArray containsObject:keyword]) {
        [self.searchHistoryArray ARRAY_INSERT_OBJ_AT(keyword, 0)];
        [BBGCache addCache:KEYSEARCHHISTORY obj:self.searchHistoryArray type:BBGCacheTypeSearchHistory];
    }
    
}

/**
 *  @author holyjoy, 15-03-25 10:03:51
 *
 *  搜索请求并跳转
 *
 *  @param keyWord 关键字
 */
- (void)didActionSearchBtn:(NSString *)keyWord {
    
    //去掉前后空格
    NSString *text = [keyWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //添加缓存
    [NSThread detachNewThreadSelector:@selector(addSearchHistoryCache:) toTarget:self withObject:text];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:didSelectedKeywords:)]) {
        [self.delegate searchView:self didSelectedKeywords:keyWord];
    }
    [searchBar resignFirstResponder];
    //Yes push去商品列表  No 返回商品列表
    if (_isFormFindCenterCtrl) {
        BBGGoodsListViewController_iPhone *goodsListCtrl = [[BBGGoodsListViewController_iPhone alloc] init];
        goodsListCtrl.keyword = keyWord;
        goodsListCtrl.sourceViewController = BBGSearchController;
        [self.navigationController pushViewController:goodsListCtrl animated:YES];
        
    }else{
        [self dismissViewController];

    }
}

#pragma mark - SearchHistoryCollectionHeadViewDelegate Methods

- (void)didActionClearBtn{
    [BBGCache removeCacheForType:BBGCacheTypeSearchHistory];

    [[BBGLoadingTips sharedInstance] showTips:@"清空搜索历史成功"];
    [self loadSearchHistory];
    [_historyCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
