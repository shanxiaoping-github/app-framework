//
//  BBGGoodsSeckillViewController_iPhone.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsSeckillViewController_iPhone.h"
#import "BBGGSTitleCell.h"
#import "BBGGoodsShopCell.h"
#import "BBGGoodsPlaceCell.h"
#import "BBGGSNotLoginCell.h"
#import "BBGGSExplainCell.h"
#import "BBGGSEmptyCell.h"
#import "BBGSettlementAddressCell_iPhone.h"
#import "BBGSettlementIDCardCell_iPhone.h"
#import "BBGSettlementSectionHeaderView_iPhone.h"
#import "BBGGSAddressHeaderCell.h"
#import "BBGTableBottomCell.h"
#import "BBGGSCountDownView.h"
#import "BBGGDPriceView.h"
#import "BBGGoodsDetailPushImage.h"
#import "BBGGoodsDetailImages.h"
#import "BBGShareManager.h"
#import "BBGGDBuyButton.h"
#import "BBGAddressView.h"
#import "TOCropViewController.h"
#import "BBGGSAddressSelectViewController_iPhone.h"
#import "BBGPayViewController_iPhone.h"


@interface BBGGoodsSeckillViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,BBGAdvViewDataSource,BBGAdvViewDelegate,BBGGSCountDownViewDelegate,SettlementIDCardCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TOCropViewControllerDelegate,BBGGSAddressSelectDelegate> {
    /**
     *  翻页标识
     */
    BOOL isUp;
    /**
     *  tableHeaderView
     */
    UIView *headView;
    /**
     *  回到顶部按钮
     */
    UIButton *returnTop;
    /**
     *  cell储存数组
     */
    NSMutableArray *sectionArr;
    /**
     *  弹窗显示
     */
    BOOL isDisplay;
    /**
     *  头部标识
     */
    BOOL isMark;
}
/**
 *  价格View
 */
@property (nonatomic, strong) BBGGDPriceView *priceView;
/**
 *  买买买倒计时View
 */
@property (nonatomic, strong) BBGGSCountDownView *countDownView;
/**
 *  买买买按钮
 */
@property (nonatomic, strong) BBGGDBuyButton *buyButton;

@property (nonatomic, strong) NSString *reverseImg;
@property (nonatomic, strong) NSString *frontImg;
@property (weak, nonatomic) UIButton *IDCardFrontButton;
@property (weak, nonatomic) UIButton *IDCardBackButton;


@end

@implementation BBGGoodsSeckillViewController_iPhone

#pragma mark - 初始化UI
- (void)initUI {
    /**
     *  初始化需要的数组或状态
     */
    [self getSectionNum];
    
    isUp = YES;
    isDisplay = YES;
    
    self.BBGGoodsSeckill = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-124)] ;
    self.BBGGoodsSeckill.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.BBGGoodsSeckill.delegate = self;
    self.BBGGoodsSeckill.dataSource = self;
    self.BBGGoodsSeckill.backgroundColor = [UIColor clearColor];
    [self.BBGGoodsSeckill addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:@"tableviewY"];
    [self.view addSubview:self.BBGGoodsSeckill];
    
    [self registerCell];
    
    /**
     *  回到顶部按钮
     */
    returnTop = [UIButton buttonWithType:UIButtonTypeCustom];
    returnTop.hidden = YES;
    returnTop.frame = CGRectMake(IPHONE_WIDTH-50, IPHONE_HEIGHT-173, 40, 40);
    [returnTop setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [returnTop setBackgroundImage:[UIImage imageNamed:@"BackToTop"] forState:UIControlStateNormal];
    [returnTop addTarget:self action:@selector(returnTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnTop];
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH)];
    self.BBGGoodsSeckill.tableHeaderView = headView;
    
    /**
     轮播图
     */
    self.pictureView = [[BBGAdvView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH)];
    self.pictureView.dataSource = self;
    self.pictureView.delegate = self;
    self.pictureView.enableAutoPage = NO;
    self.pictureView.focusImage = [[UIImage imageNamed:@"goodsSelect"] stretchImage];
    self.pictureView.pageImage = [[UIImage imageNamed:@"goodsNoSelect"] stretchImage];
    [headView addSubview:self.pictureView];
    
    /**
     *  底部视图
     */
    [self addBottomView];
}

#pragma mark - 注册UITableViewCell
- (void)registerCell {
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGGSTitleCell" bundle:nil] forCellReuseIdentifier:@"BBGGSTitle"];
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGGoodsShopCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsShop"];
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGGoodsPlaceCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsPlace"];
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGGSNotLoginCell" bundle:nil] forCellReuseIdentifier:@"BBGGSNotLogin"];
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGGSExplainCell" bundle:nil] forCellReuseIdentifier:@"BBGGSExplain"];
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGTableBottomCell" bundle:nil] forCellReuseIdentifier:@"BBGTableBottom"];
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGGSEmptyCell" bundle:nil] forCellReuseIdentifier:@"BBGGSEmpty"];
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGSettlementAddressCell_iPhone" bundle:nil] forCellReuseIdentifier:@"BBGSettlementAddressCell"];
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGSettlementIDCardCell_iPhone" bundle:nil] forCellReuseIdentifier:@"BBGSettlementIDCardCell"];
    [self.BBGGoodsSeckill registerNib:[UINib nibWithNibName:@"BBGGSAddressHeaderCell" bundle:nil] forCellReuseIdentifier:@"BBGGSAddressHeaderCell"];
}

#pragma mark - 刷新时间
- (void)reload {
    self.countDownView.isBegin = YES;
}

#pragma mark - 进入联系客服
- (void)getWeb {
    if (![BBGLaunchManager sharedInstance].isOpenContactURL) {
        [BBGTools callPhone:@"400-888-8881" alertTitle:@"当前在线客服系统暂不可用，请电话联系客服。"];
    }else{
        //        BBGNavigationController * nav = (BBGNavigationController *)self.navigationController;
        [self connectServer];
        
    }
    
}

#pragma mark - UITableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGSTitleCell"]) {
        return [BBGGSTitleCell cellHeight:self.basicInfo];
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsShopCell"]) {
        return 120.0f;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsPlaceCell"]) {
        return 87.5f;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGSNotLoginCell"]) {
        return 45.0f;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGSExplainCell"]) {
        return [BBGGSExplainCell cellHeight:self.seckill];
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGTableBottomCell"]) {
        return 36.0f;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGSettlementAddressCell_iPhone"]) {
        float height;
        BBGAddress *address = self.selectedAddress ? self.selectedAddress:[self.addressArr ARRAY_OBJ_AT(0)];
        if (self.seckill.idCheckType == 0) {
            height = [BBGSettlementAddressCell_iPhone cellHeightWithCellType:0];
        }else {
            if ((self.seckill.idCheckType==1)&&(address.idCard.length==0)) {
                height = [BBGSettlementAddressCell_iPhone cellHeightWithCellType:1];
            }else if ((self.seckill.idCheckType==2)&&(address.frontImg.length==0||address.reverseImg.length==0)) {
                height = [BBGSettlementAddressCell_iPhone cellHeightWithCellType:1];
            }else {
                height = [BBGSettlementAddressCell_iPhone cellHeightWithCellType:0];
            }
        }
        return height;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGSettlementIDCardCell_iPhone"]) {
        if (self.seckill.idCheckType ==2) {
            return [BBGSettlementIDCardCell_iPhone cellHeightWithTemp:0];
        }else{
            return [BBGSettlementIDCardCell_iPhone cellHeightWithTemp:1];
        }
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGSAddressHeaderCell"]) {
        return 45.0f;
    }else {
        return 7.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak BBGGoodsSeckillViewController_iPhone *weakSelf = self;
    if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGSTitleCell"]) {
        BBGGSTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGSTitle"];
        [cell updateCellWith:self.basicInfo];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsShopCell"]) {
        BBGGoodsShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsShop"];
        [cell updateCellWith:self.basicInfo];
        [cell handlerButtonAction:^{
            [weakSelf getWeb];
        }];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsPlaceCell"]) {
        BBGGoodsPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsPlace"];
        [cell updateCellWith:self.basicInfo];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGSNotLoginCell"]) {
        BBGGSNotLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGSNotLogin"];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGSExplainCell"]) {
        BBGGSExplainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGSExplain"];
        [cell updateCellWith:self.seckill];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGTableBottomCell"]) {
        BBGTableBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGTableBottom"];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGSettlementAddressCell_iPhone"]) {
        BBGSettlementAddressCell_iPhone *addressCell = [tableView dequeueReusableCellWithIdentifier:@"addressCellIdentifier"];
        BBGAddress *address = self.selectedAddress ? self.selectedAddress:[self.addressArr ARRAY_OBJ_AT(0)];
        if (!addressCell) {
            addressCell = [[[NSBundle mainBundle] loadNibNamed:@"BBGSettlementAddressCell_iPhone" owner:self options:nil] objectAtIndex:0];
        }
        [addressCell updateCellWith:address type:1];
        if (self.seckill.idCheckType == 0) {
            addressCell.submitTipLbl.hidden = YES;
            addressCell.warningImageView.hidden = YES;
        }else {
            if ((self.seckill.idCheckType==1)&&(address.idCard.length==0)) {
                addressCell.submitTipLbl.hidden = NO;
                addressCell.warningImageView.hidden = NO;
                addressCell.submitTipLbl.text = @"请编辑该地址，上传收货人的身份证信息！";
            }else if ((self.seckill.idCheckType==2)&&(address.frontImg.length==0||address.reverseImg.length==0)) {
                addressCell.submitTipLbl.hidden = NO;
                addressCell.warningImageView.hidden = NO;
                addressCell.submitTipLbl.text = @"请编辑该地址，上传收货人的身份证照片！";
            }else {
                addressCell.submitTipLbl.hidden = YES;
                addressCell.warningImageView.hidden = YES;
            }
        }
        addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return addressCell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGSettlementIDCardCell_iPhone"]) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"location"]) {
            if (isDisplay == YES) {
                [BBGAlertView showWithTitle:nil message:@"请开通地理定位功能，以便我们为你定位地区，减化地址输入步骤。" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                    [[BBGRegionManager sharedInstance] startLocation];
                } buttonTitles:@"确定", nil];
                isDisplay = NO;
            }
        }else{
            NSNumber * canLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"location"];
            if (canLocation.integerValue) {
                if ([[BBGRegionManager sharedInstance].province isEqualToString:@""] ||[BBGRegionManager sharedInstance].province == nil) {
                    [[BBGRegionManager sharedInstance] startLocation];
                }
            }
        }
        BBGSettlementIDCardCell_iPhone *idCardCell = [tableView dequeueReusableCellWithIdentifier:@"IDCardCellIdentifier"];
        if (!idCardCell) {
            idCardCell = [[[NSBundle mainBundle] loadNibNamed:@"BBGSettlementIDCardCell_iPhone" owner:self options:nil] firstObject];
            idCardCell.delegate = self;
        }
        self.IDCardFrontButton = idCardCell.IDCardFrontButton;
        self.IDCardBackButton = idCardCell.IDCardBackButton;
        if (self.seckill.idCheckType !=2) {
            idCardCell.IDCardBackButton.alpha=0;
            idCardCell.IDCardFrontButton.alpha=0;
        }
        idCardCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return idCardCell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGSAddressHeaderCell"]) {
        BBGGSAddressHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGSAddressHeaderCell"];
        [cell updateCell:isMark];
        return cell;
    }else {
        BBGGSEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGSEmpty"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak BBGGoodsSeckillViewController_iPhone *weakSelf = self;
    if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGSNotLoginCell"]) {
        [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
            if (successful) {
                [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
                    [weakSelf.bottomView removeFromSuperview];
                    [weakSelf.pictureView reloadData];
                    [weakSelf addBottomView];
                    [weakSelf getSectionNum];
                    [weakSelf.BBGGoodsSeckill reloadData];
                }];
            }
        }];
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGSettlementAddressCell_iPhone"]) {
        BBGGSAddressSelectViewController_iPhone *vc = [[BBGGSAddressSelectViewController_iPhone alloc]init];
        vc.delegate = self;
        vc.selectedAddress = self.selectedAddress ? self.selectedAddress:[self.addressArr ARRAY_OBJ_AT(0)];
        if (self.seckill.idCheckType == 2) {
            vc.mustNeedIdCardPhoto = YES;
        }else {
            vc.mustNeedIdCardPhoto = NO;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - BBGGSAddressSelectDelegate
- (void)getSelectedAddress:(BBGAddress *)address {
    __weak BBGGoodsSeckillViewController_iPhone *weakSelf = self;
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            weakSelf.selectedAddress = address;
            [weakSelf getSectionNum];
            [weakSelf.BBGGoodsSeckill reloadData];
        }
    }];
}

- (void)reloadData {
    __weak BBGGoodsSeckillViewController_iPhone *weakSelf = self;
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            [weakSelf getSectionNum];
            [weakSelf.BBGGoodsSeckill reloadData];
        }
    }];
}

#pragma mark - 分页
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.BBGGoodsSeckill) {
        if (self.webView == nil) {
            self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.BBGGoodsSeckill.contentSize.height, IPHONE_WIDTH, IPHONE_HEIGHT-113)];
            self.webView.scalesPageToFit = YES;
            self.webView.scrollView.bounces = NO;
            self.webView.scrollView.delegate = self;
            [self.webView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:@"webviewY"];
            [self.BBGGoodsSeckill addSubview:self.webView];
        }
        
        NSInteger offsetY = scrollView.contentOffset.y;
        NSInteger offsetH = scrollView.contentSize.height;
        NSInteger reduce = scrollView.contentSize.height - scrollView.frame.size.height;
        NSInteger offsetNum1 = offsetH - offsetY;
        NSInteger offsetNum2 = offsetY+scrollView.frame.size.height - offsetH;
        
        self.webView.frame = CGRectMake(0, self.BBGGoodsSeckill.contentSize.height, IPHONE_WIDTH, IPHONE_HEIGHT-113);
        if ((isUp == YES)&&(offsetY > reduce)&&offsetY < offsetH&&offsetNum2>50) {
            [_webView loadHTMLString:self.basicInfo.intro baseURL:nil];
            [UIView animateWithDuration:0.01 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollTitle" object:@"0"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.4 animations:^{
                    scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentSize.height, 0, 0, 0);
                } completion:^(BOOL finished) {
                    isUp = NO;
                }];
            }];
        }
        if ((isUp == NO)&&(offsetY > reduce)&&offsetY < offsetH&&offsetNum1>50) {
            [UIView animateWithDuration:0.01 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollTitle" object:@"1"];
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.4 animations:^{
                    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                } completion:^(BOOL finished) {
                    isUp = YES;
                }];
            }];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.BBGGoodsSeckill) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGRect frame = self.pictureView.frame;
        if (offsetY < 0) {
            self.pictureView.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH);
            headView.clipsToBounds = YES;
        }
        if (offsetY>0&&offsetY<IPHONE_WIDTH) {
            frame.origin.y = MAX(offsetY*0.5, 0);
            self.pictureView.frame = frame;
            headView.clipsToBounds = YES;
        }
    }
    if (scrollView == _webView.scrollView) {
        if (scrollView.contentOffset.y > 0.8*IPHONE_HEIGHT) {
            returnTop.hidden = NO;
        }else {
            returnTop.hidden = YES;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGFloat y = self.webView.scrollView.contentOffset.y;
    CGFloat tableViewY = self.BBGGoodsSeckill.contentSize.height;
    if (context == @"webviewY") {
        if (y==0) {
            self.BBGGoodsSeckill.scrollEnabled = YES;
        }else {
            self.BBGGoodsSeckill.scrollEnabled = NO;
        }
    }
    if ((context == @"tableviewY")&&(self.webView.scrollView.contentSize.height>IPHONE_HEIGHT)) {
        if (tableViewY<self.BBGGoodsSeckill.contentOffset.y) {
            self.BBGGoodsSeckill.scrollEnabled = NO;
        }else {
            self.BBGGoodsSeckill.scrollEnabled = YES;
        }
    }
}

#pragma mark - 去结算按钮点击事件
- (void)goCheck {
    __weak BBGGoodsSeckillViewController_iPhone *weakSelf = self;
    if ([BBGSession sharedInstance].isLogin) {
        [self fastRequest:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                NSMutableArray *orderIds = [NSMutableArray array];
                [orderIds addObject:weakSelf.fastModel.orderId];
                BBGPayViewController_iPhone *vc = [[BBGPayViewController_iPhone alloc]init];
                vc.orderIds = orderIds;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }];
    }else {
        [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
            if (successful) {
                [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        [weakSelf.bottomView removeFromSuperview];
                        [weakSelf.pictureView reloadData];
                        [weakSelf addBottomView];
                        [weakSelf getSectionNum];
                        [weakSelf.BBGGoodsSeckill reloadData];
                    }
                }];
            }
        }];
    }
}

#pragma mark - 添加底部视图
- (void)addBottomView {
    /**
     底部主视图
     */
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,  IPHONE_HEIGHT-124, IPHONE_WIDTH, 60)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    UIImageView *_separateLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _bottomView.frame.size.width, 1)];
    [_separateLine setImage:[UIImage imageNamed:@"separateLine"]];
    [self.bottomView addSubview:_separateLine];
    
    CGFloat checkWidth = 90.0f/375.0f*IPHONE_WIDTH;
    CGFloat shopWidth = 115.0f/375.0f*IPHONE_WIDTH;
    
    NSTimeInterval start = [self.seckill.startTime longLongValue]/1000;
    NSTimeInterval end = [self.seckill.endTime longLongValue]/1000;
    NSTimeInterval sys = [self.seckill.currentTime longLongValue]/1000;
    NSTimeInterval countdownTime = [self.seckill.countdownTime longLongValue]/1000;
    
    self.priceView = [[BBGGDPriceView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, IPHONE_WIDTH-40-checkWidth-shopWidth, 40.0f)];
    if ([self.seckill.price floatValue]!=0) {
        self.priceView.crossPrice = [NSString stringWithFormat:@"%f",[self.seckill.price floatValue]];
    }
    self.priceView.unCrossPrice = [NSString stringWithFormat:@"%f",[self.seckill.seckillPrice floatValue]];
    [self.bottomView addSubview:self.priceView];
    
    /**
     *  买买买按钮UI
     */
    self.buyButton = [BBGGDBuyButton buttonWithType:UIButtonTypeCustom];
    self.buyButton.frame = CGRectMake(IPHONE_WIDTH-10.0f-checkWidth, 8, checkWidth, 44.0f);
    [self.buyButton addTarget:self action:@selector(goCheck) forControlEvents:UIControlEventTouchUpInside];
    
    if (sys>=start&&sys<end) {
        self.buyButton.status = 0;
        self.buyButton.enabled = YES;
    }else if (sys<start) {
        self.buyButton.status = 1;
        self.buyButton.enabled = NO;
    }else {
        self.buyButton.status = 2;
        self.buyButton.enabled = NO;
    }
    
    [self.bottomView addSubview:self.buyButton];
    /**
     *  买买买倒计时View
     */
    if (start!=0||end!=0) {
        self.countDownView = [[BBGGSCountDownView alloc]initWithFrame:CGRectMake(self.buyButton.frame.origin.x-10.0f-shopWidth, 8, shopWidth, 44.0f)];
        self.countDownView.startTime = start;
        self.countDownView.endTime = end;
        self.countDownView.countdownTime = countdownTime;
        self.countDownView.isBegin = YES;
        self.countDownView.delegate = self;
        [self.bottomView addSubview:self.countDownView];
    }
}

#pragma mark - BBGGSCountDownViewDelegate
- (void)countDownFinish:(NSInteger)status {
    if (status == 0) {
        self.buyButton.status = status;
        self.buyButton.enabled = YES;
    }else {
        self.buyButton.status = status;
        self.buyButton.enabled = NO;
    }
}

#pragma mark - 获取显示的section数
- (void)getSectionNum {
    sectionArr = [NSMutableArray array];
    NSDictionary *dic0 = @{@"Cell": @"BBGGSTitleCell"};
    NSDictionary *dic1 = @{@"Cell": @"BBGGoodsShopCell"};
    NSDictionary *dic2 = @{@"Cell": @"BBGGoodsPlaceCell"};
    NSDictionary *dic4 = @{@"Cell": @"BBGGSExplainCell"};
    NSDictionary *dic5 = @{@"Cell": @"BBGTableBottomCell"};
    NSDictionary *dic6 = @{@"Cell": @"BBGGSEmptyCell"};
    NSDictionary *dic7 = @{@"Cell": @"BBGGSAddressHeaderCell"};
    
    [sectionArr addObject:dic0];
    [sectionArr addObject:dic1];
    [sectionArr addObject:dic2];
    
    if (/*[BBGSession sharedInstance].isLogin*/self.isLogin) {
        if (self.addressArr.count>0) {
            isMark = YES;
            [sectionArr addObject:dic6];
            [sectionArr addObject:dic7];
            NSDictionary *dic3 = @{@"Cell": @"BBGSettlementAddressCell_iPhone"};
            [sectionArr addObject:dic3];
        }else {
            isMark = NO;
            [sectionArr addObject:dic6];
            [sectionArr addObject:dic7];
            NSDictionary *dic3 = @{@"Cell": @"BBGSettlementIDCardCell_iPhone"};
            [sectionArr addObject:dic3];
        }
    }else {
        [sectionArr addObject:dic6];
        NSDictionary *dic3 = @{@"Cell": @"BBGGSNotLoginCell"};
        [sectionArr addObject:dic3];
    }
    
    if (self.seckill.desc.length!=0) {
        if (/*[BBGSession sharedInstance].isLogin*/self.isLogin) {
            [sectionArr addObject:dic6];
            [sectionArr addObject:dic4];
        }else {
            [sectionArr addObject:dic4];
        }
    }
    
    [sectionArr addObject:dic5];
    
}

#pragma mark - SettlementIDCardCellDelegate
- (void)settlementIDCard:(BBGSettlementIDCardCell_iPhone *)addressCell didSelectedType:(BBGSettlementAddressCellSelecteType)selecteType {
    __weak BBGGoodsSeckillViewController_iPhone *weakSelf = self;
    
    if (selecteType == BBGAddressCellSelecteSubmit) {
        self.selectedAddress = addressCell.address;
        self.selectedAddress.frontImg = self.frontImg;
        self.selectedAddress.reverseImg = self.reverseImg;
        
        //需要身份证号码
        if (self.seckill.idCheckType == 1) {
            if ([BBGTools checkStringIsBlank:self.selectedAddress.idCard]) {
                [[BBGLoadingTips sharedInstance] showTips:@"请填写身份证号码"];
                return;
            }
        }
        
        //需要身份证号码和照片
        if (self.seckill.idCheckType == 2) {
            if ([BBGTools checkStringIsBlank:self.selectedAddress.idCard]) {
                [[BBGLoadingTips sharedInstance] showTips:@"请填写身份证号码"];
                return;
            }
            
            if ([BBGTools  checkStringIsBlank:self.frontImg]) {
                [[BBGLoadingTips sharedInstance] showTips:@"请上传身份证正面照片"];
                return;
            }
            
            if ([BBGTools  checkStringIsBlank:self.reverseImg]) {
                [[BBGLoadingTips sharedInstance] showTips:@"请上传身份证反面照片"];
                return;
            }
        }
        
        [self addAddressData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        weakSelf.selectedAddress = [weakSelf.addressArr ARRAY_OBJ_AT(0)];
                        [weakSelf getSectionNum];
                        [weakSelf.BBGGoodsSeckill reloadData];
                    }
                }];
            }
        }];
        
    }else if (selecteType == BBGAddressCellSelecteIDCardFront) {
        self.isChooseIDPhotoBack = NO;
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
        
        
    }else if (selecteType == BBGAddressCellSelecteIDCardBack) {
        self.isChooseIDPhotoBack = YES;
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
        
        
    }else if (selecteType == BBGAddressCellSelecteAreaPicker) {
        
        BBGAddressView * addressView = [[BBGAddressView alloc] initWithRegions:[BBGRegionManager sharedInstance].regionList];
        if ([BBGRegionManager sharedInstance].locationSuccess) {
            NSString *p = [[BBGRegionManager sharedInstance].province substringWithRange:NSMakeRange(0,2)];
            if ([p isEqualToString:@"内蒙"]) {
                p = @"内蒙古";
            }
            if ([p isEqualToString:@"黑龙"]) {
                p = @"黑龙江";
            }
            NSString *c = [BBGRegionManager sharedInstance].city;
            NSString *d = [BBGRegionManager sharedInstance].district;
            NSString *s = @"";
            [addressView showWithProvince:p city:c district:d street:s callback:^(BOOL selected, NSString *p, NSString *c, NSString *d, NSString *s, NSString *pID, NSString *cID, NSString *dID, NSString *sID) {
                if (selected) {
                    addressCell.address.areaInfo = [NSString stringWithFormat:@"%@_%@_%@_%@:%@_%@_%@_%@",p,c,d,s,pID,cID,dID,sID];
                    [addressCell.selectAreaButton setTitle:[NSString stringWithFormat:@"%@_%@_%@_%@",p,c,d,s] forState:UIControlStateNormal];
                    [addressCell.selectAreaButton setTitleColor:UICOLOR_FONT_IMPORTANT_BLACK forState:UIControlStateNormal];
                }
            }];
        }else{
            [addressView show:^(BOOL selected, NSString *p, NSString *c, NSString *d, NSString *s, NSString *pID, NSString *cID, NSString *dID, NSString *sID) {
                if (selected) {
                    addressCell.address.areaInfo = [NSString stringWithFormat:@"%@_%@_%@_%@:%@_%@_%@_%@",p,c,d,s,pID,cID,dID,sID];
                    [addressCell.selectAreaButton setTitle:[NSString stringWithFormat:@"%@_%@_%@_%@",p,c,d,s] forState:UIControlStateNormal];
                    [addressCell.selectAreaButton setTitleColor:UICOLOR_FONT_IMPORTANT_BLACK forState:UIControlStateNormal];
                }
            }];
        }
    }
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }else{
            [BBGAlertView showWithTitle:@"" message:@"抱歉！您的设备没有摄像头" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                
            } buttonTitles: nil];
            return;
        }
    }else if (buttonIndex == 1){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:originImage];
        cropController.delegate = self;
        [self presentViewController:cropController animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated: YES completion:^{
        
    }];
}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle{
    
    image = [image reSizeImage:CGSizeMake(600, 600)];
    WS(ws)
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        [[BBGLoadingTips sharedInstance] showLoading:@"正在上传"];
        [ws AFNetworkUploadIDPhoto:image callBack:^(BOOL sucessful, BBGResponse *response){
            if (sucessful) {
                [[BBGLoadingTips sharedInstance] showTips:@"上传成功"];
                BBGUploadUserHeadResponse *tempResponse = (BBGUploadUserHeadResponse*)response;
                if (ws.isChooseIDPhotoBack) {
                    ws.IDCardBackButton.backgroundColor = UICOLOR_FONT_IMPORTANT_RED;
                    ws.IDCardBackButton.titleLabel.textColor = UICOLOR_BACKGROUND_HILIGHT_GRAY;
                    ws.reverseImg = tempResponse.userHeader.imageId;
                }else{
                    ws.IDCardFrontButton.backgroundColor = UICOLOR_FONT_IMPORTANT_RED;
                    ws.IDCardFrontButton.titleLabel.textColor = UICOLOR_BACKGROUND_HILIGHT_GRAY;
                    ws.frontImg = tempResponse.userHeader.imageId;
                }
            }
        }];
    }];
}

#pragma mark - 返回顶部点击事件
- (void)returnTop {
    [_webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - 分享按钮点击事件
- (void)share {
    NSURL *imageUrl = [NSURL URLWithString:self.basicInfo.goodsImageUrl];
    if(imageUrl){
        self.shareImageView = [[UIImageView alloc] init];
        __weak BBGGoodsSeckillViewController_iPhone *weakSelf = self;
        [BBGShareManager sharedInstance].isBenifit = NO;
        [self.shareImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"Default.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [weakSelf shareToSNSWithImage:image];
        }];
    }else{
        [BBGShareManager sharedInstance].isBenifit = NO;
        [self shareToSNSWithImage:[UIImage imageNamed:@"Default.png"]];
    }
}

- (void)shareToSNSWithImage:(UIImage *)shareImage {
    NSString *shareUrl;
    shareUrl = [NSString stringWithFormat:@"http://m.yunhou.com/item/%@.html",self.basicInfo.productId];
    NSString *shareText = [NSString stringWithFormat:@"今天在百分百正品保证的云猴网发现了一件不错滴东东，伙伴们快去抢购吧..."];
    __weak BBGGoodsSeckillViewController_iPhone *weakSelf = self;
    [[BBGShareManager sharedInstance] shareToSnsSheetView:self shareText:shareText shareImage:shareImage shareToSnsNames:nil shareUrl:shareUrl clickPlatformCallBack:^(NSString *snsName) {
        
        if ([snsName isEqual:@"sina"]) {
            [UMSocialData defaultData].shareText = [NSString stringWithFormat:@"%@,今天在百分百正品保证的云猴网发现了一件不错滴东东，伙伴们快去抢购吧...%@",weakSelf.basicInfo.productName,shareUrl];
        }
        // 朋友圈分享的标题会覆盖内容
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@,今天在100%%正品保证的云猴网发现了一件不错滴东东，伙伴们快去抢购吧...",weakSelf.basicInfo.productName];
        
        [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"%@",weakSelf.basicInfo.productName];
        [UMSocialData defaultData].extConfig.qqData.title = [NSString stringWithFormat:@"%@",weakSelf.basicInfo.productName];
        [UMSocialData defaultData].extConfig.qzoneData.title = [NSString stringWithFormat:@"%@",weakSelf.basicInfo.productName];
        
        /*
         if ([snsName isEqualToString:@"wxtimeline"]) {
         //朋友圈只分享图片
         [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
         }else {
         //微信好友分享标题、缩略图、和url链接
         [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeNone;
         }
         */
    }];
}


#pragma mark - BBGAdvViewDataSource
- (NSInteger)numberOfPagesInAdvView:(BBGAdvView *)advView {
    return self.goodsImagesArr.count;
}

- (UIView *)advView:(BBGAdvView *)advView viewForAdvViewAtPage:(NSInteger)page {
    if (self.goodsImagesArr) {
        UIImageView *filmImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH)];
        filmImageView.contentMode = UIViewContentModeScaleAspectFit;
        BBGGoodsDetailImages *detailImages = [self.goodsImagesArr ARRAY_OBJ_AT(page)];
        [filmImageView sd_setImageWithURL:[NSURL URLWithString:detailImages.imageUrl] placeholderImage:[UIImage imageNamed:@"goodsDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (page == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"imageCompleted" object:nil];
            }
            if (cacheType ==SDImageCacheTypeNone) {
                [filmImageView setFadeInWithDefaultTime];
            }
        }];
        return filmImageView;
    }
    return nil;
}

- (void)advView:(BBGAdvView *)advView didSelectViewAtPage:(NSInteger)page {
    BBGGoodsDetailPushImage *goodsDetailPushImage = [[BBGGoodsDetailPushImage alloc]init];
    goodsDetailPushImage.dataArr = self.goodsImagesArr;
    goodsDetailPushImage.page = page;
    [self presentViewController:goodsDetailPushImage animated:YES completion:^{
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"IndexReloadData" object:nil];
    
    //    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    shareBtn.tag = 16;
    //    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    //    [shareBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    //    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    //    [shareBtn sizeToFit];
    //    shareBtn.titleLabel.font = APP_FONT_DEMI_LIGHT(15.0f);
    //    UIBarButtonItem *shareBarBtn = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    //    self.navigationItem.rightBarButtonItem = shareBarBtn;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)];
    label.text = @"商品秒杀";
    label.font = APP_FONT_DEMI_LIGHT(18.0f);
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    __weak BBGGoodsSeckillViewController_iPhone *weakSelf = self;
    
    if ([BBGSession sharedInstance].isLogin) {
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                [weakSelf initUI];
            }
        }];
    }else {
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                [weakSelf initUI];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.BBGGoodsSeckill removeObserver:self forKeyPath:@"contentOffset"];
    self.BBGGoodsSeckill.delegate = nil;
    self.pictureView.delegate = nil;
    _webView.scrollView.delegate = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"IndexReloadData" object:nil];
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
