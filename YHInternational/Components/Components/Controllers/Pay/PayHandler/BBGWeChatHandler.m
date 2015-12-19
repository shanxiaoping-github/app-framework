//
//  BBGWeChatHandler.m
//  Components
//
//  Created by calvin on 14-9-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGWeChatHandler.h"
#import "WXApi.h"
#import "JSONKit.h"
#import "BBGAlertView.h"

@interface BBGWeChatHandler ()

@property (nonatomic, strong) BBGPayInfo *payInfo;

@end

@implementation BBGWeChatHandler

- (id)initWithPayInfo:(BBGPayInfo *)payInfo {
    self = [super init];
    if (self) {
        _payInfo = payInfo;
    }
    return self;
}

- (void)goPay {
    if ([WXApi isWXAppInstalled]) {
        NSString * info = _payInfo.info;
        NSDictionary * dic = [info objectFromJSONString];
        if ([[info objectFromJSONString] isKindOfClass:[NSDictionary class]]) {
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = dic[@"data"][@"partnerid"];
            request.prepayId= dic[@"data"][@"prepayid"];
            request.package = @"Sign=WXPay";
            request.nonceStr= dic[@"data"][@"noncestr"];
            request.timeStamp= ((NSNumber *)dic[@"data"][@"timestamp"]).intValue;
            request.sign= dic[@"data"][@"sign"];
    
            [WXApi sendReq:request];
//            [WXApi safeSendReq:request];
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(weChatHandler:payResult:)]) {
                [self.delegate weChatHandler:self payResult:BBGPayResultWeChatPayFailed];
            }
        }
    }else{

        [BBGAlertView showWithTitle:@"" message:@"还没有安装微信，请先安装微信" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(weChatHandler:payResult:)]) {
                [self.delegate weChatHandler:self payResult:BBGPayResultWeChatPayFailed];
            }
            if (buttonIndex == 0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8"]];
            }

        } buttonTitles:@"安装", nil];
        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有安装微信客户端，是否前往下载安装？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"安装", nil];
//        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(weChatHandler:payResult:)]) {
//        [self.delegate weChatHandler:self payResult:BBGPayResultWeChatPayFailed];
//    }
//    if (buttonIndex == 1) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8"]];
//    }
//}

@end
