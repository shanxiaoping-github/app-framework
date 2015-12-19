//
//  BBGMyPraiseViewController_iPhone.m
//  YHInternational
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMyPraiseViewController_iPhone.h"
#import "BBGMyPraiseCell_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGPraiseProduct.h"

@interface BBGMyPraiseViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,BBGMyPraiseCellDelegate>


@end

@implementation BBGMyPraiseViewController_iPhone

- (void)actionOfCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"点赞";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"点赞" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    [self createLeftBarButtonItemWithTarget:self action:@selector(actionOfCancel) normalImage:[UIImage imageNamed:@"Cancel"] highlightedImage:[UIImage imageNamed:@"Cancel_White"]];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    self.tableView = [[BBGPullTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    UIImageView *timeLineImgView  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 1, self.view.bounds.size.height + 10000)];
    timeLineImgView.backgroundColor = UIColorFromHexadecimalRGB(0xc8c7cc);
    
    [self.tableView addSubview:timeLineImgView];
    [self.tableView sendSubviewToBack:timeLineImgView];
    
    
    __weak BBGMyPraiseViewController_iPhone *weakSelf = self;
    
     [self.tableView loadMore:^(id data) {
         [self.tableView stopAnimationWithCompletion:^{
              [weakSelf requestProductList:self.pageIndex+1];
         }];
        }];
    
    
    
    [self.tableView refreshData:^(id data) {
        [weakSelf requestProductList:1];
    }];
    [self requestProductList:1];
}

#pragma mark - UITableViewDataSource And UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 108;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.productArray COUNT];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BBGMyPraiseCell_iPhone";
    BBGMyPraiseCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGMyPraiseCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    
    BBGPraiseProduct *prodcut = (BBGPraiseProduct*)[self.productArray ARRAY_OBJ_AT(indexPath.row)];
    [cell reloadCell:prodcut];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //跳转到商品详情
    BBGPraiseProduct *product = [self.productArray ARRAY_OBJ_AT(indexPath.row)];
    BBGGoodsDetailViewController_iPhone *goodsDetailCtrl = [[BBGGoodsDetailViewController_iPhone alloc] init];
    goodsDetailCtrl.productId = product.productId;
    [self.navigationController pushViewController:goodsDetailCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestProductList:(NSInteger)tempPageIndex{
    self.pageIndex = tempPageIndex;
    __weak BBGMyPraiseViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoading:@""];
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        [weakSelf.tableView stopAnimation];
        [weakSelf dismissDefaultView];
        if (sucessful) {
            [weakSelf.tableView reloadData];

            if ([self.productArray COUNT] == 0) {
                [self showDefaultViewWithStampImage:[UIImage imageNamed:@"praiseNull"] tips:@"还没有赞过..." target:self actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                
            }
        }else{
            [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf.tableView actionTitle:@"重新加载" action:@selector(triggerPullToRefresh)
                                 WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
        }
        
        
    }];
}


#pragma mark BBGMyPraiseCellDelegate
- (void)cancelPraise:(BBGMyPraiseCell_iPhone *)cell{
    NSIndexPath *indexPat = [self.tableView indexPathForCell:cell];
    NSInteger row  = indexPat.row;
    BBGPraiseProduct *product = [self.productArray ARRAY_OBJ_AT(row)];
    
    __weak BBGMyPraiseViewController_iPhone *weakSelf = self;
    if (product.isPraise == -1) {
        //点赞
        self.addPraisePraiseRequest.productId = product.productId;
//        self.addPraisePraiseRequest.goodsId = product.goodsId;
        [[BBGLoadingTips sharedInstance] showLoading:@""];
        [self addPraiseRequest:^(BOOL sucessful, BBGResponse *response) {
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                product.isPraise = 0;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPat] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }else{
        //取消点赞
        self.cancelPraiseRequest.productId = product.productId;
//        self.cancelPraiseRequest.goodsId = product.goodsId;
        [[BBGLoadingTips sharedInstance] showLoading:@""];
        [self cancelPraiseRequest:^(BOOL sucessful, BBGResponse *response) {
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                product.isPraise = -1;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPat] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }
    
    
    
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
