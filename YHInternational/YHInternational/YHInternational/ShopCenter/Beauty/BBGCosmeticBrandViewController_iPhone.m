//
//  BBGCosmeticBrandViewController_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/7/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCosmeticBrandViewController_iPhone.h"
#import "BBGPopularProductCell_iPhone.h"
#import "BBGCosmeticBrandCell_iPhone.h"
#import "BBGPopularBrand.h"
#import "BBGAbstractBrand.h"
#import "BBGCosmeticSectionHeader_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGGoodsListViewController_iPhone.h"

@interface BBGCosmeticBrandViewController_iPhone ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BBGCosmeticSectionHeaderDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BBGCosmeticBrandViewController_iPhone
- (id)initWithTypeTag:(NSInteger)tag {
    self = [super init];
    if (self) {
        self.typeTag = tag;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    
    switch (self.typeTag) {
        case 1:
            label.text = @"食品" ;
            break;
        case 2:
            label.text = @"保健品" ;
            break;
        default:
            label.text = @"美妆品牌" ;
            break;
    }
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label;
    
    _collectionView.showsVerticalScrollIndicator = NO;
    
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            [_collectionView reloadData];
            [[BBGLoadingTips sharedInstance] hideTips];
        }
    }];
    
}

#pragma mark- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    BBGBrand *brand = [self.brandsArray ARRAY_OBJ_AT(indexPath.section)];
    if (brand.brandType == BBGPopularBrandType) {
        return CGSizeMake(IPHONE_WIDTH/2, 205);
    }else {
        float cellWidth = (IPHONE_WIDTH-35)/4.0;
        return CGSizeMake(cellWidth, cellWidth*9/14);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0f ;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    BBGBrand *brand = [self.brandsArray ARRAY_OBJ_AT(section)];
    if (brand.brandType == BBGPopularBrandType) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else {
        if (brand.subContentsArray.count == 0) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
        return UIEdgeInsetsMake(0, 10, 10, 10);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(IPHONE_WIDTH, 60);
}


#pragma mark- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.brandsArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    BBGBrand *brand = [self.brandsArray ARRAY_OBJ_AT(section)];
    return brand.subContentsArray.count;
}

//页眉
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView registerNib:[UINib nibWithNibName:@"BBGCosmeticSectionHeader_iPhone" bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:@"BrandSectionHeader"];
    BBGCosmeticSectionHeader_iPhone *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BrandSectionHeader" forIndexPath:indexPath];
    if (!headerView) {
        headerView = [[[NSBundle mainBundle] loadNibNamed:@"BBGCosmeticSectionHeader_iPhone" owner:nil options:nil] firstObject];
    }
    BBGBrand *brand = [self.brandsArray ARRAY_OBJ_AT(indexPath.section)];
    [headerView updateSectionHeaderWith:brand];
    headerView.index = indexPath.section;
    headerView.delegate = self;
    return headerView;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BBGBrand *brand = [self.brandsArray ARRAY_OBJ_AT(indexPath.section)];
    
    if (brand.brandType == BBGPopularBrandType) {
        static NSString *productCellIdentifier = @"BBGPopularProductCell_iPhone";
        [collectionView registerNib:[UINib nibWithNibName:@"BBGPopularProductCell_iPhone" bundle:nil] forCellWithReuseIdentifier:productCellIdentifier];
        BBGPopularProductCell_iPhone *productCell = [collectionView dequeueReusableCellWithReuseIdentifier:productCellIdentifier forIndexPath:indexPath];
        if (!productCell) {
            productCell = [[[NSBundle mainBundle] loadNibNamed:@"BBGPopularProductCell_iPhone" owner:nil options:nil] firstObject];
        }
        BBGPopularProduct *product = [brand.subContentsArray ARRAY_OBJ_AT(indexPath.row)];
        [productCell updateCellWithPopularProduct:product];
        return productCell;
    }else {
        
        static NSString *brandCellIdentifier = @"BBGCosmeticBrandCell_iPhone";
        [collectionView registerNib:[UINib nibWithNibName:@"BBGCosmeticBrandCell_iPhone" bundle:nil] forCellWithReuseIdentifier:brandCellIdentifier];
        BBGCosmeticBrandCell_iPhone *brandCell = [collectionView dequeueReusableCellWithReuseIdentifier:brandCellIdentifier forIndexPath:indexPath];
        if (!brandCell) {
            brandCell = [[[NSBundle mainBundle] loadNibNamed:@"BBGCosmeticBrandCell_iPhone" owner:nil options:nil] firstObject];
            brandCell.backgroundColor = [UIColor greenColor];
        }
        BBGPopularBrand *popularBrand = [brand.subContentsArray ARRAY_OBJ_AT(indexPath.row)];
        [brandCell.contentImageView sd_setImageWithURL:[NSURL URLWithString:popularBrand.url] placeholderImage:nil];
        return brandCell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    BBGBrand *brand = [self.brandsArray ARRAY_OBJ_AT(indexPath.section)];
    if (brand.brandType == BBGPopularBrandType) {
        //跳转商品详情
        BBGPopularProduct *product = [brand.subContentsArray ARRAY_OBJ_AT(indexPath.row)];
        BBGGoodsDetailViewController_iPhone *goodsDetail = [[BBGGoodsDetailViewController_iPhone alloc] init];
        goodsDetail.productId = product.productId ;
        [self.navigationController pushViewController:goodsDetail animated:YES] ;
    }else {
        //跳转商品列表
        BBGPopularBrand *popularBrand = [brand.subContentsArray ARRAY_OBJ_AT(indexPath.row)];
        BBGGoodsListViewController_iPhone *goodsList = [[BBGGoodsListViewController_iPhone alloc] init];
        goodsList.sourceViewController = BBGSearchController;
        goodsList.title = popularBrand.brandName;
        goodsList.brandIDs = popularBrand.brandId;
        [self.navigationController pushViewController:goodsList animated:YES] ;
    }

}

#pragma mark- BBGCosmeticSectionHeaderDelegate

- (void)sectionHeader:(BBGCosmeticSectionHeader_iPhone *)sectionView didSelectedAtIndex:(NSInteger)index {

    BBGBrand *brand = [self.brandsArray ARRAY_OBJ_AT(index)];
    if (brand.brandType == BBGPopularBrandType) {
        //跳转商品列表
        BBGGoodsListViewController_iPhone *goodsList = [[BBGGoodsListViewController_iPhone alloc] init];
        goodsList.sourceViewController = BBGSearchController;
        goodsList.title = brand.brandName;
        goodsList.brandIDs = brand.brandId;
        [self.navigationController pushViewController:goodsList animated:YES] ;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
