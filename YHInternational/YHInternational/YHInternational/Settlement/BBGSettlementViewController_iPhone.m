//
//  BBGSettlementViewController_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlementViewController_iPhone.h"
#import "BBGSettlementPacket.h"
#import "BBGSettlementSectionHeaderView_iPhone.h"
#import "BBGSettlementListCell_iPhone.h"
#import "BBGSettlementAddressCell_iPhone.h"
#import "BBGSettlementSectionFooterView_iPhone.h"
#import "BBGPayViewController_iPhone.h"
#import "BBGSelectAddressViewController_iPhone.h"
#import "BBGAddressView.h"
#import "BBGUseCouponViewController_iPhone.h"
#import "BBGSettlementFooterCell_iPhone.h"
#import "BBGSettlementIDCardCell_iPhone.h"
#import "BBGFoldableFunctionCell_iPhone.h"
#import "BBGSpecialWebViewController_iPhone.h"
#import "TOCropViewController.h"

@interface BBGSettlementViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SettlementSectionFooterViewDelegate,SettlementIDCardCellDelegate,PullDelegate,SettlementSectionFooterCellDelegate,SettlementFoldableCellDelegate,TOCropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet BBGPullTable *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalRealPrice;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) BBGSettlementSectionFooterView_iPhone *tableFootView;
@property (nonatomic, assign) BOOL useCouponData;
@property (nonatomic, strong) NSString *reverseImg;
@property (nonatomic, strong) NSString *frontImg;
@property (weak, nonatomic) UIButton *IDCardFrontButton;
@property (weak, nonatomic) UIButton *IDCardBackButton;
/**
 *  商品列表折叠展开逻辑数组
 *  0：折叠
 *  1：展开
 *  2:不支持折叠展开（商品数少于2）
 */
@property (strong, nonatomic) NSMutableArray *foldableArray;

@end

@implementation BBGSettlementViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"结算" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    //联系客服入口
    [self createRightBarButtonItemWithTarget:self action:@selector(toCustomerService)
                                       title:@"联系客服" titleColor:UIColorFromRGB(236, 43, 86)];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.notOpenSticky = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.pullDelegate = self;
    self.submitButton.layer.masksToBounds = YES;
    self.submitButton.layer.cornerRadius = 3.0;
    self.tableView.backgroundColor = [UIColor clearColor];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    if (_useCouponData) {
        _useCouponData=NO;
    }else{
        [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];

        WS(weakSelf);
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                
                //更新cell折叠标识符
                [weakSelf updateCellFolderStatus];

                _totalRealPrice.text = [NSString stringWithFormat:@"￥%0.2f",self.settlement.totalRealPrice/100.0];
                if (!_tableFootView) {
                    _tableFootView = [[[NSBundle mainBundle] loadNibNamed:@"BBGSettlementSectionFooterView_iPhone" owner:self options:nil] objectAtIndex:0];
                    _tableView.tableFooterView = _tableFootView;
                }
                
                _tableFootView.settlement = self.settlement;
                [_tableView reloadData];
            }
            [[BBGLoadingTips sharedInstance] hideTips];

        }];
    }
}

- (void)toCustomerService {
    
    if (![BBGLaunchManager sharedInstance].isOpenContactURL) {
        [BBGTools callPhone:@"400-888-8881" alertTitle:@"当前在线客服系统暂不可用，请电话联系客服。"];
    }else{
        [self connectServer];
    }
}

- (IBAction)submitToOrder:(UIButton *)sender {
    if (self.settlement.submitCheckTag != 0) {
        [[BBGLoadingTips sharedInstance] showTips:self.settlement.tip];
        return;
    }
    
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self submitOrderData:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            BBGPayViewController_iPhone *pay = [[BBGPayViewController_iPhone alloc] init];
            pay.paySource = CHECKOUTORDER;
            pay.orderIds = self.orderIdList;
            [self.navigationController pushViewController:pay animated:YES];
        }
        [[BBGLoadingTips sharedInstance] hideTips];

    }];
}

# pragma mark - SettlementSectionFooterCellDelegate

- (void)settlementSectionFooterCell:(BBGSettlementFooterCell_iPhone *)footerView didSelectedAtIndex:(NSInteger)index {

    BBGSettlementPacket *packet = [self.settlement.groups ARRAY_OBJ_AT(index-1)];
    
    __weak BBGSettlementViewController_iPhone *weakSelf = self;
    BBGUseCouponViewController_iPhone * useCouponViewController = [[BBGUseCouponViewController_iPhone alloc] initWithCallback:^(BOOL successful, id response) {
        if (successful) {
            BBGSettlementResponse *responseData = (BBGSettlementResponse *)response;
            weakSelf.settlement = responseData.settlement;
            _totalRealPrice.text = [NSString stringWithFormat:@"￥%0.2f",self.settlement.totalRealPrice/100.0];
            _tableFootView.settlement = responseData.settlement;
            [weakSelf.tableView reloadData];
        }
    }];
    useCouponViewController.shopId = packet.shopId;
    useCouponViewController.selectedCoupon = packet.userCoupon;
    weakSelf.useCouponData=YES;

    if (self.buyType == BBGBuyTypeNormal) {
        useCouponViewController.buyType = @"normal";
    }else if (self.buyType == BBGBuyTypeGroup){
        useCouponViewController.buyType = @"";
    }else{
        useCouponViewController.buyType = @"";
    }
    [self.navigationController pushViewController:useCouponViewController animated:YES];

}

#pragma mark- SettlementSectionFooterViewDelegate
- (void)settlementSectionFooterView:(BBGSettlementSectionFooterView_iPhone *)footerView didSelectedAtIndex:(NSInteger)index {
    BBGSettlementPacket *packet = [self.settlement.groups ARRAY_OBJ_AT(index-1)];

    __weak BBGSettlementViewController_iPhone *weakSelf = self;
    BBGUseCouponViewController_iPhone * useCouponViewController = [[BBGUseCouponViewController_iPhone alloc]initWithCallback:^(BOOL successful, id response) {
        if (successful) {
            BBGSettlementResponse *responseData = (BBGSettlementResponse *)response;
            weakSelf.settlement = responseData.settlement;
            _totalRealPrice.text = [NSString stringWithFormat:@"￥%0.2f",self.settlement.totalRealPrice/100.0];
            _tableFootView.settlement = responseData.settlement;
            [weakSelf.tableView reloadData];
        }
    }];

    useCouponViewController.shopId = packet.shopId;
    useCouponViewController.selectedCoupon = packet.userCoupon;
    weakSelf.useCouponData=YES;

    if (self.buyType == BBGBuyTypeNormal) {
        useCouponViewController.buyType = @"normal";
    }else if (self.buyType == BBGBuyTypeGroup){
        useCouponViewController.buyType = @"";
    }else{
        useCouponViewController.buyType = @"";
    }
    [self.navigationController pushViewController:useCouponViewController animated:YES];
}

- (void)updateCellFolderStatus {

    //商品折叠展开逻辑数组，默认全部折叠
    if (!self.foldableArray) {
        _foldableArray = [NSMutableArray array];
    }else {
        [_foldableArray removeAllObjects];
    }
    
    for (BBGSettlementPacket *packet in self.settlement.groups) {
        if (packet.products.count > 2) {
            [self.foldableArray addObject:[NSNumber numberWithInt:0]];
        }else {
            [self.foldableArray addObject:[NSNumber numberWithInt:2]];
        }
    }

}

#pragma mark- SettlementIDCardCellDelegate
- (void)settlementIDCard:(BBGSettlementIDCardCell_iPhone *)addressCell didSelectedType:(BBGSettlementAddressCellSelecteType)selecteType {

    __weak BBGSettlementViewController_iPhone *weakSelf = self;
    
    if (selecteType == BBGAddressCellSelecteSubmit) {
        self.selectedAddress = addressCell.address;
        self.selectedAddress.frontImg = self.frontImg;
        self.selectedAddress.reverseImg = self.reverseImg;
        
        //需要身份证号码
        if (self.settlement.idCheckType == 1) {
            if ([BBGTools checkStringIsBlank:self.selectedAddress.idCard]) {
                [[BBGLoadingTips sharedInstance] showTips:@"请填写身份证号码"];
                return;
            }
        }
        
        //需要身份证号码和照片
        if (self.settlement.idCheckType == 2) {
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
                        
                        //更新cell折叠标识符
                        [weakSelf updateCellFolderStatus];
                        [weakSelf.tableView reloadData];
                    }
                }];
            }else {
                
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

#pragma mark- SettlementFoldableCellDelegate

- (void)foldableCell:(BBGFoldableFunctionCell_iPhone *)foldableCell didSelectAtIndexPath:(NSIndexPath *)indexPath {
    int foldTag = [[self.foldableArray ARRAY_OBJ_AT(indexPath.section-1)] intValue];
    BBGSettlementPacket *packet = [self.settlement.groups ARRAY_OBJ_AT(indexPath.section-1)];
    
    if (foldTag == 0) {
        //更新折叠状态为展开
        foldTag = 1;
        [self.foldableArray replaceObjectAtIndex:indexPath.section-1 withObject:[NSNumber numberWithInt:foldTag]];

        //当前为折叠状态,走展开逻辑
        NSMutableArray *insertArray = [NSMutableArray array];
        for (int i = 3; i < packet.products.count+1; i++) {
            [insertArray addObject:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
        }

        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:packet.products.count+1 inSection:indexPath.section];
        BBGFoldableFunctionCell_iPhone *cell = (BBGFoldableFunctionCell_iPhone *)[self.tableView cellForRowAtIndexPath:path];
        cell.descriptionLabel.text = @"收起所有商品";

    }else if (foldTag == 1) {
        //更新展开状态为折叠
        foldTag = 0;
        [self.foldableArray replaceObjectAtIndex:indexPath.section-1 withObject:[NSNumber numberWithInt:foldTag]];
        
        //当前为展开状态,走折叠逻辑
        NSMutableArray *insertArray = [NSMutableArray array];
        for (int i = 3; i < packet.products.count+1; i++) {
            [insertArray addObject:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
        }

        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:indexPath.section];
        BBGFoldableFunctionCell_iPhone *cell = (BBGFoldableFunctionCell_iPhone *)[self.tableView cellForRowAtIndexPath:path];
        cell.descriptionLabel.text = @"展开所有商品";
    }

}

#pragma mark- UITableViewDataSource

- (CGFloat)tableView:(BBGTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    if (indexPath.section == 0) {
        float height;
        if (self.settlement.addressList.count > 0) {
            if (self.settlement.submitCheckTag != 0) {
                height = [BBGSettlementAddressCell_iPhone cellHeightWithCellType:1];
            }else {
                height = [BBGSettlementAddressCell_iPhone cellHeightWithCellType:0];
            }
            return height;
        }else {
            if (self.settlement.idCheckType ==2) {
                return [BBGSettlementIDCardCell_iPhone cellHeightWithTemp:0];
            }else{
                return [BBGSettlementIDCardCell_iPhone cellHeightWithTemp:1];
            }
            
        }
    }else {
        BBGSettlementPacket *packet= [self.settlement.groups ARRAY_OBJ_AT(indexPath.section-1)];
        int foldTag = [[self.foldableArray ARRAY_OBJ_AT(indexPath.section-1)] intValue];

        if (packet.products.count > 2) {
            if (foldTag == 0 && indexPath.row == 2) {
                return 38;
            }
            
            if (foldTag == 1 && indexPath.row == packet.products.count) {
                return 38;
            }
        }
        return 75;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightOfHeaderView:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 50;
    }else {
        return 40;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView headerView:(NSInteger)section {

    UIView *headerView = nil;
    if (section == 0) {
        
        //地址header
        headerView = [[[NSBundle mainBundle] loadNibNamed:@"BBGSettlementSectionHeaderView_iPhone" owner:self options:nil] objectAtIndex:0];
        if(self.settlement.addressList.count > 0)
        {
            [(BBGSettlementSectionHeaderView_iPhone*)headerView addressTitle].text = @"收货地址";
        }
    }else {
        
        if (self.settlement.unablePacket && section == tableView.numberOfSections-1) {
            //无法配送header
            headerView = [[[NSBundle mainBundle] loadNibNamed:@"BBGSettlementSectionHeaderView_iPhone" owner:self options:nil] objectAtIndex:2];
        }else {
            //店铺header
            BBGSettlementSectionHeaderView_iPhone *view = [[[NSBundle mainBundle] loadNibNamed:@"BBGSettlementSectionHeaderView_iPhone" owner:self options:nil] objectAtIndex:1];
            if (self.settlement) {
                BBGSettlementPacket *packet = [self.settlement.groups ARRAY_OBJ_AT(section-1)];
                view.titleLabel.text = packet.shopName;
            }
            headerView = view;
        }
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerView.frame.size.width)];
    [cell addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell).with.offset(0);
        make.right.equalTo(cell).with.offset(0);
        make.top.equalTo(cell).with.offset(0);
        make.bottom.equalTo(cell).with.offset(0);
    }];

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightOfFooterView:(NSIndexPath *)indexPath {

    if (indexPath.section !=0) {
        if (self.settlement.unablePacket && indexPath.section == tableView.numberOfSections-1) {
            return 0;
        }
        BBGSettlementPacket *settlementPacket = [self.settlement.groups ARRAY_OBJ_AT(indexPath.section-1)];
        CGFloat height = settlementPacket.promotions.count*20+75.0;
        return height;
    }
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView footerView:(NSInteger)section {

    if (section == 0) {
        return nil;
    }else {
        if (self.settlement.unablePacket && section == tableView.numberOfSections-1) {
            return nil;
        }

        BBGSettlementFooterCell_iPhone *footCell = [[[NSBundle mainBundle] loadNibNamed:@"BBGSettlementFooterCell_iPhone" owner:self options:nil] firstObject];
        footCell.delegate = self;
        footCell.settlement = self.settlement;
        [footCell updateFooterViewWith:section];
        return footCell;
    }
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(BBGTableView *)tableView {

    if (self.settlement) {
        NSInteger count = 1;
        if (self.settlement.groups.count>0) {
            count += self.settlement.groups.count;
        }
        
        if (self.settlement.unablePacket) {
            count += 1;
        }
        return count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.settlement) {
        if (section == 0) {
            return 1;
        }else {
            if (self.settlement.unablePacket && section == tableView.numberOfSections-1) {
                return self.settlement.unablePacket.products.count;
            }else {
                int foldTag = [[self.foldableArray ARRAY_OBJ_AT(section-1)] intValue];
                if (foldTag == 0) {
                    return 3;
                }else if (foldTag == 1) {
                    BBGSettlementPacket *packet = [self.settlement.groups ARRAY_OBJ_AT(section-1)];
                    return packet.products.count + 1;
                }else {
                    BBGSettlementPacket *packet = [self.settlement.groups ARRAY_OBJ_AT(section-1)];
                    return packet.products.count;
                }
            }
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //地址相关样式
    if (indexPath.section == 0) {
        if (self.settlement.addressList.count > 0) {
            BBGSettlementAddressCell_iPhone *addressCell = [tableView dequeueReusableCellWithIdentifier:@"addressCellIdentifier"];
            BBGAddress *address = self.selectedAddress ? self.selectedAddress:[self.settlement.addressList ARRAY_OBJ_AT(0)];
            if (!addressCell) {
                addressCell = [[[NSBundle mainBundle] loadNibNamed:@"BBGSettlementAddressCell_iPhone" owner:self options:nil] objectAtIndex:0];
            }
            if (self.settlement.submitCheckTag == 3 || self.settlement.submitCheckTag == 5 || self.settlement.submitCheckTag == 6) {
                [addressCell updateCellWith:address type:1];
                if (self.settlement.submitCheckTag == 3) {
                    addressCell.submitTipLbl.text = @"请编辑该地址，上传收货人的身份证信息！";
                }else {
                    addressCell.submitTipLbl.text = @"请编辑该地址，上传收货人的身份证照片！";
                }
                addressCell.submitTipLbl.hidden = NO;
                addressCell.warningImageView.hidden = NO;
            }else {
                [addressCell updateCellWith:address type:0];
                addressCell.submitTipLbl.hidden = YES;
                addressCell.warningImageView.hidden = YES;
            }

            return addressCell;

        }else {
            //新增地址
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"location"]) {
                [BBGAlertView showWithTitle:nil message:@"请打开定位功能，我们将定位地区，以简化地址输入" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                    [[BBGRegionManager sharedInstance] startLocation];
                } buttonTitles:@"确定", nil];
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
            idCardCell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.IDCardFrontButton = idCardCell.IDCardFrontButton;
            self.IDCardBackButton = idCardCell.IDCardBackButton;
            if (self.settlement.idCheckType !=2) {
                idCardCell.IDCardBackButton.alpha=0;
                idCardCell.IDCardFrontButton.alpha=0;
            }
            return idCardCell;
        }
        
    }else {
        
        //展示商品信息cell
        [tableView registerNib:[UINib nibWithNibName:@"BBGSettlementListCell_iPhone" bundle:nil] forCellReuseIdentifier:@"productCellIdentifier"];
        BBGSettlementListCell_iPhone *productCell = [tableView dequeueReusableCellWithIdentifier:@"productCellIdentifier"];
        if (!productCell) {
            productCell = [[[NSBundle mainBundle] loadNibNamed:@"BBGSettlementListCell_iPhone" owner:self options:nil] objectAtIndex:0];
        }
        productCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //查看全部商品cell（提供折叠展开功能）
        [tableView registerNib:[UINib nibWithNibName:@"BBGFoldableFunctionCell_iPhone" bundle:nil] forCellReuseIdentifier:@"foldableCellIdentifier"];
        BBGFoldableFunctionCell_iPhone *foldableCell = [tableView dequeueReusableCellWithIdentifier:@"foldableCellIdentifier"];
        if (!foldableCell) {
            foldableCell = [[[NSBundle mainBundle] loadNibNamed:@"BBGFoldableFunctionCell_iPhone" owner:self options:nil] objectAtIndex:0];
        }
        foldableCell.delegate = self;
        foldableCell.indexPath = indexPath;
        
        if (self.settlement.unablePacket &&indexPath.section == tableView.numberOfSections-1) {
            
            //The last section 显示无法配送商品
            BBGCartProduct *product = [self.settlement.unablePacket.products ARRAY_OBJ_AT(indexPath.row)];
            [productCell updateCellWith:product];
            return productCell;
        }else {
            BBGSettlementPacket *packet= [self.settlement.groups ARRAY_OBJ_AT(indexPath.section-1)];
            int foldTag = [[self.foldableArray ARRAY_OBJ_AT(indexPath.section-1)] intValue];
//
//            if (packet.products.count > 2) {
//                if (foldTag == 0 && indexPath.row == 2) {
//                    foldableCell.descriptionLabel.text = @"展开所有商品";
//                    return foldableCell;
//                }
//                
//                if (foldTag == 1 && indexPath.row == packet.products.count) {
//                    foldableCell.descriptionLabel.text = @"收起所有商品";
//                    return foldableCell;
//                }
//            }
            
            //BBGPullTable通过用Cell替代headerView和footterView实现了不停留功能，所以此处判断是否最后一行要减3而不是减1
            if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-3) {
                if (foldTag == 0) {
                    foldableCell.descriptionLabel.text = @"展开所有商品";
                    return foldableCell;
                }else if (foldTag == 1) {
                    foldableCell.descriptionLabel.text = @"收起所有商品";
                    return foldableCell;
                }
            }

            BBGCartProduct *product = [packet.products ARRAY_OBJ_AT(indexPath.row)];
            [productCell updateCellWith:product];
            return productCell;
        }
    }
    return nil;
}

#pragma mark- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section==0 && indexPath.row==0 && self.settlement.addressList.count>0) {
        __weak BBGSettlementViewController_iPhone *weakSelf = self;
        BBGSelectAddressViewController_iPhone *address = [[BBGSelectAddressViewController_iPhone alloc] initWithSettlementCallBack:^(BOOL sucessful, BBGSettlement *settlement) {
            if (sucessful) {
                
                weakSelf.settlement = settlement;
                _tableFootView.settlement = settlement;
                _totalRealPrice.text = [NSString stringWithFormat:@"￥%0.2f",self.settlement.totalRealPrice/100.0];

                [weakSelf updateCellFolderStatus];
                
                if (settlement.addressList.count>0) {
                    for (BBGAddress *address in settlement.addressList) {
                        if (address.selected) {
                            weakSelf.selectedAddress = address;
                            break;
                        }
                    }
                }
                [weakSelf.tableView reloadData];
                _useCouponData=YES;
            }
        }];
        
        if (self.settlement.idCheckType == 2) {
            address.mustNeedIdCardPhoto = YES;
        }

        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"selected" ascending:NO];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[self.settlement.addressList sortedArrayUsingDescriptors:@[sort]]];
        address.addressList = array;
        [self.navigationController pushViewController:address animated:YES];
    }
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.useCouponData = YES;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }else{
            [BBGAlertView showWithTitle:@"" message:@"抱歉！该手机没有摄像头" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                
            } buttonTitles: nil];
            return;
        }
    }else if (buttonIndex == 1){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }
     //viewWillAppear时不刷新结算数据开关
    self.useCouponData = YES;
}

#pragma mark  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    WS(weakSelf);
    //照片编辑完回来，viewWillAppear时不刷新结算数据开关
    self.useCouponData = YES;
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:originImage];
        cropController.delegate = self;
        [weakSelf presentViewController:cropController animated:YES completion:nil];
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
    self.useCouponData = YES;
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        [[BBGLoadingTips sharedInstance] showLoading:@"正在上传"];
        [ws AFNetworkUploadIDPhoto:image callBack:^(BOOL sucessful, BBGResponse *response){
            if (sucessful) {
                [[BBGLoadingTips sharedInstance] showTips:@"上传成功"];
                BBGUploadUserHeadResponse *tempResponse = (BBGUploadUserHeadResponse*)response;
                if (ws.isChooseIDPhotoBack) {
                    ws.IDCardBackButton.backgroundColor = UICOLOR_FONT_IMPORTANT_RED;
                    ws.IDCardBackButton.titleLabel.textColor = UICOLOR_BACKGROUND_GRAYWHITE;
                    ws.IDCardBackButton.layer.borderColor = UICOLOR_FONT_IMPORTANT_RED.CGColor;
                    [ws.IDCardBackButton setTitleColor:UICOLOR_BACKGROUND_GRAYWHITE forState:UIControlStateNormal];
                    ws.reverseImg = tempResponse.userHeader.imageId;
                }else{
                    ws.IDCardFrontButton.backgroundColor = UICOLOR_FONT_IMPORTANT_RED;
                    ws.IDCardFrontButton.titleLabel.textColor = UICOLOR_BACKGROUND_GRAYWHITE;
                    ws.IDCardFrontButton.layer.borderColor = UICOLOR_FONT_IMPORTANT_RED.CGColor;
                    
                    [ws.IDCardFrontButton setTitleColor:UICOLOR_BACKGROUND_GRAYWHITE forState:UIControlStateNormal];
                    
                    ws.frontImg = tempResponse.userHeader.imageId;
                }

            }
        }];
    }];
    
    
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
