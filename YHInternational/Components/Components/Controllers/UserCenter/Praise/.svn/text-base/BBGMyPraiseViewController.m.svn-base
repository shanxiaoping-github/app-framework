//
//  BBGMyPraiseViewController.m
//  Components
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMyPraiseViewController.h"

@interface BBGMyPraiseViewController ()

@property (nonatomic,strong) BBGPraiseProductListReqeust *praiseProductListRequest;

@end

@implementation BBGMyPraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _productArray = [[NSMutableArray alloc] init];
    _pageIndex = 1;
    _pageSize = 20;
}


- (void)updateData:(LoadDataCallback)callback{
    if (!self.praiseProductListRequest) {
        self.praiseProductListRequest = [[BBGPraiseProductListReqeust alloc] init];
    }
    self.praiseProductListRequest.pageIndex = self.pageIndex;
    self.praiseProductListRequest.pageSize = self.pageSize;
    [_praiseProductListRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGPraiseProductListResponse *response = (BBGPraiseProductListResponse*)responseData;
        if (_pageIndex == 1) {
            [_productArray removeAllObjects];
        }
        if ([response.productListArray COUNT] != 20) {
            self.tableView.showsInfiniteScrolling = NO;
        }else{
            if (!self.tableView.showsInfiniteScrolling) {
                self.tableView.showsInfiniteScrolling = YES;
            }
        }
        [_productArray ARRAY_ADD_OBJS_FROM_ARRAY(response.productListArray)];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}


- (BBGCancelPraiseRequest *)cancelPraiseRequest{
    if (!_cancelPraiseRequest) {
        _cancelPraiseRequest = [[BBGCancelPraiseRequest alloc] init];
    }
    return _cancelPraiseRequest;
}

- (void)cancelPraiseRequest:(LoadDataCallback)callBack{
    [_cancelPraiseRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callBack(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}


- (BBGAddPraiseRequest *)addPraisePraiseRequest{
    if (!_addPraisePraiseRequest) {
        _addPraisePraiseRequest = [[BBGAddPraiseRequest alloc] init];
    }
    return _addPraisePraiseRequest;
}

- (void)addPraiseRequest:(LoadDataCallback)callBack{
    [_addPraisePraiseRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callBack(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}


@end
