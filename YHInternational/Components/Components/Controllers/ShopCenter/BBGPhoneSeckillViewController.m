//
//  PhoneSeckillViewController.m
//  Components
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneSeckillViewController.h"
#import "BBGPhoneSeckillResponse.h"

@interface BBGPhoneSeckillViewController ()

@end

@implementation BBGPhoneSeckillViewController

- (void)updateData:(LoadDataCallback)callback {
    if (!self.phoneRequest) {
        self.phoneRequest = [[BBGPhoneSeckillRequest alloc]init] ;
    }
    self.phoneRequest.pageIndex = self.pageIndex;
    if (!self.phoneSeckillArr) {
        _phoneSeckillArr = [NSMutableArray array];
    }
    
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    WS(ws)
    
    [_phoneRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        BBGPhoneSeckillResponse *results = (BBGPhoneSeckillResponse *)responseData;
        ws.phoneSeckillArr = results.phoneSeckillArr;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
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

- (void)cartDirectRequest:(LoadDataCallback)callback{
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    [_cartDirectRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
    }];
}

- (void)addCartRequet:(LoadDataCallback)callback{
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    
    [_addCartRequet sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(NO,nil);
    }];
}

- (void)buyOrAddInCart:(NSInteger)productType store:(NSInteger)store productId:(NSString *)productId callback:(goSettleMent)callback{
    if (productType==1) {

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
            __weak BBGPhoneSeckillViewController *weakSelf = self;
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
            __weak BBGPhoneSeckillViewController *weakSelf =self;
            
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
