//
//  BBGCountryCategoryViewController.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCountryCategoryViewController.h"
#import "CountryCategoryTableViewCell.h"
#import "BBGGoodsListViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGFind.h"

@interface BBGCountryCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *countryCategoryTableView;

@end

@implementation BBGCountryCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    
    _countryCategoryTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [_countryCategoryTableView setBackgroundColor:[UIColor whiteColor]];
    _countryCategoryTableView.delegate = self;
    _countryCategoryTableView.dataSource = self;
    _countryCategoryTableView.tableFooterView = [[UITableView alloc] init];
    _countryCategoryTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_countryCategoryTableView];
    
    [_countryCategoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view);
    }];
    

    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_countryCategoryArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IPHONE_WIDTH/4.21 + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CountryCategoryTableViewCell";
    CountryCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    BBGFind *find = [_countryCategoryArray ARRAY_OBJ_AT(indexPath.row)];
    [cell.countryCategoryImageView sd_setImageWithURL:[NSURL URLWithString:find.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [cell.countryCategoryImageView setFadeInWithDefaultTime];
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    BBGGoodsListViewController_iPhone *goodsListViewCtrl = [[BBGGoodsListViewController_iPhone alloc] init];
    BBGFind *find = [_countryCategoryArray ARRAY_OBJ_AT(indexPath.row)];
    goodsListViewCtrl.fCate = find.catId;
    goodsListViewCtrl.sourceViewController = BBGSearchController;
    [self.navigationController pushViewController:goodsListViewCtrl animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
