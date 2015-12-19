//
//  BeautyEffectViewController.m
//  Components
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBeautyEffectViewController.h"
#import "BBGBeautyEffectResponse.h"

@interface BBGBeautyEffectViewController ()

@end

@implementation BBGBeautyEffectViewController

- (void)updateData:(LoadDataCallback)callback {
    if (!self.beautyRequest) {
        self.beautyRequest = [[BBGBeautyEffectRequest alloc]init] ;
    }
    if (!self.beautyArr) {
        _beautyArr = [NSMutableArray array] ;
    }
    
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    [_beautyRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        BBGBeautyEffectResponse *results = (BBGBeautyEffectResponse *)responseData;
        self.beautyArr = results.beautyArr;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
