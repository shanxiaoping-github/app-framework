//
//  BBGLoginViewController.m
//  Components
//
//  Created by Damon on 15/4/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLoginViewController.h"

#import "BBGLoginRequest.h"

#import "BBGGetLoginVertificationRequest.h"

#import "BBGGetLoginVertificationResponse.h"
@interface BBGLoginViewController ()
@property (nonatomic, strong) BBGGetLoginVertificationRequest * request;
@end

@implementation BBGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BBGSessionHandler Methods
- (void)initialize {
    
}

- (void)qqLoginFinish:(LoginBlock)finished{
    [[BBGSession sharedInstance] dologin:BBGLoginTypeQQ finish:finished controller:self];
}

- (void)webCahtLoginFinish:(LoginBlock)finished{
    [[BBGSession sharedInstance] dologin:BBGLoginTypeWebChat finish:finished controller:self];
}

- (void)sinaLoginFinish:(LoginBlock)finished{
    [[BBGSession sharedInstance] dologin:BBGLoginTypeSina finish:finished controller:self];
}

- (void)mobileLoginFinish:(LoginBlock)finished{
    [BBGSession sharedInstance].loginName = self.loginStr;
    [BBGSession sharedInstance].password = self.password;
    [BBGSession sharedInstance].captcha = self.vertification;
    [[BBGSession sharedInstance] dologin:BBGLoginTypeMobile finish:finished controller:self];
}

- (void)getCaptchaImage:(LoginBlock)finished{
    
    __weak BBGLoginViewController * weakSelf = self;
    _request = [[BBGGetLoginVertificationRequest alloc]init];
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGGetLoginVertificationResponse * response = (BBGGetLoginVertificationResponse *)responseData;
        weakSelf.imageUrl = response.imageUrl;
        weakSelf.sessionId = response.sessionId;
        if (finished) {
            if (response.imageUrl) {
                finished(YES);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] showTips:@"验证码获取失败"];
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
