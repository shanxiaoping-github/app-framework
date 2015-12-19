//
//  BBGSelectAddressViewController_iPhone.m
//  YHInternational
//
//  Created by Timmy OuYang on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSelectAddressViewController_iPhone.h"
#import "BBGSettlementAddressCell_iPhone.h"
#import "BBGSelectAddressCell.h"
#import "BBGEditAddressViewController_iPhone.h"
@interface BBGSelectAddressViewController_iPhone ()<BBGSelectAddressCellDelegate>

@property (weak, nonatomic) IBOutlet BBGPullTable *tableView;
@property (copy, nonatomic) SettlementCallback settlementCallBack;

@end

@implementation BBGSelectAddressViewController_iPhone

- (id)initWithSettlementCallBack:(SettlementCallback)callBack {

    self = [super init];
    if (self) {
        self.settlementCallBack = callBack;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"更改收货地址";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"更改收货地址" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    [self createRightBarButtonItemWithTarget:self action:@selector(newAddress) title:@"新增" titleColor:RGB_COLOR(247.0, 82.0, 115.0)];
   self.navigationItem.hidesBackButton = YES;
    self.tableView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - 新增按钮点击
- (void)newAddress
{
    if ([self.addressList count]>=10) {
        [BBGAlertView showWithTitle:@"" message:@"已经有10条地址了，请删除部分地址后再新增" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            
        } buttonTitles:@"好", nil];
    }else{
        BBGEditAddressViewController_iPhone *con = [[BBGEditAddressViewController_iPhone alloc] init];
        con.isEdit = NO;
        [self.navigationController pushViewController:con animated:YES];
        
    }
}

#pragma mark - BBGSelectAddressCellDelegate
- (void)setSeletedAddress:(BBGAddress *)address
{
   
    if (address) {
        self.addressId = address.addrId;
        __weak BBGSelectAddressViewController_iPhone *weakSelf = self;
        [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view] ;

        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                BBGSelectedAddressResponse *addressResponse = (BBGSelectedAddressResponse *)response;
                weakSelf.settlementCallBack(YES,addressResponse.settlement);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }

    
}
- (void)setEditingAddress:(BBGAddress *)address
{
    //编辑地址
    BBGEditAddressViewController_iPhone *editViewController = [[BBGEditAddressViewController_iPhone alloc] init];
    editViewController.isEdit = YES;
    editViewController.editAddress = address;
    editViewController.mustNeedIdCardPhoto = self.mustNeedIdCardPhoto;
    [self.navigationController pushViewController:editViewController animated:YES];

}

- (void)selectAddressWithAddressId:(NSString *)addressId {

    __weak BBGSelectAddressViewController_iPhone *weakSelf = self;
    self.addressId = addressId;
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"selected" ascending:NO];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[self.settlement.addressList sortedArrayUsingDescriptors:@[sort]]];
            weakSelf.addressList = array;
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark-UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"BBGSelectAddressCell";
    BBGSelectAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGSelectAddressCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    BBGAddress *address = self.addressList[indexPath.row];
    [cell reloadCell:address];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


#pragma mark- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    BBGAddress *address = [self.addressList objectAtIndex:indexPath.row];
    if (address) {
        self.addressId = address.addrId;
        __weak BBGSelectAddressViewController_iPhone *weakSelf = self;
        
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                BBGSelectedAddressResponse *addressResponse = (BBGSelectedAddressResponse *)response;
                weakSelf.settlementCallBack(YES,addressResponse.settlement);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
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
