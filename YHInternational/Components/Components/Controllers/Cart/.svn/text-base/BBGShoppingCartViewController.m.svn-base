//
//  BBGShoppingCarViewController.m
//  Components
//
//  Created by yangjie on 15/5/11.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShoppingCartViewController.h"

@interface BBGShoppingCartViewController ()

@property (nonatomic,strong) BBGCartGetReqeust *cartGetRequest;

@end

@implementation BBGShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateData:(LoadDataCallback)callback{
    if (!_cartGetRequest) {
        _cartGetRequest = [[BBGCartGetReqeust alloc] init];
    }
    __weak BBGShoppingCartViewController *weakSelf = self;
    [self.cartGetRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGCartGetResponse *response= (BBGCartGetResponse*)responseData;
        weakSelf.productsCart = response.productsCart;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}


- (BBGUpdateCartRequest *)updateCartRequest{
    if (!_updateCartRequest) {
        _updateCartRequest = [[BBGUpdateCartRequest alloc] init];
    }
    return _updateCartRequest;
}

- (void)shoppingCartUpdate:(LoadDataCallback)callback{
    __weak BBGShoppingCartViewController *weakSelf = self;
    [self.updateCartRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGUpdateCartResponse *response= (BBGUpdateCartResponse*)responseData;
        weakSelf.productsCart = response.productsCart;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}


- (BBGCheckCartRequest *)checkCartRequest{
    if (!_checkCartRequest) {
        _checkCartRequest = [[BBGCheckCartRequest alloc] init];
    }
    return _checkCartRequest;
}

- (void)shoppingCartChechk:(LoadDataCallback)callback;{
    __weak BBGShoppingCartViewController *weakSelf = self;
    [self.checkCartRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGCheckCartResponse *response= (BBGCheckCartResponse*)responseData;
        weakSelf.productsCart = response.productsCart;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}



- (BBGCartRemoveRequest *)removeCartRequest{
    if (!_removeCartRequest) {
        _removeCartRequest = [[BBGCartRemoveRequest alloc] init];
    }
    return _removeCartRequest;
}

- (void)shoppingCartRemove:(LoadDataCallback)callback{
    __weak BBGShoppingCartViewController *weakSelf = self;
    [self.removeCartRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGCheckCartResponse *response= (BBGCheckCartResponse*)responseData;
        weakSelf.productsCart = response.productsCart;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}

@end
