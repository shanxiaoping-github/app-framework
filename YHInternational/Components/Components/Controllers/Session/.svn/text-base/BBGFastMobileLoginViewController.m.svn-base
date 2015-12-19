//
//  BBGFastMobileLoginViewController.m
//  Components
//
//  Created by Holyjoy on 15/6/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFastMobileLoginViewController.h"

@interface BBGFastMobileLoginViewController ()

@end

@implementation BBGFastMobileLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)getVertification:(FastLoginBlock)finished{
    
    _smsRequest = [[BBGRegisterSmsRequest alloc]init];
    _smsRequest.captcha = self.captchaCode;
    _smsRequest.mobile = self.mobile;
    _smsRequest.sessionId = self.sessionId;
    _smsRequest.isFromFastLoginCtrl = YES;
    __weak BBGFastMobileLoginViewController * weakSelf = self;
    [_smsRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGRegisterSmsResponse * response = (BBGRegisterSmsResponse *)responseData;
        if (response.sessionId) {
            weakSelf.sessionId = response.sessionId;
        }
        weakSelf.verifyCode = response.captcha;
        if (response.imageUrl.length > 0) {
            weakSelf.imageUrl = response.imageUrl;
        }
        if (finished) {
            finished(YES,response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        if (finished) {
            //如果短信验证码超过限制  不走回调
            if (![errorMsg isEqualToString:@"验证码短信发送次数超出限制"]) {
                finished(NO,nil);
            }
        }
    }];
}

- (void)getImageVertification:(FastLoginBlock)finished{
    __weak BBGFastMobileLoginViewController * weakSelf = self;
    
    _imageVertificationRequest = [[BBGRegisterImageVertificationRequest alloc]init];
    _imageVertificationRequest.sessionId = self.sessionId;
    _imageVertificationRequest.isFromFastLoginCtrl = YES;
    [_imageVertificationRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGRegisterImageVertificationResponse * response = (BBGRegisterImageVertificationResponse *)responseData;
        weakSelf.imageUrl = response.imageUrl;
        if (response.sessionId) {
            weakSelf.sessionId = response.sessionId;
        }
        weakSelf.captchaCode = response.captcha;
        finished(YES,response);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}


- (void)fastMobileLoginFinish:(FastLoginBlock)finished{
    
    [BBGSession sharedInstance].mobile = self.mobile;
    [BBGSession sharedInstance].verifyCode = self.verifyCode;
    //后台要求，不需要传图形验证码了
//    [BBGSession sharedInstance].captchaCode = self.captchaCode;
    [BBGSession sharedInstance].sessionId = self.sessionId;
    [[BBGSession sharedInstance] doFastLogin:BBGLoginTypeFastMobile finish:finished controller:self];
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
