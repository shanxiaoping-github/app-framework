//
//  BBGUserCenterViewController.m
//  Components
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserCenterViewController.h"
#import "BBGUserInfoRequest.h"


@interface BBGUserCenterViewController ()

@property (nonatomic,strong) BBGUpdateUserNameRequest *updateUserNameReqeust;
@property (nonatomic,strong) BBGUserInfoRequest *userInfoRequest;

@property (nonatomic,strong)BBGUploadUserHeadRequest *uploadUserHeadReques;

@property (nonatomic,strong)BBGSetUserHeadImgRequest *setUserHeadImgRequest;

@property (nonatomic,strong)BBGUserCountRequest *userCountRequest;

@property (nonatomic,strong)BBGGetCommentDetailRequest *getCommentDetailRequest;


@end

@implementation BBGUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateData:(LoadDataCallback)callback{
    if (!self.updateUserNameReqeust) {
        self.updateUserNameReqeust = [[BBGUpdateUserNameRequest alloc] init];
    }
    _updateUserNameReqeust.nickName = _nickName;
    __weak BBGUserCenterViewController *weakSelf = self;
    [_updateUserNameReqeust sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGUpdateUserNameResponse *response = (BBGUpdateUserNameResponse*)responseData;
        weakSelf.nickName = response.userDetailInfo.nickName;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        weakSelf.nickName = @"";
    }];
    
}


- (void)getUserInfo:(LoadDataCallback)callback {
    if (!self.userInfoRequest) {
        self.userInfoRequest = [[BBGUserInfoRequest alloc] init];
    }
    __weak BBGUserCenterViewController *weakSelf = self;
    [_userInfoRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGUserInfoResponse *response = (BBGUserInfoResponse*)responseData;
        weakSelf.userDetailInfo = response.userDetailInfo;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}


- (void)getOrderCountInfo:(LoadDataCallback)callback {

}


- (void)uploadUserHeadImg:(UIImage*)img callBack:(LoadDataCallback)callback data:(UploadDataBlock)uploadDataBlock{
    if (!self.uploadUserHeadReques) {
        self.uploadUserHeadReques = [[BBGUploadUserHeadRequest alloc] init];
    }
    
    _uploadUserHeadReques.imgData = UIImageJPEGRepresentation(img, 0.3);
    [_uploadUserHeadReques sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    } data:uploadDataBlock];
}

- (void)setUserHeadImg:(LoadDataCallback)callback{
    if (!self.setUserHeadImgRequest) {
        self.setUserHeadImgRequest = [[BBGSetUserHeadImgRequest alloc] init];
    }
    __weak BBGUserCenterViewController *weakSelf = self;
    _setUserHeadImgRequest.headImg = _headImg;
    [_setUserHeadImgRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGUserInfoResponse *response = (BBGUserInfoResponse*)responseData;
        weakSelf.userDetailInfo = response.userDetailInfo;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
    
}

- (void)getUserCount:(LoadDataCallback)callback{
    if (!self.userCountRequest) {
        self.userCountRequest = [[BBGUserCountRequest alloc] init];
    }
    __weak BBGUserCenterViewController *weakSelf = self;
    [_userCountRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGUserCountResponse *response = (BBGUserCountResponse*)responseData;
        weakSelf.unpaidOrderCount = response.unpaidOrderCount;
        weakSelf.logisticsCount = response.logisticsCount;
        weakSelf.waitSendGoodsCount = response.waitSendGoodsCount;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (void)getCommentDetailCount:(LoadDataCallback)callback{
    if (!self.getCommentDetailRequest) {
        self.getCommentDetailRequest = [[BBGGetCommentDetailRequest alloc] init];
    }
    __weak BBGUserCenterViewController *weakSelf = self;
    [_getCommentDetailRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGGetCommentDetailResponse *response = (BBGGetCommentDetailResponse*)responseData;
        weakSelf.countsForShareOrder = response.countsForShareOrder;
        callback(YES,response);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

@end
