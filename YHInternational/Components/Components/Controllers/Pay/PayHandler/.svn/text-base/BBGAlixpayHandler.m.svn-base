//
//  BBGAlixpayHandler.m
//  Components
//
//  Created by Damon on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAlixpayHandler.h"

#import <AlipaySDK/AlipaySDK.h>

@interface BBGAlixpayHandler ()

@property (nonatomic, strong) BBGPayInfo *payInfo;

@end

@implementation BBGAlixpayHandler

- (id)initWithPayInfo:(BBGPayInfo *)payInfo {
    self = [super init];
    if (self) {
        _payInfo = payInfo;
    }
    return self;
}

- (void)goPay {
    //开始支付
    if ([_payInfo.info isKindOfClass:[NSString class]]) {
        __weak BBGAlixpayHandler *weakself = self;
        [[AlipaySDK defaultService] payOrder:(NSString *)_payInfo.info fromScheme:@"YHinternationalForAlixpay" callback:^(NSDictionary *resultDic) {
            if (resultDic){
                if ([resultDic[@"resultStatus"] intValue] == 9000) {
                    if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(alixpayHandler:payResult:)]) {
                        [weakself.delegate alixpayHandler:weakself payResult:BBGPayResultAlixpaySuccess];
                    }
                }else{
                    //交易失败
                    if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(alixpayHandler:payResult:)]) {
                        [weakself.delegate alixpayHandler:weakself payResult:BBGPayResultAlixpayFailed];
                    }
                }
            }else{
                //失败
                if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(alixpayHandler:payResult:)]) {
                    [weakself.delegate alixpayHandler:weakself payResult:BBGPayResultAlixpayFailed];
                }
            }
        }];
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(alixpayHandler:payResult:)]) {
            [self.delegate alixpayHandler:self payResult:BBGPayResultAlixpayFailed];
        }
    }
}

@end
