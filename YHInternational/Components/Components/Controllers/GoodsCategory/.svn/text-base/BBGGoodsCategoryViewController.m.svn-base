//
//  BBGGoodsCategoryViewController.m
//  Components
//
//  Created by Timmy Ouyang on 15/4/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsCategoryViewController.h"
#import "BBGSearchFilterRequest.h"


@interface BBGGoodsCategoryViewController ()

@property (nonatomic, strong) BBGSearchFilterRequest *searchFilterRequest;

@end

@implementation BBGGoodsCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateData:(LoadDataCallback)callback {

    if (!_searchFilterRequest) {
        _searchFilterRequest = [[BBGSearchFilterRequest alloc] init];
    }
    _searchFilterRequest.backCate = self.backCate;
    _searchFilterRequest.lastFCate = self.fcate;
    _searchFilterRequest.lastKWs = self.keywords;
    [_searchFilterRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES, responseData);

    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO, nil);
    }];
}

- (void)dealloc
{
    [_searchFilterRequest cancelRequest];
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
