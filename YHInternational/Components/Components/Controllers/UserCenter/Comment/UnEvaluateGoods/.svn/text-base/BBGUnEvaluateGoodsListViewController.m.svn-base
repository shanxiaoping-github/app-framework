//
//  BBGUnEvaluateGoodsListViewController.m
//  Components
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUnEvaluateGoodsListViewController.h"
#import "Common.h"

@interface BBGUnEvaluateGoodsListViewController ()

@property (nonatomic,strong) BBGUnEvaluateRequest *unEvaluateGoodsListRequest;
@end

@implementation BBGUnEvaluateGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _unEvaluateGoodsArray = [[NSMutableArray alloc] init];
    _pageIndex = 1;
    _pageSize = 20;
    _canLoadMore = YES;
    // Do any additional setup after loading the view.
}

- (void)updateData:(LoadDataCallback)callback{
    if (!_unEvaluateGoodsListRequest) {
        _unEvaluateGoodsListRequest = [[BBGUnEvaluateRequest alloc] init];
    }
    _unEvaluateGoodsListRequest.pageIndex = self.pageIndex;
    _unEvaluateGoodsListRequest.pageSize = self.pageSize;
    
    [_unEvaluateGoodsListRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGUnEvaluateResponse *response = (BBGUnEvaluateResponse*)responseData;
        if (_pageIndex == 1) {
            [_unEvaluateGoodsArray removeAllObjects];
        }
        [_unEvaluateGoodsArray addObjectsFromArray:response.unEvaluateGoodsListArray];
        if ([response.unEvaluateGoodsListArray count] < _pageSize) {
            _canLoadMore = NO;
        }

        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        callback(NO,nil);
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
