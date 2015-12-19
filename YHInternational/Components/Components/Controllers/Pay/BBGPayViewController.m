//
//  BBGPayViewController.m
//  Components
//
//  Created by Holyjoy on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayViewController.h"

@interface BBGPayViewController ()
@property (nonatomic,strong)BBGPayInfoRequest *payInfoRequest;
@property (nonatomic,strong)BBGPayTypeRequest *payTypeRequest;
@property (nonatomic,strong)BBGPaySignInfoRequest *paySignInfoRequest;
@property (nonatomic,strong)BBGPmsMsgRequest *pmsMsgRequest;
@end

@implementation BBGPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)getPayTypeWithCallback:(LoadDataCallback)callback{
    [self.payTypeRequest cancelRequest];
    self.payTypeRequest = [[BBGPayTypeRequest alloc] init];
    [self.payTypeRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
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


-(void)getPaymentOrderInfoWithPayType:(NSString *)payType callback:(LoadDataCallback)callback{
    
    [self.payInfoRequest cancelRequest];
    self.payInfoRequest = [[BBGPayInfoRequest alloc] init];
    self.payInfoRequest.orderIds = self.orderIds;
    self.payInfoRequest.payment = [payType integerValue];
    [self.payInfoRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
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


-(void)getPaymentSignInfoWithPayType:(NSString *)payType orderIds:(NSMutableArray *)orderIds callback:(LoadDataCallback)callback{
    
    [self.paySignInfoRequest cancelRequest];
    self.paySignInfoRequest = [[BBGPaySignInfoRequest alloc] init];
    self.paySignInfoRequest.orderIds = orderIds;
    self.paySignInfoRequest.payment = payType;
    [self.paySignInfoRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
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

-(void)getPmsMessageCallback:(LoadDataCallback)callback{
    [self.pmsMsgRequest cancelRequest];
    self.pmsMsgRequest = [[BBGPmsMsgRequest alloc] init];
    self.pmsMsgRequest.atType = @"2";
    [self.pmsMsgRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
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
