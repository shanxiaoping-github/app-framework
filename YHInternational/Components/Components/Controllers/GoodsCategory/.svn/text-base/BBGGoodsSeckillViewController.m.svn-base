//
//  BBGGoodsSeckillViewController.m
//  Components
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsSeckillViewController.h"
#import "BBGGoodsSeckillRequest.h"
#import "BBGGoodsSeckillResponse.h"
#import "BBGUploadIDPhotoRequest.h"
#import "BBGAddAddressRequest.h"
#import "BBGSeckillFastRequest.h"
#import "BBGSeckillFastResponse.h"

@interface BBGGoodsSeckillViewController ()
@property (nonatomic, strong) BBGGoodsSeckillRequest *seckillRequest;
@property (nonatomic, strong) BBGUploadIDPhotoRequest *uploadIDPhotoRequest;
@property (nonatomic, strong) BBGAddAddressRequest *addAddressRequest;
@property (nonatomic, strong) BBGSeckillFastRequest *seckillFastRequest;
@end

@implementation BBGGoodsSeckillViewController

- (void)updateData:(LoadDataCallback)callback {
    if (!self.seckillRequest) {
        self.seckillRequest = [[BBGGoodsSeckillRequest alloc]init];
    }
    self.seckillRequest.productId = self.productId;
    self.seckillRequest.activityId = self.activityId;
    //    self.seckillRequest.productId = @"25981";
    //    self.seckillRequest.activityId = @"7701";
    
    if (!self.goodsImagesArr) {
        self.goodsImagesArr = [NSMutableArray array];
    }
    
    if (!self.addressArr) {
        self.addressArr = [NSMutableArray array];
    }
    
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    __weak BBGGoodsSeckillViewController *weakSelf = self;
    
    [self.seckillRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        BBGGoodsSeckillResponse *results = (BBGGoodsSeckillResponse *)responseData;
        weakSelf.goodsImagesArr = results.goodsImagesArr;
        weakSelf.addressArr = results.addressArr;
        weakSelf.basicInfo = results.basicInfo;
        weakSelf.seckill = results.seckill;
        weakSelf.isLogin = results.isLogin;
        
        if (weakSelf.addressArr.count>0) {
            for (BBGAddress *address in weakSelf.addressArr) {
                if (address.defAddr) {
                    weakSelf.selectedAddress = address;
                    break;
                }
            }
        }
        
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
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
    _addAddressRequest.defAddr = YES;
    [_addAddressRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGAddAdressResponse *response = (BBGAddAdressResponse *)responseData;
        callback(YES,response);
    } failure:nil];
}

- (void)fastRequest:(LoadDataCallback)callback {
    if (!self.seckillFastRequest) {
        self.seckillFastRequest = [[BBGSeckillFastRequest alloc]init];
    }
    BBGAddress *address = self.selectedAddress ? self.selectedAddress:[self.addressArr ARRAY_OBJ_AT(0)];
    _seckillFastRequest.addrId = address.addrId;
    _seckillFastRequest.productId = self.basicInfo.productId;
    _seckillFastRequest.activityId = self.activityId;
    //    _seckillFastRequest.activityId = @"7701";
    
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    __weak BBGGoodsSeckillViewController *weakSelf = self;
    
    [_seckillFastRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        BBGSeckillFastResponse *results = (BBGSeckillFastResponse *)responseData;
        weakSelf.fastModel = results.fastModel;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
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

- (void)dealloc {
    [_seckillRequest cancelRequest];
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
