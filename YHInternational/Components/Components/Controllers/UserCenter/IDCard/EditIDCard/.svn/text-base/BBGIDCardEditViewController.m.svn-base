//
//  BBGEditAddressCardIDViewController.m
//  Components
//
//  Created by yangjie on 15/5/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIDCardEditViewController.h"
#import "BBGUploadIDPhotoRequest.h"
#import "Common.h"

@interface BBGIDCardEditViewController ()

@property (nonatomic,strong)BBGModifyIDCardRequest  *editIDCardReqeust;
@property (nonatomic,strong)BBGUploadIDPhotoRequest *uploadIDPhotoRequest;

@end

@implementation BBGIDCardEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//编辑请求
- (void)updateData:(LoadDataCallback)callback{
    if (self.editIDCardReqeust == nil) {
        self.editIDCardReqeust = [[BBGModifyIDCardRequest alloc] init];
    }
    
    _editIDCardReqeust.IDCard = self.savaIDCard;
    [_editIDCardReqeust sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
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
    _editIDCardReqeust = nil;
    _uploadIDPhotoRequest = nil;
}
@end
