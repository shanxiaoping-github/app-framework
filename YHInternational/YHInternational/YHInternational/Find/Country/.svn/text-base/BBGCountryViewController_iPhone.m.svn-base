//
//  BBGCountryViewController_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCountryViewController_iPhone.h"
#import "CountryTableViewCell.h"
#import "BBGCountryCategoryViewController.h"
#import "BBGNavigationController.h"

@interface BBGCountryViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *countryTableView;
@end

@implementation BBGCountryViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    _countryTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [_countryTableView setBackgroundColor:[UIColor whiteColor]];
    _countryTableView.delegate = self;
    _countryTableView.dataSource = self;
    _countryTableView.tableFooterView = [[UIView alloc] init];
    _countryTableView.separatorStyle = UITableViewCellSelectionStyleNone;\
    [_countryTableView setScrollsToTop:NO];
    [self.view addSubview:_countryTableView];
    
    
    [_countryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_countryArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IPHONE_WIDTH/2.45 + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CountryTableViewCell";
    CountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BBGFindCategory *countryCategory= [_countryArray ARRAY_OBJ_AT(indexPath.row)];
    [cell.countryCellImageView sd_setImageWithURL:[NSURL URLWithString:countryCategory.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType == SDImageCacheTypeNone) {
            [cell.countryCellImageView setFadeInWithDefaultTime];
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BBGCountryCategoryViewController *countryCategoryConTrol = [[BBGCountryCategoryViewController alloc] init];
    BBGFindCategory *countryCategory= [_countryArray ARRAY_OBJ_AT(indexPath.row)];
    
    countryCategoryConTrol.countryCategoryArray = countryCategory.findCategoryArray;
    countryCategoryConTrol.title = countryCategory.catName;
    BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:countryCategoryConTrol];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark BBGContentProtocol
-(void)changeViewController{
    [_countryTableView setScrollsToTop:NO];
}
- (void)loadDataWithMenu:(BBGMenuItem *)menu force:(BOOL)force{
    
    if (menu.menuID.intValue == 222) {
        [_countryTableView setScrollsToTop:YES];
    }
}
- (void)contentViewController:(UINavigationController *)controller{
    self.contentViewController = controller;
}

- (BOOL)isLoadCustomDataWithMenu:(BBGMenuItem *)menu{
    if (menu.menuID.intValue == 222) {
        return YES;
    }
    return NO;
}

- (void)distributionData:(id)data{
    _countryArray = (NSMutableArray *)data;
    if (_countryArray) {
        [_countryTableView reloadData];
    }
}



@end
