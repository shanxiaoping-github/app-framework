//
//  BBGOrderListViewController_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderListViewController_iPhone.h"
#import "BBGOrderListCell_iPhone.h"
#import "BBGOrderListSectionCell_iPhone.h"
#import "BBGOrderListFooterCell_iPhone.h"
#import "BBGPullTable.h"
#import "BBGOrderListMoreCell_iPhone.h"
#import "BBGOrderDetailViewController_iPhone.h"
#import "BBGReasonViewController_iPhone.h"
#import "BBGPayViewController_iPhone.h"
#import "BBGPayCompleteViewController_iPhone.h"
#import "BBGJumpManager.h"
@interface BBGOrderListViewController_iPhone ()<UITableViewDataSource,PullDelegate,BBGOrderListSectionCellDelegate,BBGOrderListFooterCellDelegate,BBGPayViewDelegate,BBGOrderDetaillViewDelegate>
@property (nonatomic,strong)BBGPullTable *tableView;
@property (nonatomic,weak)UINavigationController *contentViewController;
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *memberId;
@property (nonatomic,strong)BBGReasonViewController_iPhone *reasonView;
@property (nonatomic,strong)BBGMenuItem *currentMenu;
@end

@implementation BBGOrderListViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[BBGPullTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.notOpenSticky = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollsToTop = NO;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = UIColorFromRGB(236, 235, 232);
    self.currentPage = 1;
    self.pageSize = 20;
    
    __weak BBGOrderListViewController_iPhone *weakSelf = self;
    [self.tableView refreshData:^(id data) {
        weakSelf.currentPage = 1;
        weakSelf.dataLoadType = BBGDataLoadRefresh;
        [weakSelf loadOrderList];
    }];
    
    [self.tableView loadMore:^(id data) {
        weakSelf.currentPage++;
        weakSelf.dataLoadType = BBGDataLoadMore;
        [weakSelf loadOrderList];
    }];
    
}

-(void)loadOrderList{
    __weak BBGOrderListViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        //下拉动画先没加，会显示不出，或者影响切换效果
        [weakSelf.tableView stopAnimationWithCompletion:^{
            [weakSelf.defaultView dismiss];
            if (sucessful) {
                BBGOrderListResponse *orderListResponse = (BBGOrderListResponse *)response;
                weakSelf.currentPage = orderListResponse.currentPage;
                if (weakSelf.currentPage==1) {
                    weakSelf.orderList = orderListResponse.orderList;
                }else{
                    [weakSelf.orderList addObjectsFromArray:orderListResponse.orderList];
                }
                weakSelf.total = orderListResponse.totalSize;
                if (weakSelf.total%weakSelf.pageSize==0) {
                    weakSelf.totalPage = weakSelf.total/weakSelf.pageSize;
                }else{
                    weakSelf.totalPage = weakSelf.total/weakSelf.pageSize +1;
                }
                if (weakSelf.totalPage == 0 || weakSelf.totalPage == weakSelf.currentPage) {
                    //不能继续上拉加载
                    weakSelf.tableView.showsInfiniteScrolling = NO;
                }else{
                    //可以继续上拉加载
                    weakSelf.tableView.showsInfiniteScrolling = YES;
                }
                [_tableView reloadData];
                
                if ([weakSelf.orderList count]==0) {
                    //显示无数据页面
                    [weakSelf showDefaultView];
                }
                
            }else{
                if (response) {
                    if ([weakSelf.orderList count]==0) {
                        [weakSelf showDefaultViewWithStampImage:nil tips:response.errorMsg target:weakSelf actionTitle:@"刷新试试" action:@selector(refreshOrderList)
                                             WithResponseResult:BBGResponseError offset:CGPointZero onView:weakSelf.tableView];
                    }else{
                        
                        [[BBGLoadingTips sharedInstance] showTips:response.errorMsg];
                    }
                }else{
                    if ([weakSelf.orderList count]==0) {
                        [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf actionTitle:@"重新加载" action:@selector(refreshOrderList)
                                             WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.tableView];
                        
                    }
                }
            }

        }];
    }];

}


-(void)deleteOrderWithOrderId:(NSString *)orderId memberId:(NSString *)memberId{
    __weak BBGOrderListViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self deleteOrderWithOrderId:orderId memberId:memberId callback:^(BOOL sucessful, BBGResponse *response) {
       [[BBGLoadingTips sharedInstance] hideTips];
        
        if (sucessful) {
            [[BBGLoadingTips sharedInstance] showTips:@"订单删除成功！"];
            weakSelf.currentPage=1;
            [weakSelf.tableView triggerPullToRefresh];
        }
    }];
}

-(void)confirmOrderWithOrderId:(NSString *)orderId memberId:(NSString *)memberId{
    __weak BBGOrderListViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self confirmOrderWithOrderId:orderId memberId:memberId callback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            [[BBGLoadingTips sharedInstance] showTips:@"确认收货成功"];
            weakSelf.currentPage=1;
            [weakSelf.tableView triggerPullToRefresh];
        }
    }];
}

-(void)cancelOrderWithReason:(NSString *)reason{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    __weak BBGOrderListViewController_iPhone *weakSelf = self;
    [self cancelOrderWithOrderId:self.orderId cancelReason:reason callback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            [[BBGLoadingTips sharedInstance] showTips:@"取消订单成功"];
            [weakSelf.tableView triggerPullToRefresh];
        }
    }];
}


-(void)againPurchaseWithOrderId:(NSString *)orderId{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    __weak BBGOrderListViewController_iPhone *weakSelf = self;
    [self againPurchaseWithOrderId:orderId callback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            //跳转去购物车
            [[BBGLoadingTips sharedInstance] showTips:@"再次购买成功"];
            [weakSelf.contentViewController dismissViewControllerAnimated:YES completion:^{
                [[BBGJumpManager sharedInstance] managerJumpTo:BBGJumpCart];
            }];
            
            
        }
    }];
    

}



-(void)showDefaultView{
    NSString *image;
    NSString *tips;
    if ([self.currentMenu.menuID intValue] == 1){
        
        image = @"Order_blank";
        tips = @"您目前还没有待付款的订单...";
    }else if ([self.currentMenu.menuID intValue] == 2){
        
        image = @"Order_blank";
        tips = @"您目前没有待发货的订单...";
    }else if ([self.currentMenu.menuID intValue] == 3){
        
        image = @"Order_blank";
        tips = @"您目前没有待收货的订单...";
    }else if ([self.currentMenu.menuID intValue] == 4){
        
        image = @"Order_blank";
        tips = @"您目前没有已收货的订单...";
    }else{
        image = @"Order_blank";
        tips = @"您目前还没有下过单，赶紧去试试吧...";
        
    }
    
    [self showDefaultViewWithStampImage:[UIImage imageNamed:image] tips:tips target:nil actionTitle:nil action:nil
                         WithResponseResult:BBGResponseNotData offset:CGPointZero onView:self.tableView];
    
}


//#pragma mark - UITableViewDataSource And UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.orderList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (self.orderList && [self.orderList count]>section) {
        
        BBGOrderInfo *orderInfo = [self.orderList objectAtIndex:section];
        count = [orderInfo.productList count];
        
        if (count>3) {
            count = 3;
        }
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 75;
    if (indexPath.row>=2) {
        height = 44;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row>=2) {
        
        static NSString *identifier = @"BBGOrderListMoreCell_iPhone";
        BBGOrderListMoreCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderListMoreCell_iPhone" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
        
    }else{
        static NSString *identifier = @"CellIdentifier";
        BBGOrderListCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderListCell_iPhone" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.orderList && [self.orderList count]>indexPath.section) {
            BBGOrderInfo *orderInfo = [self.orderList objectAtIndex:indexPath.section];
            BBGOrderProduct *orderProduct = [orderInfo.productList objectAtIndex:indexPath.row];
            [cell updateOrderCellWithOrder:orderProduct];
        }
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BBGOrderDetailViewController_iPhone *orderDetailViewController = [[BBGOrderDetailViewController_iPhone alloc] init];
    BBGOrderInfo *orderInfo = [self.orderList ARRAY_OBJ_AT(indexPath.section)];
    orderDetailViewController.orderInfo = orderInfo;
    orderDetailViewController.orderId = orderInfo.orderId;
    orderDetailViewController.shopId = orderInfo.shopId;
    orderDetailViewController.delegate = self;
    [self.contentViewController pushViewController:orderDetailViewController animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView headerView:(NSInteger)section{
    
    static NSString *identifier = @"BBGOrderListSectionCell_iPhone";
    BBGOrderListSectionCell_iPhone *sectionView = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (sectionView==nil) {
        sectionView = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderListSectionCell_iPhone" owner:nil options:nil] firstObject];
        sectionView.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.orderList && [self.orderList count]>section) {
        BBGOrderInfo *orderInfo = [self.orderList objectAtIndex:section];
        [sectionView updateSectionViewWithOrderInfo:orderInfo];
    }
    sectionView.delegate = self;
    sectionView.frame = tableView.bounds;
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView footerView:(NSInteger)section{
    static NSString *identifier = @"BBGOrderListFooterCell_iPhone";
    BBGOrderListFooterCell_iPhone *footerView = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (footerView==nil) {
        footerView = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderListFooterCell_iPhone" owner:nil options:nil] firstObject];
        footerView.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    footerView.frame = tableView.bounds;
    footerView.delegate = self;
    if (self.orderList && [self.orderList count]>section) {
        BBGOrderInfo *orderInfo = [self.orderList objectAtIndex:section];
        [footerView updateViewDataWithOrderInfo:orderInfo];
    }
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightOfHeaderView:(NSIndexPath *)indexPath{
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightOfFooterView:(NSIndexPath *)indexPath{
    
    return 50;
}

- (void)didSelectedHeaderFooterView:(NSIndexPath *)indexPath{
    BBGOrderDetailViewController_iPhone *orderDetailViewController = [[BBGOrderDetailViewController_iPhone alloc] init];
    BBGOrderInfo *orderInfo = [self.orderList ARRAY_OBJ_AT(indexPath.section)];
    orderDetailViewController.orderInfo = orderInfo;
    orderDetailViewController.orderId = orderInfo.orderId;
    orderDetailViewController.shopId = orderInfo.shopId;
    orderDetailViewController.delegate = self;
    [self.contentViewController pushViewController:orderDetailViewController animated:YES];
}

-(void)changeViewController{
    self.tableView.scrollsToTop = NO;
}

- (void)loadDataWithMenu:(BBGMenuItem *)menu force:(BOOL)force{
    self.currentMenu = menu;
    self.currentPage = 1;
    if ([menu.menuID integerValue]==1) {
        self.status = OBLIGATIONSTATUS;
    }else if ([menu.menuID integerValue]==2){
        self.status = NOTRECEIVESTATUS;
    }else if ([menu.menuID integerValue]==3){
        self.status = NOTSHOPPEDSTATUS;
    }else if ([menu.menuID integerValue]==4){
        self.status = HAVERECEIVEDSTATUS;
    }else{
        self.status = ALLSTATUS;
    }
    
    self.tableView.scrollsToTop = YES;
    [self.tableView triggerPullToRefresh];
}


- (void)contentViewController:(UINavigationController *)controller{
    self.contentViewController = controller;
}


#pragma mark - BBGOrderListFooterCellDelegate method
- (void)clickFooterViewWithActionType:(BBGOrderActionType)actionType orderId:(NSString *)orderId memberId:(NSString *)memberId{
    self.orderId = orderId;
    self.memberId = memberId;
    if (actionType==CONFIRMORDERACTION) {
        //订单确认收货操作
        [BBGAlertView showWithTitle:@"" message:@"确定收到商品？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self confirmOrderWithOrderId:self.orderId memberId:self.memberId];
            }
        } buttonTitles:@"确定", nil];
    }else if (actionType==PAYMENTACTION){
        //订单支付操作
        
        BBGPayViewController_iPhone *payViewController = [[BBGPayViewController_iPhone alloc] init];
        payViewController.delegate = self;
        payViewController.paySource = USERCENTERORDERLIST;
        payViewController.orderIds = [NSMutableArray arrayWithObject:self.orderId];
        [self.contentViewController pushViewController:payViewController animated:YES];
        
    }else if (actionType==DELETEORDERACTION){
        //订单删除操作
        [BBGAlertView showWithTitle:@"" message:@"确定删除订单？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self deleteOrderWithOrderId:self.orderId memberId:self.memberId];
            }
        } buttonTitles:@"确定", nil];
    }else if(actionType==CANCELORDERACTION){
        //取消订单操作
        [self cancelOrder];
    }else if(actionType==REBUYACTION){
        //再次购买操作
        
        [BBGAlertView showWithTitle:@"" message:@"确定再次购买？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self againPurchaseWithOrderId:self.orderId];
            }
        } buttonTitles:@"确定", nil];
    }else if(actionType == SHOWORDER){
        //晒单操作
//        BBGPayViewController_iPhone *payViewController = [[BBGPayViewController_iPhone alloc] init];
//        payViewController.delegate = self;
//        payViewController.paySource = USERCENTERORDERLIST;
//        payViewController.orderIds = [NSMutableArray arrayWithObject:self.orderId];
//        [self.contentViewController pushViewController:payViewController animated:YES];
    }
    
}

#pragma mark  - 取消订单
-(void)cancelOrder{
    self.reasonView = [[BBGReasonViewController_iPhone alloc] init];
    self.reasonView.reasons = [self loadReasons];
    __weak BBGOrderListViewController_iPhone *weakSelf = self;
    [self.reasonView setReasonCallback:^(NSString *reason){
        [weakSelf cancelOrderWithReason:reason];
    }];
    [self.reasonView show];
    
}

-(NSArray *)loadReasons{
    
    BBGCancellingReason *reason1 = [[BBGCancellingReason alloc] init];
    reason1.reasonID = @"1";
    reason1.reason = @"价格太高了";
    BBGCancellingReason *reason2 = [[BBGCancellingReason alloc] init];
    reason2.reasonID = @"2";
    reason2.reason = @"拍错了，重新再拍";
    BBGCancellingReason *reason3 = [[BBGCancellingReason alloc] init];
    reason3.reasonID = @"3";
    reason3.reason = @"服务不好";
    BBGCancellingReason *reason4 = [[BBGCancellingReason alloc] init];
    reason4.reasonID = @"4";
    reason4.reason = @"不想买了";
    BBGCancellingReason *reason5 = [[BBGCancellingReason alloc] init];
    reason5.reasonID = @"5";
    reason5.reason = @"支付不成功";
    BBGCancellingReason *reason6 = [[BBGCancellingReason alloc] init];
    reason6.reasonID = @"6";
    reason6.reason = @"其他原因";
    NSArray *reasons = [NSArray arrayWithObjects:reason1,reason2,reason3,reason4,reason5,reason6,nil];
    return reasons;
}

#pragma mark - BBGOrderListSectionCellDelegate method
- (void)countdownFinished{
    //待付款订单超时处理
    self.currentPage=1;
    [self.tableView triggerPullToRefresh];
}

#pragma mark - orderDetail status update delegate method
-(void)refreshOrderList{
    self.currentPage=1;
    [self.tableView triggerPullToRefresh];
}

-(void)paySuccess{
    [[BBGLoadingTips sharedInstance] showTips:@"订单支付成功"];
    self.currentPage=1;
    [self.tableView triggerPullToRefresh];
}

-(void)payFailed{
    [[BBGLoadingTips sharedInstance] showTips:@"订单支付失败，请重试"];
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
