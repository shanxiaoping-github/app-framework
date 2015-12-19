//
//  BBGEvaluateViewController.m
//  Components
//
//  Created by Holyjoy on 15/5/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEvaluateViewController.h"
#import "Common.h"

@interface BBGEvaluateViewController ()

@property (nonatomic,strong) BBGJudgeUserIsBuyGoodsRequest *judgeUserIsBuyGoodsRequest;
@property (nonatomic,strong) BBGEvaluateRequest *evaluateRequest;
@property (nonatomic,strong) BBGUploadImgRequest *uploadImgRequest;
@end

@implementation BBGEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)JudgeUserIsBuyGoods:(LoadDataCallback)callback {

    if (!_judgeUserIsBuyGoodsRequest) {
        _judgeUserIsBuyGoodsRequest = [[BBGJudgeUserIsBuyGoodsRequest alloc] init];
    }
    _judgeUserIsBuyGoodsRequest.goodsId = _googsId;
    [_judgeUserIsBuyGoodsRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGJudgeUserIsBuyGoodsResponse *response = (BBGJudgeUserIsBuyGoodsResponse *)responseData;
        _orderId = response.orderId;
        _orderTime = response.orderTime;
        _hasOrder = response.hasOrder;
        callback(YES,responseData);
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}

- (void)updateData:(LoadDataCallback)callback {
    if (!_evaluateRequest) {
        _evaluateRequest = [[BBGEvaluateRequest alloc] init];
    }
    _evaluateRequest.goodsId = _googsId;
    _evaluateRequest.comment = _comment;
    _evaluateRequest.orderId = _orderId;
    _evaluateRequest.imgArray = _imgArray;
    
    [_evaluateRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGReplyResponse *replySponse = (BBGReplyResponse *)responseData;
        _evaluateSucessful = replySponse.sucessful;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        callback(NO,nil);
    }];
    
}


- (void)uploadImg:(UIImage*)img callBack:(LoadDataCallback)callback{
    if (!self.uploadImgRequest) {
        self.uploadImgRequest = [[BBGUploadImgRequest alloc] init];
    }
    _uploadImgRequest.imgData = UIImageJPEGRepresentation(img, 1);
    [_uploadImgRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (void)uploadAllImg:(NSArray*)imgArray callBack:(LoadDataCallback)callback{
    if (!self.uploadImgRequest) {
        self.uploadImgRequest = [[BBGUploadImgRequest alloc] init];
    }
    _uploadImgRequest.willUploadImgArray = imgArray;
    [_uploadImgRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    _evaluateRequest = nil;
    _uploadImgRequest = nil;
    _judgeUserIsBuyGoodsRequest = nil;
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
