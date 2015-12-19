//
//  BBGIndexRecommendViewController.m
//  Components
//
//  Created by 黄 灿 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIndexRecommendViewController.h"

@interface BBGIndexRecommendViewController ()

@end

@implementation BBGIndexRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_request cancelRequest];
    [_MoreRequest cancelRequest];
    self.request = nil;
    self.MoreRequest = nil;
}

- (void)getIndexBaseData:(void (^)(BOOL, id))callback{
       
    _request = [[BBGIndexRecomendRequest alloc]init];
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
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

- (void)getindexMoreData:(void (^)(BOOL, id))callback{
    _MoreRequest = [[BBGIndexRecomendMoreRequest alloc]init];
    _MoreRequest.pageIndex=self.nowPage;
    _MoreRequest.pageSize=20;
    [_MoreRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
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
                __weak BBGIndexRecommendViewController *weakSelf = self;
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
//                __weak BBGIndexRecommendViewController * weakSelf =self;
                [self addCartRequet:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        [[BBGLoadingTips sharedInstance] showTips:@"加入购物车成功"];
                    }
                }];
                callback(NO);
                
            }
            else
            {
                __weak BBGIndexRecommendViewController * weakSelf =self;
                
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
@end
