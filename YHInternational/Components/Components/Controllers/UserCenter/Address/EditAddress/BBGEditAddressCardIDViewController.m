//
//  BBGEditAddressCardIDViewController.m
//  Components
//
//  Created by yangjie on 15/5/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEditAddressCardIDViewController.h"
#import "BBGUploadIDPhotoRequest.h"

@interface BBGEditAddressCardIDViewController ()

@property (nonatomic,strong) BBGGetAddrByNameRequest *getAddrByNameReqeust;
@property (nonatomic,strong) BBGEditAddressReqeust *editAddressReqeust;
@property (nonatomic,strong)BBGUploadIDPhotoRequest *uploadIDPhotoRequest;

@end

@implementation BBGEditAddressCardIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)getAddrByName:(LoadDataCallback)callback{
    if (self.getAddrByNameReqeust == nil) {
        self.getAddrByNameReqeust = [[BBGGetAddrByNameRequest alloc] init];
    }
    _getAddrByNameReqeust.name = self.editedAddress.name;
    [_getAddrByNameReqeust sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (void)updateData:(LoadDataCallback)callback{
    if (self.editAddressReqeust == nil) {
        self.editAddressReqeust = [[BBGEditAddressReqeust alloc] init];
    }
    _editAddressReqeust.addrId = self.editedAddress.addrId;
    _editAddressReqeust.addr = self.editedAddress.addr;
    _editAddressReqeust.areaInfo = self.editedAddress.areaInfo;
    _editAddressReqeust.name = self.editedAddress.name;
    _editAddressReqeust.mobile = self.editedAddress.mobile;
    _editAddressReqeust.realName = self.editedAddress.realName;
    _editAddressReqeust.idCard = self.editedAddress.idCard;
    _editAddressReqeust.reaId = self.editedAddress.reaId;
    _editAddressReqeust.defAddr = self.editedAddress.defAddr;
    _editAddressReqeust.frontImg = self.editedAddress.frontImg;
    _editAddressReqeust.backPhotoId = self.editedAddress.reverseImg;
    [_editAddressReqeust sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (void)addAddress:(LoadDataCallback)callback{
    [_addAddressReqeust sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (BBGAddAddressRequest *)addAddressReqeust {
    if (_addAddressReqeust == nil) {
        _addAddressReqeust = [[BBGAddAddressRequest alloc] init];
    }
    return _addAddressReqeust;
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

- (void)dealloc {
    
    _getAddrByNameReqeust = nil;
    _editAddressReqeust = nil;
    _uploadIDPhotoRequest = nil;
}
@end
