//
//  BBGUnionPayHandler.m
//  Components
//
//  Created by calvin on 14-9-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGUnionPayHandler.h"
#import "UPPayPlugin.h"
#import "BBGConstants.h"
#import "BBGURLManager.h"

@interface BBGUnionPayHandler () <UPPayPluginDelegate>

@property (nonatomic, strong) BBGPayInfo *payInfo;

@end

@implementation BBGUnionPayHandler

- (id)initWithPayInfo:(BBGPayInfo *)payInfo {
    self = [super init];
    if (self) {
        _payInfo = payInfo;
    }
    return self;
}

- (void)goPay {
    if ([_payInfo.info isKindOfClass:[NSString class]]) {
        [UPPayPlugin startPay:_payInfo.info mode:UNIONPAYMODE viewController:self.fromVC delegate:self];
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(unionPayHandler:payResult:)]) {
            [self.delegate unionPayHandler:self payResult:BBGPayResultUnionPayFailed];
        }
    }
}

-(void)UPPayPluginResult:(NSString*)result {
    BBGPayResult payResult = BBGPayResultNone;
    if ([result isEqualToString:@"success"]) {
        payResult = BBGPayResultUnionPaySuccess;
    }else if ([result isEqualToString:@"fail"]) {
        payResult = BBGPayResultUnionPayFailed;
    }else if ([result isEqualToString:@"cancel"]) {
        payResult = BBGPayResultUnionPayCancel;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(unionPayHandler:payResult:)]) {
        [self.delegate unionPayHandler:self payResult:payResult];
    }
}

- (void)dealloc{
    self.fromVC = nil;
    self.payInfo = nil;
}

@end
