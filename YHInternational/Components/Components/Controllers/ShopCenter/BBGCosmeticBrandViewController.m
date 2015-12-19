//
//  BBGCosmeticBrandViewController.m
//  Components
//
//  Created by Timmy OuYang on 15/7/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCosmeticBrandViewController.h"

@interface BBGCosmeticBrandViewController ()

//@property (strong, nonatomic) BBGCosmeticBrandListRequest *request;BBGRequest
@property (strong, nonatomic) BBGRequest *request;
@end

@implementation BBGCosmeticBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _brandsArray = [NSMutableArray array];
}

- (void)updateData:(LoadDataCallback)callback {

    switch (self.typeTag) {
        case 1:
            _request = [[BBGFoodBrandListRequest alloc]init];
            break;
        case 2:
            _request = [[BBGHealthBrandListRequest alloc]init];
            break;
        default:
            _request = [[BBGCosmeticBrandListRequest alloc] init];
            break;
    }
    
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGCosmeticBrandListResponse *cosmeticResponse = (BBGCosmeticBrandListResponse *)responseData;
        if (cosmeticResponse.popularBrands.count>0) {
            [_brandsArray addObjectsFromArray:cosmeticResponse.popularBrands];
        }
        
        if (cosmeticResponse.recommendBrands.count>0) {
            [_brandsArray addObjectsFromArray:cosmeticResponse.recommendBrands];
        }
        
        if (_brandsArray.count == 0) {
            callback(NO, 0);
        }
        callback(YES,cosmeticResponse);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO, nil);
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
