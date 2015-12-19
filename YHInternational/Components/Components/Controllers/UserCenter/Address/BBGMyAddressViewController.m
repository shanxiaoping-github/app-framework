//
//  BBGMyAddressViewController.m
//  Components
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMyAddressViewController.h"

@interface BBGMyAddressViewController ()

@end

@implementation BBGMyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateData:(LoadDataCallback)callback {
    if (!self.addressListRequest) {
        self.addressListRequest = [[BBGAddressListRequest alloc] init];
    }
    __weak BBGMyAddressViewController *weakSelf = self;
    [_addressListRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGAddressListResponse *addressResponse = (BBGAddressListResponse *)responseData;
        NSArray *array = addressResponse.addressList;
        if (weakSelf.isNeedSort) {
            NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"defAddr" ascending:NO];
             array = [addressResponse.addressList sortedArrayUsingDescriptors:@[sort]];
        }
        
        [weakSelf.addressList removeAllObjects];
        [weakSelf.addressList ARRAY_ADD_OBJS_FROM_ARRAY(array)];
        callback(YES,addressResponse);
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
    
}

- (void)deleteAddress:(LoadDataCallback)callback{
    [_deleteAddressRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (BBGDeleteAddressRequest *)deleteAddressRequest{
    if (!_deleteAddressRequest) {
        _deleteAddressRequest = [[BBGDeleteAddressRequest alloc] init];
    }
    return _deleteAddressRequest;
}

- (void)setDefaultAddressRequest:(LoadDataCallback)callback{
    [_setDefaultAddressReqeust sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (BBGSetDefaultAddressRequest *)setDefaultAddressReqeust{
    if (!_setDefaultAddressReqeust) {
        _setDefaultAddressReqeust = [[BBGSetDefaultAddressRequest alloc] init];
    }
    return _setDefaultAddressReqeust;
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
