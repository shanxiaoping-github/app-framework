//
//  BBGGoodsDetailViewController.m
//  Components
//
//  Created by 彭腾 on 15-5-5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsDetailViewController.h"
#import "Common.h"
#import "BBGGoodsSpecRequest.h"
#import "BBGGoodsSpecResponse.h"
#import "BBGGoodsBasicInfo.h"
#import "BBGGoodsSpecInfo.h"
#import "BBGAddCartRequest.h"
#import "BBGCartNumRequest.h"
#import "BBGCartNumResponse.h"
#import "BBGCartDirectRequest.h"

@interface BBGGoodsDetailViewController ()
@property (nonatomic, strong) BBGGoodsDetailRequest *detailRequest;
@end

@implementation BBGGoodsDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commentPageSize = 5;
        self.praisePageSize = 10;
    }
    return self;
}

- (void)updateData:(LoadDataCallback)callback {
    if (!self.detailRequest) {
        self.detailRequest = [[BBGGoodsDetailRequest alloc]init];
    }
    _detailRequest.productId = self.productId;
    _detailRequest.commentPageSize = 5;
    _detailRequest.praisePageSize = 10;
    _detailRequest.barCode = self.barCode;
    _detailRequest.goodsId = self.goodsId;
    
    if (!self.praiseMembsArr) {
        _praiseMembsArr = [NSMutableArray array];
    }
    
    if (!self.goodsTipArr) {
        _goodsTipArr = [NSMutableArray array];
    }
    
    if (!self.promotionActivitiesArr) {
        _promotionActivitiesArr = [NSMutableArray array];
    }
    
    if (!self.goodsImagesArr) {
        _goodsImagesArr = [NSMutableArray array];
    }
    
    if (!self.commentListArr) {
        _commentListArr = [NSMutableArray array];
    }
    
    if (!self.goodsSpecsListArr) {
        _goodsSpecsListArr = [NSMutableArray array];
    }
    
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    __weak BBGGoodsDetailViewController *weakSelf = self;
    
    [_detailRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        BBGGoodsDetailResponse *results = (BBGGoodsDetailResponse *)responseData;
        weakSelf.praiseMembsArr = [NSMutableArray arrayWithArray:results.praiseMembsArr];
        weakSelf.goodsTipArr = results.goodsTipArr;
        weakSelf.promotionActivitiesArr = results.promotionActivitiesArr;
        weakSelf.goodsImagesArr = results.goodsImagesArr;
        weakSelf.basicInfo = [results.basicInfo ARRAY_OBJ_AT(0)];
        weakSelf.commentListArr = results.commentListArr;
        weakSelf.goodsSpecsListArr = [NSMutableArray arrayWithArray:results.goodsSpecsListArr];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
    }];
}

- (void)addPraiseRequest:(LoadDataCallback)callback{
    if (!self.addPraiseRequest) {
        self.addPraiseRequest = [[BBGAddPraiseRequest alloc]init];
    }
    if (self.productId!=nil) {
        _addPraiseRequest.productId = self.productId;
    }else {
        _addPraiseRequest.productId = self.basicInfo.productId;
    }
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    
    [_addPraiseRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
    }];
}

- (void)cancelPraiseRequest:(LoadDataCallback)callback {
    if (!self.cancelPraiseRequest) {
        self.cancelPraiseRequest = [[BBGCancelPraiseRequest alloc]init];
    }
    if (self.productId!=nil) {
        _cancelPraiseRequest.productId = self.productId;
    }else {
        _cancelPraiseRequest.productId = self.basicInfo.productId;
    }
    
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    
    [_cancelPraiseRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
    }];
}

- (void)reloadGoodsSpecRequest:(LoadDataCallback)callback {
    if (!self.specRequest) {
        self.specRequest = [[BBGGoodsSpecRequest alloc]init];
    }
    _specRequest.goodsId = self.basicInfo.goodsId;
    _specRequest.filterText = self.filterText;
    _specRequest.provine = self.provine;
    _specRequest.city = self.city;
    _specRequest.township = self.township;
    
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    
    WS(ws)
    
    [_specRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        BBGGoodsSpecResponse *results = (BBGGoodsSpecResponse *)responseData;
        ws.goodsSpecsListArr = [NSMutableArray arrayWithArray:results.specQueryArr];
        ws.specInfo = results.specInfo;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
    }];
}

- (void)addCartRequest:(LoadDataCallback)callback {
    if (!self.addCartRequest) {
        self.addCartRequest = [[BBGAddCartRequest alloc]init];
    }
    if (self.specInfo.productId.length!=0) {
        _addCartRequest.productId = self.specInfo.productId;
    }else if (self.productId.length!=0) {
        _addCartRequest.productId = self.productId;
    }else {
        _addCartRequest.productId = self.basicInfo.productId;
    }
    
    _addCartRequest.quantity = 1;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    
    [_addCartRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
    }];
}

- (void)cartNumRequest:(LoadDataCallback)callback {
    if (!self.cartNumRequest) {
        self.cartNumRequest = [[BBGCartNumRequest alloc]init];
    }
    
    WS(ws)
    
    [_cartNumRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGCartNumResponse *results = (BBGCartNumResponse *)responseData;
        ws.cartNum = results.cartNum;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}

- (void)cartDirectRequest:(LoadDataCallback)callback {
    if (!self.cartDirectRequest) {
        self.cartDirectRequest = [[BBGCartDirectRequest alloc]init];
    }
    if (self.specInfo.productId.length!=0) {
        _cartDirectRequest.productId = self.specInfo.productId;
    }else if (self.productId.length!=0) {
        _cartDirectRequest.productId = self.productId;
    }else {
        _cartDirectRequest.productId = self.basicInfo.productId;
    }
    
    _cartDirectRequest.quantity = 1;
    [_cartDirectRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
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
    [_detailRequest cancelRequest];
    [_addCartRequest cancelRequest];
    [_cancelPraiseRequest cancelRequest];
    [_specRequest cancelRequest];
    [_cartNumRequest cancelRequest];
    [_cartDirectRequest cancelRequest];
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
