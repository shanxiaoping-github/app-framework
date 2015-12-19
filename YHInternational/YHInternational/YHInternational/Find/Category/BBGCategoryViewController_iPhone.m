//
//  BBGCategoryViewController_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCategoryViewController_iPhone.h"
#import "CateGoryCollectionCell.h"
#import "BBGGoodsListViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGFind.h"

@interface BBGCategoryViewController_iPhone ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *categoryCollectionView;
@end

static NSString *indentify = @"CateGoryCollectionCell";

@implementation BBGCategoryViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;

    [self addCategoryCollectionView];
}

- (void)addCategoryCollectionView{
    
    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    flowL.itemSize = CGSizeMake((IPHONE_WIDTH - 6)/2,(IPHONE_WIDTH - 6)/2/2.45 );
    flowL.minimumLineSpacing = 5.f;
    flowL.minimumInteritemSpacing = 3;
    [flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _categoryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.width) collectionViewLayout:flowL];
    _categoryCollectionView.dataSource = self;
    _categoryCollectionView.delegate = self;
    _categoryCollectionView.backgroundColor = [UIColor whiteColor];
    _categoryCollectionView.alwaysBounceVertical = YES;
    /// 注册单元格
    [_categoryCollectionView registerNib:[UINib nibWithNibName:indentify bundle:nil] forCellWithReuseIdentifier:indentify];
    [_categoryCollectionView setScrollsToTop:NO];
    [self.view addSubview:_categoryCollectionView];
    [_categoryCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(5);
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-5);
        make.right.mas_equalTo(self.view);
    }];
}

#pragma mark -- UICollection dataSource and delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _categoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CateGoryCollectionCell *cell = (CateGoryCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    BBGFind *find = [_categoryArray ARRAY_OBJ_AT(indexPath.row)];
    [cell.cateGoryImageView sd_setImageWithURL:[NSURL URLWithString:find.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [cell.cateGoryImageView setFadeInWithDefaultTime];
        }
    }];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BBGGoodsListViewController_iPhone *goodsListViewCtrl = [[BBGGoodsListViewController_iPhone alloc] init];
    BBGFind *find = [_categoryArray ARRAY_OBJ_AT(indexPath.row)];
    goodsListViewCtrl.fCate = find.catId;
    goodsListViewCtrl.sourceViewController = BBGSearchController;
    BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:goodsListViewCtrl];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark BBGContentProtocol
-(void)changeViewController{
    [_categoryCollectionView setScrollsToTop:NO];
}
- (void)loadDataWithMenu:(BBGMenuItem *)menu force:(BOOL)force{
    
    if ([menu.menuID integerValue]==111){
        [_categoryCollectionView setScrollsToTop:YES];
    }
}

- (void)contentViewController:(UINavigationController *)controller{
    self.contentViewController = controller;
}

- (BOOL)isLoadCustomDataWithMenu:(BBGMenuItem *)menu{
    if (menu.menuID.intValue == 111) {
        return YES;
    }
    return NO;
}
- (void)distributionData:(id)data{
    _categoryArray = (NSMutableArray *)data;
    if (_categoryArray) {
        [_categoryCollectionView reloadData];
    }
}

@end
