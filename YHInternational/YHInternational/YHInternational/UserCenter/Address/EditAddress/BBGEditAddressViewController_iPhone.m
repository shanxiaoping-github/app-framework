//
//  BBGEditAddressViewController_iPhone.m
//  YHInternational
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEditAddressViewController_iPhone.h"
#import "BBGEditAddressTopCell_iPhone.h"
#import "BBGEditAddressContentCell_iPhone.h"
#import "BBGTableView.h"
#import "BBGEditAddressCardIDViewController_iPhone.h"
#import "BBGAddressView.h"
@interface BBGEditAddressViewController_iPhone ()<UITableViewDelegate,UITableViewDataSource,BBGEditAddressContentCellDelegate>


@end

@implementation BBGEditAddressViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    if (_isEdit) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
        label.text = @"编辑地址" ;
        label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
        label.textColor = [UIColor blackColor] ;
        label.textAlignment = NSTextAlignmentCenter ;
        self.navigationItem.titleView = label ;
    }else{
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
        label.text = @"新增地址" ;
        label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
        label.textColor = [UIColor blackColor] ;
        label.textAlignment = NSTextAlignmentCenter ;
        self.navigationItem.titleView = label ;
        
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
        
        
    }
    [self createRightBarButtonItemWithTarget:self action:@selector(actionOfNext:) title:@"下一步" titleColor:UICOLOR_FONT_IMPORTANT_RED];
    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.size.height -= 60;
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    
    
    // 增加新地址
    UIImageView *addAddressView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addAddressBckg"]];
    [addAddressView setUserInteractionEnabled:YES];
    addAddressView.frame = CGRectMake(0, self.view.frame.size.height-124, self.view.frame.size.width, 60);
    UIButton *nextBtn = [UIButton buttonWithTitle:@"下一步" color:UICOLOR_FONT_IMPORTANT_RED rect:CGRectMake(40, (60-45)/2, IPHONE_WIDTH -80, 43)];
    [nextBtn addTarget:self action:@selector(actionOfNext:) forControlEvents:UIControlEventTouchUpInside];
    
    [addAddressView addSubview:nextBtn];
    [self.view addSubview:addAddressView];
}

- (void)initData{
    self.editedAddress = [[BBGAddress alloc] init];
    self.editedAddress.addrId = self.editAddress.addrId;
    self.editedAddress.areaInfo = self.editAddress.areaInfo;
    
    self.editedAddress.addr = self.editAddress.addr;
    self.editedAddress.name = self.editAddress.name;
    self.editedAddress.mobile = self.editAddress.mobile;
    
    self.editedAddress.realName = self.editAddress.realName;
    self.editedAddress.reaId = self.editAddress.reaId;
    self.editedAddress.defAddr = self.editAddress.defAddr;
    
    self.editedAddress.frontImgUrlHD = self.editAddress.frontImgUrlHD;
    self.editedAddress.reverseImgUrlHD = self.editAddress.reverseImgUrlHD;



}

- (IBAction)actionOfNext:(id)sender {
    [self.view endEditing:YES];
    if (![self checkData]) {
        return;
    }
    BBGEditAddressCardIDViewController_iPhone *con = [[BBGEditAddressCardIDViewController_iPhone alloc] init];
    con.isEdit = _isEdit;
    con.editAddress = self.editAddress;
    con.editedAddress = self.editedAddress;
    //身份证照片是否必须
    con.mustNeedIdCardPhoto = self.mustNeedIdCardPhoto;
    con.editedAddress.realName = self.editedAddress.name;   //收货人和身份证人一样，不能修改
    [self.navigationController pushViewController:con animated:YES];
}

- (IBAction)actionOfCancle:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)checkData{
    BOOL checkSuccess = YES;
    if ([BBGTools checkStringIsBlank:self.editedAddress.areaInfo]) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请选择收货地区"];
        return checkSuccess;
    }
    if ([BBGTools checkStringIsBlank:self.editedAddress.addr]) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请输入详细地址"];
        return checkSuccess;
    }
    if ([BBGTools checkStringIsBlank:self.editedAddress.name]) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请输入收货人"];
        return checkSuccess;
    }
     if (self.editedAddress.addr.length > 200) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"详细地址字数须在50个以内"];
        return checkSuccess;
    }
//    if (![BBGTools validateChinese:self.editedAddress.name]) {
//        checkSuccess = NO;
//        [[BBGLoadingTips sharedInstance] showTips:@"收货人只能输入中文"];
//        return checkSuccess;
//    }
    if ([BBGTools checkStringIsBlank:self.editedAddress.mobile]) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请输入联系电话"];
        return checkSuccess;
    }
    
    if (self.editedAddress.mobile.length != 11) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请输入正确的手机号码"];
        return checkSuccess;
    }
    
    return checkSuccess;
}

#pragma mark - UITableViewDataSource And UITableViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0){
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *identifier = @"BBGEditAddressTopCell_iPhone";
        BBGEditAddressTopCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGEditAddressTopCell_iPhone" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
        }
        [cell.titleLbl setTextColor:UICOLOR_FONT_GENERAL_GRAY];
        [cell.areaLbl setTextColor:UICOLOR_FONT_IMPORTANT_BLACK];
        cell.areaLbl.text = [[self.editedAddress.areaInfo componentsSeparatedByString:@":"] ARRAY_OBJ_AT(0)];
        
        return cell;
        
    }else {
        NSString *identifier = @"BBGEditAddressContentCell_iPhone";
        BBGEditAddressContentCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGEditAddressContentCell_iPhone" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        [cell.textField setKeyboardType:UIKeyboardTypeDefault];
        [cell.titleName setTextColor:UICOLOR_FONT_GENERAL_GRAY];
        [cell.textField setTextColor:UICOLOR_FONT_IMPORTANT_BLACK];
        switch (indexPath.row) {
            case 1:
                cell.titleName.text = @"详细地址";
                cell.textField.text = self.editedAddress.addr;
                cell.separateLine.hidden = NO;
                cell.type = EDITADDRESSINFO;
                break;
            case 2:
                cell.titleName.text = @"收 货 人";
                cell.textField.text = self.editedAddress.name;
                cell.separateLine.hidden = YES;
                cell.type = EDITUSERNAME;
                break;
            case 3:
                cell.titleName.text = @"联系电话";
                cell.textField.text = self.editedAddress.mobile;
                [cell.textField setKeyboardType:UIKeyboardTypeNumberPad];
                cell.separateLine.hidden = YES;
                cell.type = EDITPHONE;
                break;
                
            default:
                break;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BBGAddressView * addressView = [[BBGAddressView alloc]initWithRegions:[BBGRegionManager sharedInstance].regionList];
        
        __weak BBGEditAddressViewController_iPhone *weakSelf = self;
        if (![BBGTools checkStringIsBlank:self.editedAddress.areaInfo]) {
            NSArray *areaInfo = [self.editedAddress.areaInfo componentsSeparatedByString:@":"];
            NSString *areaInfoStr = [areaInfo ARRAY_OBJ_AT(0)];
            NSArray *areaInfoStrArray = [areaInfoStr componentsSeparatedByString:@"_"];
            if ([areaInfoStrArray isKindOfClass:[NSArray class]]) {
                NSString *p = [areaInfoStrArray ARRAY_OBJ_AT(0)];
                NSString *c = [areaInfoStrArray ARRAY_OBJ_AT(1)];
                NSString *d = [areaInfoStrArray ARRAY_OBJ_AT(2)];
                NSString *s = [areaInfoStrArray ARRAY_OBJ_AT(3)];
                
                [addressView showWithProvince:p city:c district:d street:s callback:^(BOOL selected, NSString *p, NSString *c, NSString *d, NSString *s, NSString *pID, NSString *cID, NSString *dID, NSString *sID) {
                    if (selected) {
                        weakSelf.editedAddress.areaInfo = [NSString stringWithFormat:@"%@_%@_%@_%@:%@_%@_%@_%@",p,c,d,s,pID,cID,dID,sID];
                        
                        [weakSelf.tableView reloadData];
                    }
                }];
            }
        }else{
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
                        weakSelf.editedAddress.areaInfo = [NSString stringWithFormat:@"%@_%@_%@_%@:%@_%@_%@_%@",p,c,d,s,pID,cID,dID,sID];
                        
                        [weakSelf.tableView reloadData];
                    }
                }];
            }else{
                [addressView show:^(BOOL selected, NSString *p, NSString *c, NSString *d, NSString *s, NSString *pID, NSString *cID, NSString *dID, NSString *sID) {
                    if (selected) {
                        weakSelf.editedAddress.areaInfo = [NSString stringWithFormat:@"%@_%@_%@_%@:%@_%@_%@_%@",p,c,d,s,pID,cID,dID,sID];
                        
                        [weakSelf.tableView reloadData];
                    }
                }];
            }
        }
    }
}

#pragma mark BBGEditAddressContentCellDelegate 
-(void)editAddressWithType:(BBGEditAddressType)typ value:(NSString *)value {
    if (typ == EDITADDRESSINFO) {
        self.editedAddress.addr = value;
    }else if (typ == EDITUSERNAME){
        self.editedAddress.name = value;
    }else if (typ == EDITPHONE){
        self.editedAddress.mobile = value;
    }
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
