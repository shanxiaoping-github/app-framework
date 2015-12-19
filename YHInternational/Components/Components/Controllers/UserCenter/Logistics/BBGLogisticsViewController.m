//
//  BBGLogisticsViewController.m
//  Components
//
//  Created by Damon on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLogisticsViewController.h"
#import "Common.h"
@interface BBGLogisticsViewController ()
@property (nonatomic, strong) BBGLogisticsRequest * request;
@end

@implementation BBGLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getLogisticData:(void (^)(BOOL successful, id responseData))block{

    _request = [[BBGLogisticsRequest alloc] init];
    _request.pageSize = 20;
    _request.pageNo = self.pageNumber;
    
    __weak BBGLogisticsViewController * weakSelf = self;
    
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGLogisticsResponse * logisticsResponse = (BBGLogisticsResponse *)responseData;
        if (weakSelf.pageNumber == 1 && weakSelf.listArray.count != 0) {
            [weakSelf.listArray removeAllObjects];
        }
        [weakSelf.listArray addObjectsFromArray:logisticsResponse.ordersLogisticsList];
        if (block) {
            block(YES,logisticsResponse);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (block) {
            block(NO,errorMsg);
        }
    }];
}

- (void)dealloc{
    [_request cancelRequest];
    _request = nil;
    self.listArray = nil;
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
