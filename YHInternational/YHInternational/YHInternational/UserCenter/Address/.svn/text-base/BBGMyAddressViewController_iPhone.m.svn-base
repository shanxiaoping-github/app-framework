//
//  BBGMyAddressViewController_iPhone.m
//  YHInternational
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMyAddressViewController_iPhone.h"
#import "BBGTableView.h"
#import "BBGAddressListCell_iPhone.h"
#import "BBGEditAddressViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGAddress.h"


@interface BBGMyAddressViewController_iPhone ()<BBGTableViewDelegate,BBGTableViewDataSource,BBGAddressListCelDelegate>

@end     

@implementation BBGMyAddressViewController_iPhone

- (IBAction)actionOfCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNeedSort = YES;
    // Do any additional setup after loading the view.
//    self.title = @"我的地址";
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"我的地址" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    [self createLeftBarButtonItemWithTarget:self action:@selector(actionOfCancel:) normalImage:[UIImage imageNamed:@"Cancel"] highlightedImage:[UIImage imageNamed:@"Cancel_White"]];
    
    self.addressList = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.size.height -= 60;
    _tableView = [[BBGTableView alloc] initWithFrame:tableViewFrame style:BBGTableViewStylePlain backgoundImage:nil];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    [self.view addSubview:_tableView];
    
    // 增加新地址
    _addAddressView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addAddressBckg"]];
    [_addAddressView setUserInteractionEnabled:YES];
    _addAddressView.frame = CGRectMake(0, self.view.frame.size.height-124, self.view.frame.size.width, 60);
    
    
    _addAddressBtn = [UIButton buttonWithTitle:@"添加新地址" color:UICOLOR_FONT_IMPORTANT_RED rect:CGRectMake(40, (60-45)/2, IPHONE_WIDTH -80, 43)];
    [_addAddressBtn addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
    [_addAddressView addSubview:_addAddressBtn];
    
    [self.view addSubview:_addAddressView];
}

- (void)viewDidAppear:(BOOL)animated{
    [self reloadView];
}

#pragma mark - BBGTableViewDataSource And BBGTableViewDelegate Methods

- (NSInteger)tableView:(BBGTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = [self.addressList count];
    
    return count;
}

- (CGFloat)tableView:(BBGTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 144.0;
}

- (BBGTableViewCell *)tableView:(BBGTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BBGAddressListCell_iPhone";
    BBGAddressListCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGAddressListCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColorFromRGB(239, 239, 239);
        cell.delegate = self;
    }
    BBGAddress *address = [self.addressList ARRAY_OBJ_AT(indexPath.row)];
    [cell updateCellData:address];
    return cell;
}

- (UIView *)tableView:(BBGTableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 24)];
        headView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.93f alpha:1.00f];
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, self.view.frame.size.width-20, 20)];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已有 %lu 个地址(最多添加10个收货地址)",(unsigned long)[self.addressList count]]];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromHexadecimalRGB(0x999999) range:NSMakeRange(0,2)];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromHexadecimalRGB(0xf34568) range:NSMakeRange(3,4)];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromHexadecimalRGB(0x999999) range:NSMakeRange(5,16)];
        headLabel.attributedText = str;
        headLabel.font = APP_FONT(13);
        [headView addSubview:headLabel];
        _tableView.tableHeaderView = headView;
        return headView;
    }else{
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark BBGAddressListCelDelegate
- (void)setDefaultAddress:(BBGAddress *)address{
    if (!address.defAddr) {
        self.isNeedSort = NO;
        __weak BBGMyAddressViewController_iPhone *weakSelf = self;
        self.setDefaultAddressReqeust.addrId = address.addrId;
        [[BBGLoadingTips sharedInstance] showLoading:@""];
        [self setDefaultAddressRequest:^(BOOL sucessful, BBGResponse *response) {
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                [[BBGLoadingTips sharedInstance] showTips:@"设置默认地址成功"];
                [weakSelf reloadView];
            }
        }];
    }
}

- (void)didChangeAddressCellWithType:(BBGAddressListViewType)type address:(BBGAddress*)address {
    switch (type) {    
        case SetDefaultAddressType:
        {
            //设为默认地址
        }
            break;
        case EditAddressType:
        {
            
            //编辑地址
            BBGEditAddressViewController_iPhone *editViewController = [[BBGEditAddressViewController_iPhone alloc] init];
            editViewController.isEdit = YES;
            editViewController.editAddress = address;
            [self.navigationController pushViewController:editViewController animated:YES];
        }
            break;
        case DeleteAddressType:
        {
            //删除地址
            __weak BBGMyAddressViewController_iPhone *weakSelf = self;
            [BBGAlertView showWithTitle:@"" message:@"确定删除地址？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    [[BBGLoadingTips sharedInstance] showLoading:@""];
                    weakSelf.deleteAddressRequest.addrId = address.addrId;
                    [weakSelf deleteAddress:^(BOOL sucessful, BBGResponse *response) {
                        [[BBGLoadingTips sharedInstance] hideTips];
                        if (sucessful) {
                            [[BBGLoadingTips sharedInstance] showTips:@"删除成功"];
                            [weakSelf reloadView];
                        }
                    }];
                }
            } buttonTitles:@"确定", nil];

            
        }
            break;
        default:
            break;
    }
    
}


- (void)addAddressAction:(id)sender {
    if ([self.addressList count]>=10) {
        [BBGAlertView showWithTitle:@"" message:@"已经有10条地址了，请删除部分地址后再新增" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            
        } buttonTitles:@"好", nil];
    }else{
        BBGEditAddressViewController_iPhone *con = [[BBGEditAddressViewController_iPhone alloc] init];
        con.isEdit = NO;
        [self.navigationController pushViewController:con animated:YES];
    
    }
    
}


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 1) {
//       
//    }
//    
//}

- (void)editAddressSuccess {
    [[BBGLoadingTips sharedInstance]showLoadingOnView:self.view];
//    [self loadUserAddress];
}

- (void)reloadView{
    __weak BBGMyAddressViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            [weakSelf.tableView reloadData];
        }
        if ([weakSelf.addressList COUNT] == 0) {
            [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"addressNull"] tips:@"还没有收货地址..." target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:CGPointMake(0, 0) onView:weakSelf.tableView];
        }else{
            [weakSelf dismissDefaultView];
        }
    }];
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
