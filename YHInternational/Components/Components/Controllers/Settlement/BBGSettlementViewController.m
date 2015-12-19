//
//  BBGSettlementViewController.m
//  Components
//
//  Created by Timmy OuYang on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSettlementViewController.h"
#import "BBGAddAddressRequest.h"
#import "BBGUploadIDPhotoRequest.h"

@interface BBGSettlementViewController ()

@property (nonatomic,strong) BBGSettlementRequest *settlementRequest;
@property (nonatomic,strong) BBGSubmitOrderRequest *submitRequest;
@property (nonatomic,strong) BBGAddAddressRequest *addAddressRequest;
@property (nonatomic,strong) BBGUploadIDPhotoRequest *uploadIDPhotoRequest;

@end

@implementation BBGSettlementViewController

- (void)updateData:(LoadDataCallback)callback {
    if (!self.settlementRequest) {
        self.settlementRequest = [[BBGSettlementRequest alloc] init];
    }
    
    _settlementRequest.buyType = self.buyType;
    __weak BBGSettlementViewController *weakSelf = self;
    
    [_settlementRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGSettlementResponse *settlementResponseData = (BBGSettlementResponse *)responseData;
        weakSelf.settlement = settlementResponseData.settlement;
        if (weakSelf.settlement.addressList.count>0) {
            for (BBGAddress *address in weakSelf.settlement.addressList) {
                if (address.selected) {
                    weakSelf.selectedAddress = address;
                    break;
                }
            }
        }
        callback(YES, responseData);

    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO, nil);

    }];

}

- (void)submitOrderData:(LoadDataCallback)callback {

    if (!self.submitRequest) {
        self.submitRequest = [[BBGSubmitOrderRequest alloc] init];
    }
    
    _submitRequest.buyType = self.buyType;
    __weak BBGSettlementViewController *weakSelf = self;
    
    [_submitRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGSubmitOrderResponse *settlementResponseData = (BBGSubmitOrderResponse *)responseData;
        weakSelf.orderIdList = settlementResponseData.orderIdList;
        callback(YES, responseData);
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO, nil);
        
    }];

}

- (void)addAddressData:(LoadDataCallback)callback {

    if (!self.addAddressRequest) {
        self.addAddressRequest = [[BBGAddAddressRequest alloc] init];
    }
    _addAddressRequest.addr = self.selectedAddress.addr;
    _addAddressRequest.name = self.selectedAddress.name;
    _addAddressRequest.mobile = self.selectedAddress.mobile;
    _addAddressRequest.realName = self.selectedAddress.realName;
    _addAddressRequest.idCard = self.selectedAddress.idCard;
    _addAddressRequest.areaInfo=self.selectedAddress.areaInfo;
    _addAddressRequest.frontImg = self.selectedAddress.frontImg;
    _addAddressRequest.reverseImg = self.selectedAddress.reverseImg;
    [_addAddressRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGAddAdressResponse *response = (BBGAddAdressResponse *)responseData;
        callback(YES,response);
    } failure:nil];
}

- (void)AFNetworkUploadIDPhoto:(UIImage*)img callBack:(LoadDataCallback)callback {
    if (!self.uploadIDPhotoRequest) {
        self.uploadIDPhotoRequest = [[BBGUploadIDPhotoRequest alloc] init];
    }
    
    _uploadIDPhotoRequest.imgData = UIImageJPEGRepresentation(img, 0.3);
    [_uploadIDPhotoRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}


@end
