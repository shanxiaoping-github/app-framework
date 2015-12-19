//
//  MaternalAndBeautyViewController.m
//  Components
//
//  Created by 刘薇 on 15/7/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMaternalAndBeautyViewController.h"


@interface BBGMaternalAndBeautyViewController ()

@end

@implementation BBGMaternalAndBeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getMaternalOrBeautyData:(void (^)(BOOL isfinished,id response))callback{
    _request = [[BBGMaternalORBeautyRequest alloc]init];
    _request.tagType = _tagType ;
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (!responseData.isError) {
            if (callback) {
                callback(YES,responseData);
            }
        }else{
            if (callback) {
                callback(NO,responseData.errorMsg);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (callback) {
            callback(NO,errorMsg);
        }
    }];
    
}
- (void)getMoreData:(void (^)(BOOL, id))callback{
    
    _moreMaternalORBeautyRequest = [[BBGMoreMaternalORBeautyRequest alloc]init];
    if (self.tagType == 1) {
        _moreMaternalORBeautyRequest.type = 2;
    } else if(self.tagType == 2){
        _moreMaternalORBeautyRequest.type = 1;
    }else if(self.tagType == 3){
        _moreMaternalORBeautyRequest.type = 3;
        
    }
    _moreMaternalORBeautyRequest.pageIndex = self.nowPage+1;
    _moreMaternalORBeautyRequest.pageSize  = 20;
    [_moreMaternalORBeautyRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance]hideTips];
        if (!responseData.isError) {
            if (callback) {
                callback(YES,responseData);
            }
        }
        if (responseData.isError) {
            if (callback) {
                callback(NO,responseData.errorMsg);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        if (callback) {
            callback(NO,errorMsg);
        }
    }];
    
}

- (BBGAddCartRequest *)addCartRequet{
    if (!_addCartRequet) {
        _addCartRequet = [[BBGAddCartRequest alloc] init];
    }
    return _addCartRequet;
}

- (BBGCartDirectRequest *)cartDirectRequest{
    if (!_cartDirectRequest) {
        _cartDirectRequest = [[BBGCartDirectRequest alloc] init];
    }
    return _cartDirectRequest;
}
- (void)addCartRequet:(LoadDataCallback)callback{
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    [_addCartRequet sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        [[BBGLoadingTips sharedInstance] hideTips];
    }];
}

- (void)cartDirectRequest:(LoadDataCallback)callback{
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    [_cartDirectRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        [[BBGLoadingTips sharedInstance] hideTips];
    }];
}

-(void)buyOrAddInCart:(NSInteger)productType store:(NSInteger)store productId:(NSString *)productId callback:(goSettleMent)callback{
    if (productType==1||productType==2||productType==3) {
        /**
         *  立即购买有库存
         */
        self.cartDirectRequest.productId=productId;
        self.cartDirectRequest.quantity=1;
        if ([BBGSessionManager sharedInstance].isLogin) {
            [self cartDirectRequest:^(BOOL sucessful, BBGResponse *response) {
                if (sucessful) {
                    //跳结算
                    callback(YES);
                }
                else
                {
                    callback(NO);
                }
            }];
        }
        else
        {
            __weak BBGMaternalAndBeautyViewController *weakSelf = self;
            [[BBGSessionManager sharedInstance]doLogin:^(BOOL successful) {
                if (successful) {
                    [weakSelf cartDirectRequest:^(BOOL sucessful, BBGResponse *response) {
                        if (successful) {
                            /**
                             *  跳结算
                             */
                            callback(YES);
                        }
                    }];
                }
                else
                {
                    callback(NO);
                }
            }];
        }
    }
    else
    {
        /**
         *  加入购物车有库存
         */
        self.addCartRequet.productId = productId;
        self.addCartRequet.quantity =1;
        if ([BBGSessionManager sharedInstance].isLogin) {
            [self addCartRequet:^(BOOL sucessful, BBGResponse *response) {
                if (sucessful) {
                    [[BBGLoadingTips sharedInstance] showTips:@"加入购物车成功"];
                }
            }];
            callback(NO);
            
        }
        else
        {
            __weak BBGMaternalAndBeautyViewController * weakSelf =self;
            
            [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                if (successful) {
                    [weakSelf addCartRequet:^(BOOL sucessful, BBGResponse *response) {
                        if (sucessful) {
                            [[BBGLoadingTips sharedInstance] showTips:@"加入购物车成功"];
                            
                        }
                    }];
                }
            }];
            callback(NO);
            
        }
    }
    
}

- (void)dealloc{
    
    [_request cancelRequest];
    [_moreMaternalORBeautyRequest cancelRequest];
    [_cartDirectRequest cancelRequest];
    [_addCartRequet cancelRequest];
    self.moreMaternalORBeautyRequest = nil;
    self.request = nil;
    self.cartDirectRequest = nil;
    self.addCartRequet = nil;

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
