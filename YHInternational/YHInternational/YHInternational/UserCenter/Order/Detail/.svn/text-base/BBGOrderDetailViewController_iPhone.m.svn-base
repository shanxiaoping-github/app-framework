//
//  BBGOrderDetailViewController_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailViewController_iPhone.h"
#import "BBGPullTable.h"
#import "BBGOrderDetailStatusCell_iPhone.h"
#import "BBGOrderDetailAmountCell_iPhone.h"
#import "BBGOrderDetalIconTitleCell_iPhone.h"
#import "BBGOrderDetailContentCell_iPhone.h"
#import "BBGOrderDetailActiveCell_iPhone.h"
#import "BBGOrderDetailAddressCell_iPhone.h"
#import "BBGOrderDetailLogisticsCell_iPhone.h"
#import "BBGOrderListCell_iPhone.h"
#import "BBGReasonViewController_iPhone.h"
#import "BBGPayViewController_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGSpecialWebViewController_iPhone.h"
@interface BBGOrderDetailViewController_iPhone ()<UITableViewDataSource,PullDelegate,UIAlertViewDelegate,BBGPayViewDelegate,BBGOrderDetailStatusCellDelegate,BBGLogisticsNumDelegate>
@property (nonatomic,strong)BBGPullTable *tableView;
@property (nonatomic,assign)BOOL isLogistics;
@property (nonatomic,strong)NSMutableArray *orderTrackList;
@property (nonatomic,strong)BBGReasonViewController_iPhone *reasonView;
@property (nonatomic,strong)NSString *contact;
@property (nonatomic,assign)BOOL isRefreshOrderList;
@end

@implementation BBGOrderDetailViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"订单详情";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"订单详情" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    [self createRightBarButtonItemWithTarget:self action:@selector(orderDetialOnlineCustomerService) title:@"联系客服" titleColor:UICOLOR_FONT_IMPORTANT_RED];

    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[BBGPullTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.notOpenSticky = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = UIColorFromRGB(236, 235, 232);
    self.contact = @"400-888-881";
    

    [self loadOrderDetail];
}
#pragma mark -------订单详情在线客服
-(void)orderDetialOnlineCustomerService{
    if (![BBGLaunchManager sharedInstance].isOpenContactURL) {
        [BBGTools callPhone:@"400-888-8881" alertTitle:@"当前在线客服系统暂不可用，请电话联系客服。"];
    }else{
        [self connectServer];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


-(void)loadOrderDetail{

    __weak BBGOrderDetailViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        [weakSelf.defaultView dismiss];
        if (sucessful) {
            [weakSelf loadOrderTrack];
            BBGOrderDetailResponse *orderDetailResponse = (BBGOrderDetailResponse *)response;
            weakSelf.orderInfo = orderDetailResponse.orderDetail;
        }else{
            [[BBGLoadingTips sharedInstance] hideTips];
            
            if (response) {
                [weakSelf showDefaultViewWithStampImage:nil tips:response.errorMsg target:weakSelf actionTitle:@"刷新试试" action:@selector(loadOrderDetail)
                                     WithResponseResult:BBGResponseError offset:CGPointZero onView:weakSelf.view];
            }else{
            
                [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf actionTitle:@"重新加载" action:@selector(loadOrderDetail)
                                     WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
            }
            
        }
        
    }];
    
}

-(void)loadOrderTrack{
    
     __weak BBGOrderDetailViewController_iPhone *weakSelf = self;
    [self getOrderTrackList:^(BOOL sucessful, BBGResponse *response) {
       [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            BBGOrderTracksResponse *orderTracksResponse = (BBGOrderTracksResponse *)response;
            weakSelf.orderTrackList = orderTracksResponse.trackList;
            if ([weakSelf.orderTrackList count]>0) {
                weakSelf.isLogistics = YES;
            }else{
                weakSelf.isLogistics = NO;
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf createButtomView];
        
    }];
    
}


-(void)cancelOrderWithReason:(NSString *)reason{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    __weak BBGOrderDetailViewController_iPhone *weakSelf = self;
    [self cancelOrderWithOrderId:self.orderId cancelReason:reason callback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            [[BBGLoadingTips sharedInstance] showTips:@"取消订单成功"];
            [weakSelf loadOrderDetail];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(refreshOrderList)]) {
                [weakSelf.delegate refreshOrderList];
            }
        }
    }];
}

-(void)confirmOrderWithMemberId:(NSString *)menberId{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    __weak BBGOrderDetailViewController_iPhone *weakSelf = self;
    [self confirmOrderWithOrderId:self.orderId memberId:menberId callback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            [[BBGLoadingTips sharedInstance] showTips:@"确认收货成功"];
            [weakSelf loadOrderDetail];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(refreshOrderList)]) {
                [weakSelf.delegate refreshOrderList];
            }
        }
    }];
}


-(void)deleteOrderWithMemberId:(NSString *)menberId{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    __weak BBGOrderDetailViewController_iPhone *weakSelf = self;
    [self deleteOrderWithOrderId:self.orderId memberId:menberId callback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            [[BBGLoadingTips sharedInstance] showTips:@"删除订单成功"];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(refreshOrderList)]) {
                [weakSelf.delegate refreshOrderList];
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)againPurchaseWithOrderId:(NSString *)orderId{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
        __weak BBGOrderDetailViewController_iPhone *weakSelf = self;
    [self againPurchaseWithOrderId:orderId callback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            //跳转去购物车
            [[BBGLoadingTips sharedInstance] showTips:@"再次购买成功"];
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                [[BBGJumpManager sharedInstance] managerJumpTo:BBGJumpCart];
            }];
            
        }
    }];
    
    
}

//#pragma mark - UITableViewDataSource And UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    
    if (section==0) {
        count = 1;
    }else if (section==1){
        count = 1;
    }else if (section==2){
    
        if (self.isLogistics) {
            count = [self.orderTrackList  count];
        }else{
            count = 1;
        }
    }else if (section==3){
        count = [self.orderInfo.productList count];
    }else if (section==4){
        count = 1;
    }else if (section==5){
        count = 1;
    }
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
   
    if (indexPath.section==0) {
        
        if ([_orderInfo.viewStatus compare:@"wait_pay"] == NSOrderedSame){
            height = 111;
        }else{
            height = 86;
        }
    }else if(indexPath.section==1){
        
        NSString *address = [NSString stringWithFormat:@"%@\n%@  %@",self.orderInfo.shipAddr,self.orderInfo.shopName,self.orderInfo.shipMobile];
        height = [BBGOrderDetailAddressCell_iPhone cellHeightWithContent:address maxWidth:self.tableView.frame.size.width];
    }else if(indexPath.section==2){
        height = 55;
    }else if (indexPath.section ==3){
        height = 75;
    }else if (indexPath.section ==4){
        height = [BBGOrderDetailActiveCell_iPhone cellHeightWithContent:self.orderInfo.pmtStr];
    }else if(indexPath.section == 5){
        
        height = 143;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [self tableView:tableView orderStatusCellForRowAtIndexPath:indexPath];
            return cell;
        }
            break;
        case 1:
        {
            UITableViewCell *cell = [self tableView:tableView orderAddressCellForRowAtIndexPath:indexPath];
            return cell;
        
        }
            break;
        case 2:
        {
            UITableViewCell *cell = [self tableView:tableView orderLogisticsCellForRowAtIndexPath:indexPath];
            return cell;
        
        }
            break;
        case 3:
        {
            UITableViewCell *cell = [self tableView:tableView orderProductCellForRowAtIndexPath:indexPath];
            return cell;
            
        }
            break;
        case 4:
        {
            UITableViewCell *cell = [self tableView:tableView orderActiveCellForRowAtIndexPath:indexPath];
            return cell;
            
        }
            break;
            
        case 5:
        {
            UITableViewCell *cell = [self tableView:tableView orderAmountCellForRowAtIndexPath:indexPath];
            return cell;
            
        }
            break;
            
        default:
            break;
    }
    
    @throw [NSException exceptionWithName:@"BBGOrderDetailViewController_iPhone tableView section 越界" reason:nil userInfo:nil];
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView orderStatusCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"BBGOrderDetailStatusCell_iPhone";
    BBGOrderDetailStatusCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderDetailStatusCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    [cell updateStatusCellWithOrderInfo:self.orderInfo];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView orderAddressCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"BBGOrderDetailAddressCell_iPhone";
    BBGOrderDetailAddressCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderDetailAddressCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *address = [NSString stringWithFormat:@"%@\n%@  %@",self.orderInfo.shipAddr,self.orderInfo.shipName,self.orderInfo.shipMobile];
    [cell updateAddressCellWithAddress:address];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView orderActiveCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"BBGOrderDetailActiveCell_iPhone";
    BBGOrderDetailActiveCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderDetailActiveCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    NSString *payName = @"无";
//    if ([@"wxpay" isEqualToString:self.orderInfo.payment]) {
//        payName = @"微信支付";
//    }else if ([@"aliPay" isEqualToString:self.orderInfo.payment]) {
//        payName = @"支付宝";
//    }else if ([@"upmp" isEqualToString:self.orderInfo.payment]){
//        payName = @"银联手机支付";
//    }
    
//    cell.payTypeLbl.text = payName;
    
    //新增支付方式名字的字段，直接显示
    if (self.orderInfo.paymentName.length > 0) {
        cell.payTypeLbl.text = self.orderInfo.paymentName;
    }else{
        cell.payTypeLbl.text = @"无";
    }
    cell.orderActiveLbl.text = self.orderInfo.pmtStr;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView orderAmountCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"BBGOrderDetailAmountCell_iPhone";
    BBGOrderDetailAmountCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderDetailAmountCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell updateAmountDataWithOrderInfo:self.orderInfo];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView orderLogisticsCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"BBGOrderDetailLogisticsCell_iPhone";
    BBGOrderDetailLogisticsCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderDetailLogisticsCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

    BOOL isLast = NO;
    BOOL isFirst = NO;
    if (indexPath.row==0) {
        isFirst = YES;
    }
    if ([self.orderTrackList count] == (indexPath.row +1)){
        isLast = YES;
    }
    
    if (self.isLogistics) {
        [cell updateLogisticsDataWithTrack:[self.orderTrackList ARRAY_OBJ_AT(indexPath.row)] isLast:isLast isFirst:isFirst];
    }else{
        [cell updateLogisticsDataWithTrack:nil isLast:isLast isFirst:isFirst];
    }
        
    
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView orderProductCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"CellIdentifier";
    BBGOrderListCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderListCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BBGOrderProduct *orderProduct = [self.orderInfo.productList ARRAY_OBJ_AT(indexPath.row)];
    [cell updateOrderCellWithOrder:orderProduct];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        BBGGoodsDetailViewController_iPhone *vc = [[BBGGoodsDetailViewController_iPhone alloc]init] ;
        BBGOrderProduct *orderProduct = [self.orderInfo.productList ARRAY_OBJ_AT(indexPath.row)] ;
        vc.productId = orderProduct.productId ;
        [self.navigationController pushViewController:vc animated:YES] ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView headerView:(NSInteger)section{
  
    if (section==0) {
        return nil;
    }else if(section==1){
        return nil;
    }else if (section==2){
        
        static NSString *identifier = @"BBGOrderDetalIconTitleCell_iPhone";
        BBGOrderDetalIconTitleCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderDetalIconTitleCell_iPhone" owner:nil options:nil]firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.titleLbl.text = @"订单跟踪";
        cell.iconImage.image = [UIImage imageNamed:@"order_logistics"];
        __weak BBGOrderDetailViewController_iPhone *weakSelf = self;
        if (weakSelf.orderInfo.waybillId) {
           cell.numCopyBtn.tintColor = UICOLOR_FONT_IMPORTANT_RED;
            cell.numCopyBtn.hidden = NO;
        } else {
            cell.numCopyBtn.hidden = YES;
        }
        cell.delegate = self;
        return cell;
    }else if (section==3){
        static NSString *identifier = @"BBGOrderDetalIconTitleCell_iPhone";
        BBGOrderDetalIconTitleCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderDetalIconTitleCell_iPhone" owner:nil options:nil]firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.numCopyBtn.hidden = YES;
        cell.titleLbl.text = self.orderInfo.shopName;
        cell.iconImage.image = [UIImage imageNamed:@"店铺icon"];
        return cell;
    }
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView footerView:(NSInteger)section{
   
    if (section==0 || section==2|| section==4|| section==5) {
        return [self createFooterViewWithWidth:tableView.frame.size.width tableView:tableView];
    }
    return nil;
}


-(UITableViewCell *)createFooterViewWithWidth:(CGFloat)width tableView:(UITableView *)tableView{
    
    static NSString *identifier = @"FooterView";
    UITableViewCell *footerView = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (footerView==nil) {
        footerView = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        footerView.backgroundColor = UIColorFromRGB(236, 235, 232);
        footerView.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    footerView.frame = CGRectMake(0, 0, width, 10);
    UIImageView *lineImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, width-10, 1)];
    lineImg1.image = _ResizeImage([UIImage imageNamed:@"HorizontalLine.png"]);
    
    UIImageView *lineIm2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, width-10, 1)];
    lineIm2.image = _ResizeImage([UIImage imageNamed:@"HorizontalLine.png"]);
    [footerView addSubview:lineImg1];
    footerView.selectionStyle = UITableViewCellSelectionStyleNone;
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightOfFooterView:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 10;
    }else if(indexPath.section==1){
        
        return 0;
    }else if (indexPath.section==2 || indexPath.section==4 || indexPath.section==5){
        
        return 10;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightOfHeaderView:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 0;
    }else if (indexPath.section==1){
        return 0;
    }else if (indexPath.section==2){
        return 40;
    }else if (indexPath.section==3){
        return 40;
    }
    
    return 0;
}


-(void)createButtomView{
    
    CGFloat footerViewHeight = 120;
    UIButton *firstBtn;
    UIButton *secondBtn;
    CGRect firstFrame;
    
    if ([self.orderInfo.viewStatus compare:@"wait_pay"] == NSOrderedSame) {
        //待付款
        firstFrame = CGRectMake(10, 10, GETWIDTH(self.tableView)-20, 45);
        firstBtn = [self createFirstBtnWithTitle:@"去付款" frame:firstFrame];
        firstBtn.tag = 1;
    }else if ([self.orderInfo.viewStatus compare:@"paid"] == NSOrderedSame){
        //待发货
        firstFrame = CGRectMake(10, 10, GETWIDTH(self.tableView)-20, 45);
        firstBtn = [self createFirstBtnWithTitle:@"再次购买" frame:firstFrame];
        firstBtn.tag = 2;
    }else if ([self.orderInfo.viewStatus compare:@"finish_send_goods"] == NSOrderedSame || [self.orderInfo.viewStatus compare:@"finish_sign"] == NSOrderedSame){
        //待收货
        firstFrame = CGRectMake(10, 10, GETWIDTH(self.tableView)-20, 45);
        firstBtn = [self createFirstBtnWithTitle:@"确认收货" frame:firstFrame];
        firstBtn.tag = 3;
    }else{
        firstFrame = CGRectMake(10, 10, GETWIDTH(self.tableView)-20, 45);
        firstBtn = [self createFirstBtnWithTitle:@"再次购买" frame:firstFrame];
        firstBtn.tag = 2;
    }

    CGRect secondFrame;
    if (self.orderInfo.allowCancel) {
        secondFrame = CGRectMake(10, GETBOTTOMORIGIN_Y(firstBtn) + 10, GETWIDTH(self.tableView) - 20, 45);
        secondBtn = [self createSecondBtnWithTitle:@"取消订单" frame:secondFrame];
        secondBtn.tag = 1;
        
    }else if (self.orderInfo.allowDelete){
        secondFrame = CGRectMake(10, GETBOTTOMORIGIN_Y(firstBtn) + 10, GETWIDTH(self.tableView) - 20, 45);
        secondBtn = [self createSecondBtnWithTitle:@"删除订单" frame:secondFrame];
        secondBtn.tag = 2;
        
    }else{
        
        if ([self.orderInfo.viewStatus compare:@"finish_send_goods"] == NSOrderedSame || [self.orderInfo.viewStatus compare:@"finish_sign"] == NSOrderedSame){
            secondFrame = CGRectMake(10, GETBOTTOMORIGIN_Y(firstBtn) + 10, GETWIDTH(self.tableView) - 20, 45);
            secondBtn = [self createSecondBtnWithTitle:@"再次购买" frame:secondFrame];
            secondBtn.tag = 3;
        }else{
            footerViewHeight = 65;
        }
    }
    
    if ([self.orderInfo.viewStatus compare:@"wait_pay"] == NSOrderedSame) {
        NSInteger cancelSeconds = self.orderInfo.orderCancelTimeout/1000;
        NSDate *nowDate = [BBGConfiguration sharedInstance].serverTime;
        NSInteger timeout =(int)(cancelSeconds - [nowDate timeIntervalSinceDate:self.orderInfo.orderCreateTime]);
        if (timeout<=0) {
            firstBtn.enabled = NO;
            firstBtn.alpha = 0.7;
            secondBtn.enabled = NO;
            secondBtn.alpha = 0.7;
        }
    }
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GETWIDTH(self.tableView), footerViewHeight)];
    footerView.backgroundColor = UIColorFromRGB(236, 235, 232);
    
    [footerView addSubview:firstBtn];
    if (secondBtn) {
        [footerView addSubview:secondBtn];
    }
     self.tableView.tableFooterView = footerView;
}





-(UIButton *)createFirstBtnWithTitle:(NSString *)title frame:(CGRect)frame{
    
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = frame;
    [firstBtn setBackgroundImage:[[UIImage imageNamed:@"红按钮"] stretchImage] forState:UIControlStateNormal];
    [firstBtn setTitle:title forState:UIControlStateNormal];
    [firstBtn.titleLabel setFont:APP_FONT(17.0)];
    [firstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [firstBtn addTarget:self action:@selector(firstBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return firstBtn;
}

-(UIButton *)createSecondBtnWithTitle:(NSString *)title frame:(CGRect)frame{
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = frame;
    [secondBtn setBackgroundImage:[[UIImage imageNamed:@"白底红框按钮"] stretchImage] forState:UIControlStateNormal];
    [secondBtn setTitle:title forState:UIControlStateNormal];
    [secondBtn.titleLabel setFont:APP_FONT(17.0)];
    [secondBtn setTitleColor:UIColorFromRGB(236, 43, 86) forState:UIControlStateNormal];
    [secondBtn addTarget:self action:@selector(secondBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return secondBtn;
}



-(void)firstBtnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag==1) {
        //去付款
        BBGPayViewController_iPhone *payViewController = [[BBGPayViewController_iPhone alloc] init];
        payViewController.paySource = USERCENTERORDERDETAIL;
        payViewController.delegate = self;
        payViewController.orderIds = [NSMutableArray arrayWithObject:self.orderId];
        [self.navigationController pushViewController:payViewController animated:YES];
    }else if (btn.tag==2) {
        //再次购买
        [BBGAlertView showWithTitle:@"" message:@"确定再次购买？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self againPurchaseWithOrderId:self.orderId];
            }
        } buttonTitles:@"确定", nil];
    }else if (btn.tag==3) {
        //确认收货
        [BBGAlertView showWithTitle:@"" message:@"确定收到商品？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self confirmOrderWithMemberId:self.orderInfo.memberId];
            }
        } buttonTitles:@"确定", nil];
    }
}

-(void)secondBtnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag==1) {
        //取消订单
        [self cancelOrder:nil];
    }else if (btn.tag==2) {
        //删除订单
        [BBGAlertView showWithTitle:@"" message:@"确定删除订单？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self deleteOrderWithMemberId:self.orderInfo.memberId];
            }
        } buttonTitles:@"确定", nil];
    }else if (btn.tag==3) {
        //再次购买
        
        [BBGAlertView showWithTitle:@"" message:@"确定再次购买？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self againPurchaseWithOrderId:self.orderId];
            }
        } buttonTitles:@"确定", nil];
    }
}
#pragma mark  - 复制订单号
- (void)bbgLogisticsNumCopy
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    __weak BBGOrderDetailViewController_iPhone *weakSelf = self;
    if (weakSelf.orderInfo.waybillId) {
        pasteboard.string = weakSelf.orderInfo.waybillId;
        [[BBGLoadingTips sharedInstance]showTips:@"已复制到粘贴板" ];
    }
}

#pragma mark  - 取消订单
-(void)cancelOrder:(id)sender{
    self.reasonView = [[BBGReasonViewController_iPhone alloc] init];
    self.reasonView.reasons = [self loadReasons];
    __weak BBGOrderDetailViewController_iPhone *weakSelf = self;
    [self.reasonView setReasonCallback:^(NSString *reason){
        [weakSelf cancelOrderWithReason:reason];
        NSLog(@"取消订单原因：%@",reason);
    }];
    [self.reasonView show];

}

#pragma mark - 客服电话
-(void)customerService{
    [BBGTools callPhone:@"400-888-8881" alertTitle:@"是否拨打电话号码"];
}

#pragma mark - pay delegate method
-(void)paySuccess{
    [[BBGLoadingTips sharedInstance] showTips:@"订单支付成功"];
    [self loadOrderDetail];
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshOrderList)]) {
        [self.delegate refreshOrderList];
    }
}
-(void)payFailed{
    [[BBGLoadingTips sharedInstance] showTips:@"订单支付失败，请重试"];
}

#pragma mark - countDown delegate method
-(void)countdownFinished{
    [[BBGLoadingTips sharedInstance] showTips:@"订单付款超时，请重新下单购买"];
    self.isRefreshOrderList = YES;
    [self performSelector:@selector(loadOrderDetail) withObject:nil afterDelay:1.0];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.isRefreshOrderList) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(refreshOrderList)]) {
            [self.delegate refreshOrderList];
        }

    }
}

#pragma mark -UIAlertView delegate method
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag==1) {
//        if (buttonIndex==1) {
//            [self confirmOrderWithMemberId:self.orderInfo.memberId];
//        }
//    }else if(alertView.tag==2){
//        if (buttonIndex==1) {
//            [self deleteOrderWithMemberId:self.orderInfo.memberId];
//        }
//    }else if (alertView.tag==3){
//        if (buttonIndex == 1) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.contact]]];
//        }
//    }else if(alertView.tag==4){
//        if (buttonIndex==1) {
//            [self againPurchaseWithOrderId:self.orderId];
//        }
//    }
//    
//}

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
