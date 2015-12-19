//
//  BBGCouponViewController.m
//  Components
//
//  Created by Damon on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCouponViewController.h"
#import "BBGUserCancelRequest.h"

@interface BBGCouponViewController ()
@property (nonatomic, strong) BBGCouponListRequest * request;
@property (nonatomic, strong) BBGUserCouponRequest * userCouponRequest;
@property (nonatomic, strong) BBGUseCouponRequest * useCouponRequest;
@property (nonatomic, strong) BBGUserCancelRequest * cancelRequest;
@end

@implementation BBGCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateData:(LoadDataCallback)callback{
    _request = [[BBGCouponListRequest alloc]init];
    _request.pageSize = 20;
    _request.pageNumber = self.pageNumber;
    _request.couponStatus = self.couponStatus;
    
    __weak BBGCouponViewController * weakSelf = self;
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGCouponListResponse * response = (BBGCouponListResponse *)responseData;
        if (weakSelf.request.pageNumber == 1) {
            [weakSelf.couponListArray removeAllObjects];
            weakSelf.couponListArray = response.couponListArray;
        }else{
//            if (weakSelf.couponListArray.count < response.count) {
                [weakSelf.couponListArray addObjectsFromArray:response.couponListArray];
//            }
        }
        if (callback) {
            callback(YES,responseData);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] showTips:errorMsg];
        if (callback) {
            callback(NO,nil);
        }
    }];
}

- (void)checkUserCoupon:(NSString *)shopId buyType:(NSString *)buyType callback:(void (^)(BOOL successful,id response))callback{
    [[BBGLoadingTips sharedInstance] showLoading:@"正在获取优惠券..."];
    _userCouponRequest = [[BBGUserCouponRequest alloc]init];
    _userCouponRequest.shopId = shopId;
    _userCouponRequest.buyType = buyType;
    [_userCouponRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (!responseData.isError) {
            if (callback) {
                callback(YES,responseData);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] showTips:errorMsg];
        if (callback) {
            callback(NO,nil);
        }
    }];
}

- (void)useCouponCode:(NSString * )code shopId:(NSString *)shopId buyType:(NSString *)buyType couponType:(NSString *)couponType callback:(void (^)(BOOL successful,id response))callback{
    __weak BBGCouponViewController * weakSelf = self;
    
    _useCouponRequest = [[BBGUseCouponRequest alloc] init];
    _useCouponRequest.couponCode = code;
    _useCouponRequest.buyType = buyType;
    _useCouponRequest.couponType = couponType;
    _useCouponRequest.shopId = shopId;
    
    [_useCouponRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        if (!responseData.isError) {
            [weakSelf dismissViewController];
            if (callback) {
                callback(YES,responseData);
            }
        }else{
            if (callback) {
                callback(NO,nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (callback) {
            callback(NO,nil);
        }
    }];
}

- (void)cancelUserCoupon:(NSString *)shopId buyType:(NSString *)buyType callback:(void (^)(BOOL successful,id response))callback {
    _cancelRequest = [[BBGUserCancelRequest alloc]init];
    _cancelRequest.shopId = shopId;
    _cancelRequest.buyType = buyType;
    
    [_cancelRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        if (!responseData.isError) {
            if (callback) {
                callback(YES,responseData);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (callback) {
            callback(NO,nil);
        }
    }] ;
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
