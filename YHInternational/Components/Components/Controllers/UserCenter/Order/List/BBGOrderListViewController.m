//
//  BBGOrderListViewController.m
//  Components
//
//  Created by elvis.peng on 15-5-12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderListViewController.h"
#import <Common/Common.h>
@interface BBGOrderListViewController ()
@property (nonatomic,strong)BBGOrderListRequest *orderListRequest;
@property (nonatomic,strong)BBGOrderDeleteRequest *orderDeleteRequest;
@property (nonatomic,strong)BBGOrderConfirmRequest *orderConfirmRequest;
@property (nonatomic,strong)BBGOrderCancelRequest *orderCancelRequest;
@property (nonatomic,strong)BBGOrderAgainPurchaseRequest *orderAgainPurchaseRequest;
@property (nonatomic,assign)NSInteger orderType;
@end

@implementation BBGOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)setStatus:(BBGOrderStatus)status{
    
    _status = status;
    if (status==OBLIGATIONSTATUS) {
        self.orderType = 1;
    }else if (status==NOTRECEIVESTATUS){
        self.orderType = 2;;
    }else if (status==NOTSHOPPEDSTATUS){
        self.orderType = 3;
    }else if (status==HAVERECEIVEDSTATUS){
        self.orderType = 4;
    }else{
        self.orderType = 0;
    }
}

-(void)updateData:(LoadDataCallback)callback{
    [self.orderListRequest cancelRequest];
    self.orderListRequest = [[BBGOrderListRequest alloc] init];
    self.orderListRequest.pageNo = self.currentPage;
    self.orderListRequest.pageSize = self.pageSize;
    self.orderListRequest.orderType = self.orderType;
    [_orderListRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        if (responseData) {
            if (callback) {
                callback(YES,responseData);
            }
        }else{
            if (callback) {
                callback(NO,responseData);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (callback) {
            callback(NO,nil);
        }
    }];
}

#pragma mark - 删除订单操作
-(void)deleteOrderWithOrderId:(NSString *)orderId memberId:(NSString *)memberId callback:(LoadDataCallback)callback{
    [self.orderDeleteRequest cancelRequest];
    self.orderDeleteRequest = [[BBGOrderDeleteRequest alloc] init];
    self.orderDeleteRequest.orderId = orderId;
    self.orderDeleteRequest.memberId = memberId;
    [_orderDeleteRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        if (responseData) {
            if (callback) {
                callback(YES,responseData);
            }
        }else{
            if (callback) {
                callback(NO,responseData);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (callback) {
            callback(NO,nil);
        }
    }];
}

#pragma mark - 确认收货操作
-(void)confirmOrderWithOrderId:(NSString *)orderId memberId:(NSString *)memberId callback:(LoadDataCallback)callback{
    [self.orderConfirmRequest cancelRequest];
    self.orderConfirmRequest = [[BBGOrderConfirmRequest alloc] init];
    self.orderConfirmRequest.orderId = orderId;
    self.orderConfirmRequest.memberId = memberId;
    [_orderConfirmRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        if (responseData) {
            if (callback) {
                callback(YES,responseData);
            }
        }else{
            if (callback) {
                callback(NO,responseData);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (callback) {
            callback(NO,nil);
        }
    }];
}

-(void)cancelOrderWithOrderId:(NSString *)orderId
                 cancelReason:(NSString *)cancelReason
                     callback:(LoadDataCallback)callback{

    [self.orderCancelRequest cancelRequest];
    self.orderCancelRequest = [[BBGOrderCancelRequest alloc] init];
    self.orderCancelRequest.orderId = orderId;
    self.orderCancelRequest.cancelReason = cancelReason;
    [_orderCancelRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        if (responseData) {
            if (callback) {
                callback(YES,responseData);
            }
        }else{
            if (callback) {
                callback(NO,responseData);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (callback) {
            callback(NO,nil);
        }
    }];
    
}


-(void)againPurchaseWithOrderId:(NSString *)orderId
                       callback:(LoadDataCallback)callback{
    [self.orderAgainPurchaseRequest cancelRequest];
    self.orderAgainPurchaseRequest = [[BBGOrderAgainPurchaseRequest alloc] init];
    self.orderAgainPurchaseRequest.orderId = orderId;
    [self.orderAgainPurchaseRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        if (responseData) {
            if (callback) {
                callback(YES,responseData);
            }
        }else{
            if (callback) {
                callback(NO,responseData);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (callback) {
            callback(NO,nil);
        }
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
