//
//  BBGSelectAddressViewController.m
//  Components
//
//  Created by Timmy OuYang on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSelectAddressViewController.h"

@interface BBGSelectAddressViewController ()

@property (nonatomic, strong) BBGSelectedAddressRequest *selectedAddressRequest;
@property (nonatomic, strong) BBGAddressListRequest *addressListRequest;

@end

@implementation BBGSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateData:(LoadDataCallback)callback {
    if (!self.selectedAddressRequest) {
        self.selectedAddressRequest = [[BBGSelectedAddressRequest alloc] init];
    }
    
    _selectedAddressRequest.buyType = self.buyType;
    _selectedAddressRequest.addrId = self.addressId;
    
    __weak BBGSelectAddressViewController *weakSelf = self;
    
    [_selectedAddressRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGSettlementResponse *settlementResponseData = (BBGSettlementResponse *)responseData;
        weakSelf.settlement = settlementResponseData.settlement;
        callback(YES, responseData);
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO, nil);
        
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
