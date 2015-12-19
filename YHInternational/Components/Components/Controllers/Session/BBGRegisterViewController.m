//
//  BBGRegisterViewController.m
//  Components
//
//  Created by Damon on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegisterViewController.h"

@interface BBGRegisterViewController ()
@property (nonatomic, strong) BBGRegisterRequest * registerRequest;
@property (nonatomic, strong) BBGRegisterSmsRequest * smsRequest;
@property (nonatomic, strong) BBGRegisterImageVertificationRequest * imageVertificationRequest;
@end

@implementation BBGRegisterViewController

- (void)dealloc{
    self.registerRequest = nil;
    self.smsRequest = nil;
    self.imageVertificationRequest = nil;
    self.mobile = nil;
    self.callback = nil;
    self.captcha = nil;
    self.password = nil;
    self.sessionId = nil;
    self.imageUrl = nil;
    self.imageCaptcha = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerUser:(RegisterBlock)finished{
    _registerRequest = [[BBGRegisterRequest alloc]init];
    _registerRequest.sessionId = self.sessionId;
    _registerRequest.password = self.password;
    _registerRequest.imageCaptcha = self.imageCaptcha;
    _registerRequest.mobile = self.mobile;
    _registerRequest.smsCaptcha = self.captcha;
    __weak BBGRegisterViewController * weakSelf = self;
    [_registerRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGRegisterResponse * response = (BBGRegisterResponse *)responseData;
        if (response.sessionId) {
            weakSelf.sessionId = response.sessionId;
        }
        if (response.result) {
            [BBGSession sharedInstance].loginName = weakSelf.mobile;
            [BBGSession sharedInstance].password = weakSelf.password;
            
            [[BBGSession sharedInstance]dologin:BBGLoginTypeMobile finish:^(BOOL successful) {
                if (finished) {
                    finished(YES,nil);
                }
            } controller:weakSelf];
        }else{
            if (finished) {
                finished(NO,response);
            }
            //注册失败
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (void)getVertification:(RegisterBlock)finished{
    
    _smsRequest = [[BBGRegisterSmsRequest alloc]init];
    _smsRequest.captcha = self.imageCaptcha;
    _smsRequest.mobile = self.mobile;
    _smsRequest.sessionId = self.sessionId;
    __weak BBGRegisterViewController * weakSelf = self;
    [_smsRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGRegisterSmsResponse * response = (BBGRegisterSmsResponse *)responseData;
        if (response.sessionId) {
            weakSelf.sessionId = response.sessionId;
        }
        weakSelf.captcha = response.captcha;
        if (response.imageUrl.length > 0) {
            weakSelf.imageUrl = response.imageUrl;
        }
        if (finished) {
            finished(YES,response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        if (finished) {
            finished(NO,nil);
        }
    }];
}

- (void)getImageVertification:(RegisterBlock)finished{
    __weak BBGRegisterViewController * weakSelf = self;

    _imageVertificationRequest = [[BBGRegisterImageVertificationRequest alloc]init];
    _imageVertificationRequest.sessionId = self.sessionId;
    
    [_imageVertificationRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGRegisterImageVertificationResponse * response = (BBGRegisterImageVertificationResponse *)responseData;
        weakSelf.imageUrl = response.imageUrl;
        if (response.sessionId) {
            weakSelf.sessionId = response.sessionId;
        }
        weakSelf.captcha = response.captcha;
        finished(YES,response);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
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
