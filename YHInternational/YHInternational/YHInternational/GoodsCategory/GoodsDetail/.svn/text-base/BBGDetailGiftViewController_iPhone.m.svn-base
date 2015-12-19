//
//  BBGDetailGiftViewController_iPhone.m
//  YHInternational
//
//  Created by 彭腾 on 15/6/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGDetailGiftViewController_iPhone.h"
#import "BBGDetailGiftCell.h"
#import "BBGPromotionGifts.h"
#import "BBGPromotionItem.h"
#import "BBGGoodsDetailViewController_iPhone.h"
@interface BBGDetailGiftViewController_iPhone ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_BBGDetailGift;
}

@property (nonatomic, strong) BBGPromotionGifts *promotionGifts;

@property (nonatomic, strong) BBGPromotionItem *promotionItem;

@end

@implementation BBGDetailGiftViewController_iPhone

- (void)initUI {
    _BBGDetailGift = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64)];
    _BBGDetailGift.delegate = self;
    _BBGDetailGift.dataSource = self;
    _BBGDetailGift.separatorStyle = UITableViewCellSeparatorStyleNone;
    _BBGDetailGift.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;

    [self.view addSubview:_BBGDetailGift];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)];
    label.text = @"赠品";
    label.font = APP_FONT_DEMI_LIGHT(18.0f);
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    [self initUI];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataArr COUNT];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    BBGPromotionGifts *model = [_dataArr ARRAY_OBJ_AT(section)];
    return [model.itemArr COUNT];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak BBGDetailGiftViewController_iPhone *weakSelf = self;
    [tableView registerNib:[UINib nibWithNibName:@"BBGDetailGiftCell" bundle:nil] forCellReuseIdentifier:@"BBGDetailGift"];
    BBGDetailGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGDetailGift"];

    self.promotionGifts = [_dataArr ARRAY_OBJ_AT(indexPath.section)];
    self.promotionItem = [self.promotionGifts.itemArr ARRAY_OBJ_AT(indexPath.row)];

    if ([self.promotionItem.store integerValue]<=0) {
        cell.name.textColor = UIColorFromHexadecimalRGB(0x999999);
        cell.whiteView.hidden = NO;
        cell.blackView.hidden = NO;
        cell.finishLab.hidden = NO;
    }else {
        cell.name.textColor = UIColorFromHexadecimalRGB(0x333333);
        cell.whiteView.hidden = YES;
        cell.blackView.hidden = YES;
        cell.finishLab.hidden = YES;
    }
    if (self.promotionItem.specText!=nil) {
        cell.specLab.hidden = NO;
        cell.specLab.text = self.promotionItem.specText;
    }else {
        cell.specLab.hidden = YES;
    }
    [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:self.promotionItem.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [cell.mainImage setFadeInWithDefaultTime];
        }
    }];
    cell.name.text = self.promotionItem.name;
    [cell handlerButtonAction:^{
        BBGGoodsDetailViewController_iPhone *vc = [[BBGGoodsDetailViewController_iPhone alloc]init];
        weakSelf.promotionGifts = [_dataArr ARRAY_OBJ_AT(indexPath.section)];
        weakSelf.promotionItem = [weakSelf.promotionGifts.itemArr ARRAY_OBJ_AT(indexPath.row)];
        vc.productId = weakSelf.promotionItem.productId;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    cell.numLab.text = [NSString stringWithFormat:@"x%@",self.promotionItem.num];

    CGSize size = [cell.numLab.text
                   sizeWithStringFont:cell.numLab.font constrainedToSize:CGSizeMake(IPHONE_WIDTH, 15)];
    CGFloat cellH = size.width;
    cell.numLabWidth.constant = cellH+10.0f;
    [cell.numLab setNeedsDisplay];
    [cell setNeedsDisplay];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    BBGPromotionGifts *model = _dataArr[section];
    BBGPromotionGifts *model = [_dataArr ARRAY_OBJ_AT(section)];

    UIView *myView = [[UIView alloc]init];
    myView.backgroundColor = [UIColor whiteColor];
    if (section!=0) {
        CALayer *topBorder = [CALayer layer];
        topBorder.frame = CGRectMake(0.0f, 0.0f, IPHONE_WIDTH, 0.5f);
        topBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
        [myView.layer addSublayer:topBorder];
    }
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 16, 16)];
    [image setImage:[UIImage imageNamed:@"goodDetailGift"]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 20)];
    titleLabel.text = model.name;
    titleLabel.textColor = UICOLOR_FONT_IMPORTANT_BLACK;
    titleLabel.font = APP_FONT(15.0f);
    [myView addSubview:image];
    [myView addSubview:titleLabel];
    return myView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *myView = [[UIView alloc]init];
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, IPHONE_WIDTH, 0.5f);
    topBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
    [myView.layer addSublayer:topBorder];
    return myView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40.0f;
    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)dealloc {
    
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
