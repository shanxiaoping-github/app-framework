//
//  BBGPayViewController_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayViewController_iPhone.h"
#import "BBGPayCenter.h"
#import "BBGPullTable.h"
#import "BBGOrderDetalIconTitleCell_iPhone.h"
#import "BBGPayPmsCell_iPhone.h"
#import "BBGPayOrderInfoCell_iPhone.h"
#import "BBGPayTypeCell_iPhone.h"
#import "BBGCountdownManager.h"
#import "BBGLaternCell.h"
@interface BBGPayViewController_iPhone ()<UITableViewDataSource,PullDelegate,BBGPayTypeCellDelegate,BBGCountdownObserver,BBGPayOrderInfoCellDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) id<BBGPayHandler> payHandler;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (nonatomic,strong) BBGPullTable *tableView;
@property (nonatomic,assign) BOOL isPmsMsg;
@property (nonatomic,strong) NSMutableArray *payTypeList;
@property (nonatomic,strong) BBGPayType *selectedPayType;
@property (nonatomic,strong) BBGPaymentInfo *paymentInfo;
@property (nonatomic,assign) NSInteger timeout;
@property (strong, nonatomic) IBOutlet UILabel *countDownLbl;
@property (nonatomic, strong) BBGPayInfo *payInfo;
@property (nonatomic,strong)BBGPayOrderInfo *selectedOrderInfo;
@property (nonatomic,strong)NSString *pmsMessage;
@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;
@property (nonatomic, strong) NSMutableArray * pmsList;
@end

@implementation BBGPayViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat tableView_Y = GETORIGIN_Y(self.view) + GETHEIGHT(self.topView);
    CGFloat tableView_H = GETHEIGHT(self.view) - tableView_Y;
    self.tableView = [[BBGPullTable alloc] initWithFrame:CGRectMake(0, tableView_Y, GETWIDTH(self.view), tableView_H) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.notOpenSticky = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = UIColorFromRGB(236, 235, 232);
    [self loadPmsMessage];
    [self loadPayType];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}

- (IBAction)dismissView:(id)sender {

    if (self.paySource == CHECKOUTORDER) {
        [BBGAlertView showWithTitle:@"" message:@"确定放弃付款？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } buttonTitles:@"放弃付款", nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



-(void)loadPayType{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    __weak BBGPayViewController_iPhone *weakSelf = self;
    [self getPayTypeWithCallback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            
            BBGPayTypeResponse *payTypeResponse = (BBGPayTypeResponse *)response;
            weakSelf.payTypeList = payTypeResponse.payTypeList;
            if (weakSelf.payTypeList && [weakSelf.payTypeList count]>0) {
                weakSelf.selectedPayType = [weakSelf.payTypeList objectAtIndex:0];
                
            }
            [weakSelf loadPayMentInfo];
            
        }
    }];

}



-(void)loadPayMentInfo{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
     __weak BBGPayViewController_iPhone *weakSelf = self;
    [self getPaymentOrderInfoWithPayType:self.selectedPayType.payCode callback:^(BOOL sucessful, BBGResponse *response) {
       [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            BBGPayInfoResponse *payInfoResponse = (BBGPayInfoResponse *)response;
            weakSelf.paymentInfo = payInfoResponse.paymentInfo;
            if (weakSelf.paymentInfo.tradeInfoList && [weakSelf.paymentInfo.tradeInfoList count]>0) {
                BBGPayOrderInfo *orderInfo = [weakSelf.paymentInfo.tradeInfoList objectAtIndex:0];
                [weakSelf runCountDownWithCancelTime:orderInfo.cancelTimeout createTime:orderInfo.createTime];
            }
            [weakSelf.tableView reloadData];
        }
    }];

}



-(void)loadPaySignInfo{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    __weak BBGPayViewController_iPhone *weakSelf = self;
    [self getPaymentSignInfoWithPayType:self.selectedPayType.payCode orderIds:[NSMutableArray arrayWithObject:self.selectedOrderInfo.tradeNo] callback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            BBGPaySignInfoResponse *payInfoResponse = (BBGPaySignInfoResponse *)response;
            weakSelf.payInfo.info = payInfoResponse.payData;
            [weakSelf gotoPayAction];
            
        }else{
            if (response) {
                [[BBGLoadingTips sharedInstance] showTips:response.errorMsg];
            }
        }
        
        
    }];
    
}


-(void)loadPmsMessage{
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    __weak BBGPayViewController_iPhone *weakSelf = self;
    [self getPmsMessageCallback:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            
            BBGPmsMsgResponse *pmsMsgResponse = (BBGPmsMsgResponse *)response;
            NSMutableArray *pmsList = pmsMsgResponse.pmsList;
            self.pmsList = pmsMsgResponse.pmsList;
            if (pmsList &&[pmsList count]>0) {
                weakSelf.isPmsMsg = YES;
            }else{
                weakSelf.isPmsMsg = NO;
            }
            
        }
    }];

}


#pragma mark -BBGPayTypeCellDelegate delegate method
- (void)payTypeDidChange:(BBGPayType *)payType{

    if (![payType.payCode isEqualToString:self.selectedPayType.payCode]) {
        self.selectedPayType = payType;
        [self loadPayMentInfo];
    }

}

//#pragma mark - UITableViewDataSource And UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.paymentInfo) {
        return 0;
    }
    
    if (self.isPmsMsg) {
        return 3;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    
    if (self.isPmsMsg) {
        
        if (section==0) {
            
            count = 0;
        }else if (section==1){
            
            count = 1;
        }else if (section==2){
            count = [self.paymentInfo.tradeInfoList count];
        }
        
    }else{
        if (section==0){
            count = 1;
        }else if (section==1){
            count = [self.paymentInfo.tradeInfoList count];
        }
    }
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 75;
    if (self.isPmsMsg) {
        
        if (indexPath.section==0) {
            
            height = 0;
        }else if (indexPath.section==1){
            
            height = 109;
        }else if (indexPath.section==2){
            height = 100;
        }
        
    }else{
        if (indexPath.section==0){
            height = 109;
        }else if (indexPath.section==1){
            height = 100;
        }
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.isPmsMsg) {
        
        if (indexPath.section==1){
            return [self tableView:tableView payTypeCellForRowAtIndexPath:indexPath];
        }else if (indexPath.section==2){
            return [self tableView:tableView payOrderInfoCellForRowAtIndexPath:indexPath];
        }
        
    }else{
        if (indexPath.section==0){
            return [self tableView:tableView payTypeCellForRowAtIndexPath:indexPath];
        }else if (indexPath.section==1){
            return [self tableView:tableView payOrderInfoCellForRowAtIndexPath:indexPath];
        }
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView payTypeCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSString *identifier = @"BBGPayTypeCell_iPhone";
    BBGPayTypeCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGPayTypeCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateSubViewsFrameWithWidth:self.tableView.frame.size.width];
    }
    cell.delegate = self;
    [cell updatePayTypeCellWithPayTypes:self.payTypeList selectedPayType:self.selectedPayType];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView payOrderInfoCellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *identifier = @"BBGPayOrderInfoCell_iPhone";
    BBGPayOrderInfoCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGPayOrderInfoCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    if (self.paymentInfo.tradeInfoList && [self.paymentInfo.tradeInfoList count]>indexPath.row) {
        [cell updateOrderInfoCellWith:[self.paymentInfo.tradeInfoList objectAtIndex:indexPath.row]];
    }

    
    return cell;
}


- (UITableViewCell *)createTitleIconView{
    BBGOrderDetalIconTitleCell_iPhone *cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGOrderDetalIconTitleCell_iPhone" owner:nil options:nil]firstObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLbl.text = @"选择付款方式";
    cell.titleLbl.textColor = UIColorFromRGB(236, 18, 82);
    cell.iconImage.image = [UIImage imageNamed:@"支付方式"];
    return cell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView headerView:(NSInteger)section{
   
    
    if (self.isPmsMsg) {
        
        if (section==0) {
            BBGLaternCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BBGLaternCell"];
            if(cell == nil){
                cell = [[BBGLaternCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBGLaternCell"];
            }
            [cell updateCell:self.pmsList];
            
//            BBGPayPmsCell_iPhone *cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGPayPmsCell_iPhone" owner:nil options:nil]firstObject];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.pmsMsgLbl.text = self.pmsMessage;
            return cell;
            
        }else if (section==1){
            
            return [self createTitleIconView];
        }
        
    }else{
        if (section==0){
            return [self createTitleIconView];
        }
    }
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView footerView:(NSInteger)section{
    
    if (self.isPmsMsg) {
        if (section==0||section==1) {
            return [self createFooterViewWithWidth:tableView.frame.size.width];
        }
    }else{
        if (section==0) {
            return [self createFooterViewWithWidth:tableView.frame.size.width];
        }

    }
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightOfHeaderView:(NSIndexPath *)indexPath{
    if (self.isPmsMsg) {
        
        if (indexPath.section==0) {
            return 33;
            
        }else if (indexPath.section==1){
            return 40;
        }
        
    }else{
        if (indexPath.section==0){
            return 40;
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightOfFooterView:(NSIndexPath *)indexPath{
    if (self.isPmsMsg) {
        if (indexPath.section==0||indexPath.section==1) {
            return 10;
        }
    }else{
        if (indexPath.section==0) {
            return 10;
        }
        
    }
    return 0;
}

-(UITableViewCell *)createFooterViewWithWidth:(CGFloat)width{
    
    UITableViewCell *footerView = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, width, 10)];
    footerView.backgroundColor = UIColorFromRGB(236, 235, 232);
    footerView.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *lineImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, width-10, 1)];
    lineImg1.image = _ResizeImage([UIImage imageNamed:@"HorizontalLine.png"]);
    
    UIImageView *lineIm2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, width-10, 1)];
    lineIm2.image = _ResizeImage([UIImage imageNamed:@"HorizontalLine.png"]);
    [footerView addSubview:lineImg1];
    footerView.selectionStyle = UITableViewCellSelectionStyleNone;
    return footerView;
}


#pragma mark - gotoPay delegate method
- (void)gotoPayWithOrderInfo:(BBGPayOrderInfo *)orderInfo{
    self.selectedOrderInfo = orderInfo;
    self.payInfo = [[BBGPayInfo alloc] init];
    self.payInfo.orderId = orderInfo.tradeNo;
    self.payInfo.paymentID = self.selectedPayType.payCode;
    [self loadPaySignInfo];
}



- (void)gotoPayAction{
    //支付信息

    self.payHandler = [[BBGPayCenter sharedInstance] buildPayHandlerWith:self.payInfo viewController:self];
    
    //支付结果回调block
    [[BBGPayCenter sharedInstance] setResultAction:^(BBGPayResult result) {
        
        switch (result) {
            case BBGPayResultAlixpaySuccess:
            {
                [self paySuccess];
            }
                break;
            case BBGPayResultAlixpayFailed:
            {
                [self payFailed];
            }
                break;
            case BBGPayResultAlixpayCancel:
            {
                [self payFailed];
            }
                break;
            case BBGPayResultWeChatPaySuccess:
            {
                [self paySuccess];
            }
                break;
            case BBGPayResultWeChatPayFailed:
            {
                [self payFailed];
            }
                break;
            case BBGPayResultWeChatPayCancel:
            {
                [self payFailed];
            }
                break;
            case BBGPayResultUnionPaySuccess:
            {
                [self paySuccess];
            }
                break;
            case BBGPayResultUnionPayFailed:
            {
                [self payFailed];
            }
                break;
            case BBGPayResultUnionPayCancel:
            {
                [self payFailed];
            }
                break;
            default:
                break;
            }
    }];
    //支付
    [self.payHandler goPay];
    
}

#pragma mark -  BBGPayViewDelegate
- (void)paySuccess {
    
    BOOL isUnpaid = NO;//标记是否存在未支付的订单
    
    if ([self.paymentInfo.tradeInfoList count]>1) {
        isUnpaid = YES;
        for (BBGPayOrderInfo * orderInfo in  self.paymentInfo.tradeInfoList) {
            if ([orderInfo.tradeNo isEqualToString:self.payInfo.orderId]) {
                [self.paymentInfo.tradeInfoList removeObject:orderInfo];
                break;
            }
        }
    }
    
    [self.tableView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(paySuccess)]) {
        [self.delegate paySuccess];
    }
    
    if (!isUnpaid) {
        //跳转去支付成功页
        [[BBGLoadingTips sharedInstance] showTips:@"全部订单支付成功"];
        BBGPayCompleteViewController_iPhone *payCompleteViewController = [[BBGPayCompleteViewController_iPhone alloc] init];
        payCompleteViewController.paySource = self.paySource;
        payCompleteViewController.orderId = self.payInfo.orderId;
        [self.navigationController pushViewController:payCompleteViewController animated:YES];
        
    }else{
        
        //支付一笔订单 则将订单列表的OrderID移除
        NSInteger index = 0;
        for (int i=0; i<[self.orderIds count]; i++) {
            NSString *orderId = [self.orderIds objectAtIndex:i];
            if ([self.payInfo.orderId isEqualToString:orderId]) {
                index = i;
                break;
            }
        }
        [self.orderIds removeObjectAtIndex:index];
        
        //还有订单未支付
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"订单：%@支付成功，请继续支付剩下的订单",self.payInfo.orderId] delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alertView show];
        [self.tableView reloadData];
    }
    
}

- (void)payFailed {
    [[BBGLoadingTips sharedInstance] showTips:@"支付失败！"];
}

- (void)runCountDownWithCancelTime:(NSInteger)cancelTime createTime:(NSDate *)createTime{
//    _timeout = (int)(ceil([initialEndDate timeIntervalSinceDate:[NSDate date]]));
    NSInteger cancelSeconds = cancelTime/1000;
    NSDate *nowDate = [BBGConfiguration sharedInstance].serverTime;
    _timeout =(int)(cancelSeconds - [nowDate timeIntervalSinceDate:createTime]);
    if (_timeout >= 0) {
        NSInteger hour = _timeout / (60 * 60);
        NSInteger minute = (_timeout % (60 * 60)) / 60;
        NSInteger seconds = (_timeout % (60 * 60)) % 60;
        _countDownLbl.text = [NSString stringWithFormat:@"%ld%ld : %ld%ld : %ld%ld",(long)hour/10,(long)hour%10,(long)minute/10,(long)minute%10,(long)seconds/10,(long)seconds%10];
        _InfoLabel.height = 28;
        _InfoLabel.text = @"订单已提交成功请尽快付款.倒计时结束后未付款,订单自动取消.";
        [[BBGCountdownManager sharedInstance] addObserver:self];
    }
}

#pragma mark -
- (void)countdown{
    if (_timeout <= 0) {
        [[BBGCountdownManager sharedInstance] removeObserver:self];
        [[BBGLoadingTips sharedInstance] showTips:@"订单付款已超时，请重新下单购买！"];
        if (self.paySource==CHECKOUTORDER) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    NSInteger hour = _timeout / (60 * 60);
    NSInteger minute = (_timeout % (60 * 60)) / 60;
    NSInteger seconds = (_timeout % (60 * 60)) % 60;
    _countDownLbl.text = [NSString stringWithFormat:@"%ld%ld : %ld%ld : %ld%ld",(long)hour/10,(long)hour%10,(long)minute/10,(long)minute%10,(long)seconds/10,(long)seconds%10];
    _timeout--;
}



-(void)dealloc{
    [[BBGCountdownManager sharedInstance] removeObserver:self];
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
