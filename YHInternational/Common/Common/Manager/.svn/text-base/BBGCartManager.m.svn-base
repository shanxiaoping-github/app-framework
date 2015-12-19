//
//  BBGCartManager.m
//  Common
//
//  Created by Damon on 15/5/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCartManager.h"
#import "BBGSimpleCartGetRequest.h"
#import "BBGSimpleCartGetResponse.h"
#import "BBGSimpleCartModel.h"
#import "BBGSessionManager.h"

@interface BBGCartManager()
@property (nonatomic, strong) BBGSimpleCartGetRequest * cartRequest;

@end

@implementation BBGCartManager
DECLARE_SINGLETON(BBGCartManager)

- (void)updateCartData{
    if([BBGSessionManager sharedInstance].isLogin){
        _cartRequest = [[BBGSimpleCartGetRequest alloc]init];
        [_cartRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
            //        if (!responseData.isError) {
            //            BBGSimpleCartGetResponse * response = (BBGSimpleCartGetResponse *)responseData;
            //            [BBGCartManager sharedInstance].cartCount = @(response.simpleCartModel.totalType);
            //        }
        } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
            
        }];
    }
    
}

- (void)setCartCount:(NSNumber *)cartCount{
//    if (_cartCount) {
//        [self setValue:cartCount forKey:@"cartCount"];
//    }
    _cartCount = cartCount;
    
}

- (void)dealloc{
    self.cartCount = nil;
    self.cartRequest = nil;
}
@end
