//
//  BBGUnEvaluateGoodsListViewController_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUnEvaluateGoodsListViewController_iPhone.h"
#import "UnEvaluateTableViewCell.h"
#import "BBGEvaluateViewController_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGUnEvaluateGood.h"

#import "BBGShareOrderViewController_iPhone.h"

@interface BBGUnEvaluateGoodsListViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,UnEvaluateTableViewCellDelegate>

@property(nonatomic,strong) BBGPullTable *tableView;
@end

@implementation BBGUnEvaluateGoodsListViewController_iPhone



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"未晒单商品";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"未晒单商品" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    _tableView = [[BBGPullTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    /**
     时间轴
     */
    UIImageView *timeLineImgView  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 1, self.view.bounds.size.height + 10000)];
    timeLineImgView.backgroundColor = UIColorFromHexadecimalRGB(0xc8c7cc);
    
    [_tableView addSubview:timeLineImgView];
    [_tableView sendSubviewToBack:timeLineImgView];

    __weak BBGUnEvaluateGoodsListViewController_iPhone *weakSelf = self;
    [_tableView loadMore:^(id data) {
        [weakSelf requestProductList:self.pageIndex+1];
    }];
    
    [_tableView refreshData:^(id data) {
        self.canLoadMore = YES;
        [weakSelf requestProductList:1];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView triggerPullToRefresh];
    
}

#pragma mark - UITableViewDataSource And UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 108;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.unEvaluateGoodsArray COUNT];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UnEvaluateTableViewCell";
    UnEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    BBGUnEvaluateGood *prodcut = (BBGUnEvaluateGood *)[self.unEvaluateGoodsArray ARRAY_OBJ_AT(indexPath.row)];
    [cell reloadCell:prodcut];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BBGUnEvaluateGood *product = [self.unEvaluateGoodsArray ARRAY_OBJ_AT(indexPath.row)];
    BBGGoodsDetailViewController_iPhone *goodsDetailCtrl = [[BBGGoodsDetailViewController_iPhone alloc] init];
    goodsDetailCtrl.goodsId = product.goodsId;
    [self.navigationController pushViewController:goodsDetailCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)requestProductList:(NSInteger)tempPageIndex{
    self.pageIndex = tempPageIndex;
    __weak BBGUnEvaluateGoodsListViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        
        [weakSelf.tableView stopAnimationWithCompletion:^{
            [[BBGLoadingTips sharedInstance] hideTips];
            [self.defaultView dismiss];
            [weakSelf.tableView stopAnimation];
            if (sucessful) {
                if (self.unEvaluateGoodsArray.count) {
                    
                    [weakSelf.tableView reloadData];
                }else{
                    
                    [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"nullUnCommentGoods"] tips:@"没有未晒单的商品..." target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                }
            }else{
                [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:_tableView actionTitle:@"重新加载" action:@selector(triggerPullToRefresh)
                                     WithResponseResult:BBGResponseNetError offset:CGPointZero onView:self.view];
            }
            weakSelf.tableView.showsInfiniteScrolling = self.canLoadMore;
        }];
        
    }];
}

#pragma mark UnEvaluateTableViewCellDelegate

- (void)didClickedEvaluateGoodsBtn:(UnEvaluateTableViewCell *)cell {
    
    NSIndexPath *indexPat = [_tableView indexPathForCell:cell];
    NSInteger row  = indexPat.row;
    BBGUnEvaluateGood *product = [self.unEvaluateGoodsArray ARRAY_OBJ_AT(row)];
    
    
    
        BBGShareOrderViewController_iPhone *evaluateViewCtrl = [[BBGShareOrderViewController_iPhone alloc] init];
        evaluateViewCtrl.googsId = product.goodsId;
        evaluateViewCtrl.goodsImageUrl = product.imgUrl;
        evaluateViewCtrl.goodsName = product.productName;
        evaluateViewCtrl.goodsPrice = [NSString stringWithFormat:@"￥%0.2f",product.price/100.0];
        [self.navigationController pushViewController:evaluateViewCtrl animated:YES];
    
//    BBGEvaluateViewController_iPhone *evaluateViewCtrl = [[BBGEvaluateViewController_iPhone alloc] init];
//    evaluateViewCtrl.googsId = product.goodsId;
//    evaluateViewCtrl.goodsImageUrl = product.imgUrl;
//    evaluateViewCtrl.goodsName = product.productName;
//    evaluateViewCtrl.goodsPrice = [NSString stringWithFormat:@"￥%0.2f",product.price/100.0];
//    [self.navigationController pushViewController:evaluateViewCtrl animated:YES];
}
@end
