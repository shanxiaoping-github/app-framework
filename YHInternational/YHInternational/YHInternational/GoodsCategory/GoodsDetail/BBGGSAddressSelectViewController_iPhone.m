//
//  BBGGSAddressSelectViewController_iPhone.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSAddressSelectViewController_iPhone.h"
#import "BBGGSAddressSelectCell.h"
#import "BBGEditAddressViewController_iPhone.h"

@interface BBGGSAddressSelectViewController_iPhone ()<UITableViewDelegate,UITableViewDataSource,BBGGSAddressSelectCellDelegate>

@property (nonatomic, strong) UITableView *BBGGSAddress;

@end

@implementation BBGGSAddressSelectViewController_iPhone

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak BBGGSAddressSelectViewController_iPhone *weakSelf = self;

    if ([BBGSession sharedInstance].isLogin) {
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                if (weakSelf.BBGGSAddress!=nil) {
                    [weakSelf.BBGGSAddress reloadData];
                }else {
                    [weakSelf initUI];
                }
            }
        }];
    }else {
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                if (weakSelf.BBGGSAddress!=nil) {
                    [weakSelf.BBGGSAddress reloadData];
                }else {
                    [weakSelf initUI];
                }
            }
        }];
    }
}

- (void)initUI {
    self.BBGGSAddress = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64)] ;
    self.BBGGSAddress.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.BBGGSAddress.delegate = self;
    self.BBGGSAddress.dataSource = self;
    self.BBGGSAddress.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    [self.view addSubview:self.BBGGSAddress];
    
    [self registerCell];

}

#pragma mark - 注册UITableViewCell
- (void)registerCell {
    [self.BBGGSAddress registerNib:[UINib nibWithNibName:@"BBGGSAddressSelectCell" bundle:nil] forCellReuseIdentifier:@"BBGGSAddressSelect"];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBGGSAddressSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGSAddressSelect"];
    BBGAddress *address = [self.addressArr ARRAY_OBJ_AT(indexPath.row)];
    [cell updateCell:address selected:self.selectedAddress];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)];
    label.text = @"更改收货地址";
    label.font = APP_FONT_DEMI_LIGHT(18.0f);
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createRightBarButtonItemWithTarget:self action:@selector(newAddress) title:@"新增" titleColor:RGB_COLOR(247.0, 82.0, 115.0)];
    
//    __weak BBGGSAddressSelectViewController_iPhone *weakSelf = self;
    
//    if ([BBGSession sharedInstance].isLogin) {
//        [self updateData:^(BOOL sucessful, BBGResponse *response) {
//            if (sucessful) {
//                [weakSelf initUI];
//            }
//        }];
//    }else {
//        [self updateData:^(BOOL sucessful, BBGResponse *response) {
//            if (sucessful) {
//                [weakSelf initUI];
//            }
//        }];
//    }
}

#pragma mark - 新增按钮点击
- (void)newAddress
{
    if ([self.addressArr count]>=10) {
        [BBGAlertView showWithTitle:@"" message:@"已经有10条地址了，请删除后新增" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            
        } buttonTitles:@"好", nil];
    }else{
        BBGEditAddressViewController_iPhone *con = [[BBGEditAddressViewController_iPhone alloc] init];
        con.isEdit = NO;
        [self.navigationController pushViewController:con animated:YES];
    }
}

- (void)setEditingAddress:(BBGAddress *)address {
    //编辑地址
    BBGEditAddressViewController_iPhone *editViewController = [[BBGEditAddressViewController_iPhone alloc] init];
    editViewController.isEdit = YES;
    editViewController.editAddress = address;
    editViewController.mustNeedIdCardPhoto = self.mustNeedIdCardPhoto;
    [self.navigationController pushViewController:editViewController animated:YES];
}

- (void)setSeletedAddress:(BBGAddress *)address {
//    self.selectedAddress = address;
//    [self.BBGGSAddress reloadData];
    if ([self.delegate conformsToProtocol:@protocol(BBGGSAddressSelectDelegate)]&&[self.delegate respondsToSelector:@selector(getSelectedAddress:)]) {
        [self.delegate getSelectedAddress:address];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setDefaultAddress:(BBGAddress *)address {
    __weak BBGGSAddressSelectViewController_iPhone *weakSelf = self;
    self.addrId = address.addrId;
    [self setDefaultAddressRequest:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
                [weakSelf.BBGGSAddress reloadData];
            }];
        }
    }];
}

- (void)dismissViewController {
    [super dismissViewController];
    if ([self.delegate conformsToProtocol:@protocol(BBGGSAddressSelectDelegate)]&&[self.delegate respondsToSelector:@selector(reloadData)]) {
        [self.delegate reloadData];
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
