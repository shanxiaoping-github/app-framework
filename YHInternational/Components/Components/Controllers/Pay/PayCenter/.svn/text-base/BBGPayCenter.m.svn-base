//
//  BBGPayCenter.m
//  Components
//
//  Created by Damon on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayCenter.h"
#import "Common.h"

#import "BBGAlixpayHandler.h"
#import "BBGWeChatHandler.h"
#import "BBGUnionPayHandler.h"

#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface BBGPayCenter()<BBGAlixpayDelegate,BBGWeChatDelegate,WXApiDelegate,BBGUnionPayDelegate>
@property (nonatomic, copy) PayAction callblock;
@end

@implementation BBGPayCenter
DECLARE_SINGLETON(BBGPayCenter)

- (id<BBGPayHandler>)buildPayHandlerWith:(BBGPayInfo *)payInfo viewController:(UIViewController *)fromVC{
    id<BBGPayHandler> handler;
    if ([payInfo.paymentID isEqualToString:@"2"]) {
        /*!
         *  支付宝
         */
        BBGAlixpayHandler *alixpayHandler = [[BBGAlixpayHandler alloc] initWithPayInfo:payInfo];
        
        alixpayHandler.delegate = self;
        handler = alixpayHandler;
        
    }else if ([payInfo.paymentID isEqualToString:@"20"]) {
        //微信支付
        BBGWeChatHandler *weChatHandler = [[BBGWeChatHandler alloc] initWithPayInfo:payInfo];
        weChatHandler.delegate = self;
        handler = weChatHandler;
    }else if ([payInfo.paymentID isEqualToString:@"10"]) {
        //银联支付
        BBGUnionPayHandler *unionPayHandler = [[BBGUnionPayHandler alloc] initWithPayInfo:payInfo];
        if(fromVC){
            unionPayHandler.fromVC = fromVC;
        }
        unionPayHandler.delegate = self;
        handler = unionPayHandler;
    }
    return handler;
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setResultAction:(PayAction)block{
    if (block) {
        self.callblock = block;
    }
}

#pragma mark -- 处理支付宝回调
- (void)handleAlixpayURL:(NSURL *)url{
    
    
    __weak BBGPayCenter * weakSelf = self;
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        if (resultDic) {
            if ([resultDic[@"resultStatus"] intValue] == 9000) {
                //成功
                if (weakSelf.callblock) {
                    weakSelf.callblock(BBGPayResultAlixpaySuccess);
                }
            }else{
                //失败
                if (weakSelf.callblock) {
                    weakSelf.callblock(BBGPayResultAlixpayFailed);
                }
            }
        }else{
            //失败
            if (_callblock) {
                _callblock(BBGPayResultAlixpayFailed);
            }
        }
    }];
}

#pragma mark - BBGAlixpayDelegate
- (void)alixpayHandler:(BBGAlixpayHandler *)handler payResult:(BBGPayResult)result{
    if (_callblock) {
        _callblock(result);
    }
}



#pragma mark - 处理微信支付回调
- (void)handleWeChatURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - WXApiDelegate
-(void) onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess:
            {
                if (_callblock) {
                    _callblock(BBGPayResultWeChatPaySuccess);
                }
            }
                break;
            default:
            {
                if (_callblock) {
                    _callblock(BBGPayResultWeChatPayFailed);
                }
            }
                break;
        }
    }
}

#pragma mark - BBGWeChatDelegate
- (void)weChatHandler:(BBGWeChatHandler *)handler payResult:(BBGPayResult)result {
    if (_callblock) {
        _callblock(result);
    };
}

#pragma mark - BBGUnionPayDelegate
- (void)unionPayHandler:(BBGUnionPayHandler *)handler payResult:(BBGPayResult)result {
    if (_callblock) {
        _callblock(result);
    };
}

@end
