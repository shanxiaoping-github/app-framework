//
//  BBGGSAddressSelectViewController.m
//  Components
//
//  Created by 彭腾 on 15/10/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSAddressSelectViewController.h"
#import "BBGAddressListRequest.h"
#import "BBGAddressListResponse.h"
#import "BBGSetDefaultAddressRequest.h"

@interface BBGGSAddressSelectViewController ()

@property (nonatomic, strong) BBGAddressListRequest *addressListRequest;

@property (nonatomic, strong) BBGSetDefaultAddressRequest *setDefaultAddressRequest;

@end

@implementation BBGGSAddressSelectViewController

- (void)updateData:(LoadDataCallback)callback {
    if (!self.addressListRequest) {
        self.addressListRequest = [[BBGAddressListRequest alloc] init];
    }
    if (!self.addressArr) {
        self.addressArr = [NSMutableArray array];
    }
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    __weak BBGGSAddressSelectViewController *weakSelf = self;
    
    [self.addressListRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        BBGAddressListResponse *results = (BBGAddressListResponse *)responseData;
        weakSelf.addressArr = results.addressList;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
    }];
}

- (void)setDefaultAddressRequest:(LoadDataCallback)callback {
    if (!self.setDefaultAddressRequest) {
        self.setDefaultAddressRequest = [[BBGSetDefaultAddressRequest alloc] init];
    }
    self.setDefaultAddressRequest.addrId = self.addrId;
    [self.setDefaultAddressRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
