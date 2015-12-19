//
//  BBGPayHandler.h
//  Components
//
//  Created by calvin on 14-9-1.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PAYRESULTKEY @"PAY_RESULT_KEY"
#define PAYMSGKEY @"PAY_MESSAGE_KEY"
#define PAYACTIVITYKEY @"PAY_ACTIVITY_KEY"
typedef enum {
    BBGPayResultNone,
    BBGPayResultAlixpaySuccess,
    BBGPayResultAlixpayCancel,
    BBGPayResultAlixpayFailed,
    BBGPayResultICBCPaySuccess,
    BBGPayResultICBCPayCancel,
    BBGPayResultICBCPayFailed,
    BBGPayResultWeChatPaySuccess,
    BBGPayResultWeChatPayCancel,
    BBGPayResultWeChatPayFailed,
    BBGPayResultUnionPaySuccess,
    BBGPayResultUnionPayCancel,
    BBGPayResultUnionPayFailed,
    BBGPayResultCCBPaySuccess,
    BBGPayResultCCBPayCancel,
    BBGPayResultCCBPayFailed,
    BBGPayResultBCMPaySuccess,
    BBGPayResultBCMPayCancel,
    BBGPayResultBCMPayFailed,
    BBGPayResultGaoCoinPayFailed,
    BBGPayResultGaoCoinPaySuccess,
    BBGPayResultBusinessCardPayCancel,
    BBGPayResultBusinessCardPayFailed,
    BBGPayResultBusinessCardPaySuccess,
    BBGPayResultPSBCPaySuccess, //邮政
    BBGPayResultPSBCPayCancel,
    BBGPayResultPSBCPayFailed,
    BBGPayResultBOCPaySuccess,   //中国
    BBGPayResultBOCPayCancel,
    BBGPayResultBOCPayFailed,
    BBGPayResultCMBPaySuccess,   //招商
    BBGPayResultCMBPayCancel,
    BBGPayResultCMBPayFailed,
    BBGPayResultLifeUnionPaySuccess,
    BBGPayResultLifeUnionPayCancel,
    BBGPayResultLifeUnionPayFailed
}BBGPayResult;

@protocol BBGPayHandler <NSObject>

- (void)goPay;

@end
