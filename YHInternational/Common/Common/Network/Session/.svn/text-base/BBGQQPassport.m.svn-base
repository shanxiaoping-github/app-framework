//
//  BBGQQPassport.m
//  Common
//
//  Created by calvin on 14-5-4.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGQQPassport.h"
#import "Common.h"
#import "BBGConstants.h"

#import "UMSocial.h"
//#import <TencentOpenAPI/TencentOAuth.h>

#define QQINSTALLALERTTAG 1
#define QQLOGINALERTTAG 2

@interface BBGQQPassport ()<UMSocialUIDelegate>
//<BBGRequestDelegate,TencentSessionDelegate>

//@property (nonatomic, strong) TencentOAuth *tencentOAuth;
//@property (nonatomic, strong) NSString *openID;
//@property (nonatomic, strong) NSString *accesstoken;
//@property (nonatomic, strong) BBGQQLoginRequest *qqLoginRequest;
//@property (nonatomic, strong) NSArray *permissions;
//@property (nonatomic, strong) NSString *loginUsername;
//@property (nonatomic, strong) NSString *vipAccountID;
//@property (nonatomic, strong) NSString *vipUsertoken;
//@property (nonatomic, strong) NSString *vipUsersecret;
//@property (nonatomic, assign) BOOL vipNewUser;
@property (nonatomic, assign) BBGPassportType myType;

@end

@implementation BBGQQPassport
//@synthesize loginID = _loginID;
//@synthesize accountID = _accountID;
//@synthesize usertoken = _usertoken;
//@synthesize usersecret = _usersecret;
//@synthesize newUser = _newUser;
//@synthesize type = _type;
//
- (id)init {
    self = [super init];
    if (self) {
        _myType = BBGPassportQQ;
    }
    return self;
}

- (void)doLogin{

}

//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (self) {
//        self.loginUsername = [aDecoder decodeObjectForKey:@"loginID"];
//        _loginID = _loginUsername;
//        self.vipUsertoken = [aDecoder decodeObjectForKey:@"usertoken"];
//        _usertoken = _vipUsertoken;
//        self.vipUsersecret = [aDecoder decodeObjectForKey:@"usersecret"];
//        _usersecret = _vipUsersecret;
//        self.vipAccountID = [aDecoder decodeObjectForKey:@"accountID"];
//        _accountID = _vipAccountID;
//        self.myType = [aDecoder decodeIntegerForKey:@"type"];
//        _type = _myType;
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.loginUsername forKey:@"loginID"];
//    [aCoder encodeObject:self.vipUsertoken forKey:@"usertoken"];
//    [aCoder encodeObject:self.vipUsersecret forKey:@"usersecret"];
//    [aCoder encodeObject:self.vipAccountID forKey:@"accountID"];
//    [aCoder encodeInt:self.myType forKey:@"type"];
//}
//
//- (void)doLogin {
//    if ([TencentOAuth iphoneQQInstalled]) {
//        if (!_tencentOAuth) {
//            self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAPPID andDelegate:self];
//            self.permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_share", nil];
//            NSDictionary *msg = [self getQQMessage];
//            if (msg) {
//                _tencentOAuth.accessToken = [msg objectForKey:@"AccessToken"];
//                _tencentOAuth.openId = [msg objectForKey:@"OpenId"];
//                _tencentOAuth.expirationDate = [msg objectForKey:@"ExpirationDate"];
//            }
//        }
//        if ([_tencentOAuth isSessionValid]) {
//            //直接登录
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"使用QQ帐户登录" message:@"您已经通过了QQ帐户授权，是否使用已授权QQ帐户登录？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
//            alertView.tag = QQLOGINALERTTAG;
//            [alertView show];
//        }else{
//            //授权
//            [_tencentOAuth authorize:_permissions inSafari:NO];
//        }
//    }else{
//        if (self.delegate && [self.delegate respondsToSelector:@selector(passportLoginFailed:error:)]) {
//            [self.delegate passportLoginFailed:self error:[NSError errorWithDomain:@"" code:405 userInfo:nil]];
//        }
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您没有安装QQ客户端，是否下载安装？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"安装", nil];
//        alertView.tag = QQINSTALLALERTTAG;
//        [alertView show];
//    }
//}
//
//- (void)doRegister {
//    
//}
//
//- (void)doLogout {
//    _loginID = nil;
//    _usertoken = nil;
//    _usersecret = nil;
//    _accountID = nil;
//    self.loginUsername = nil;
//    self.vipUsertoken = nil;
//    self.vipUsersecret = nil;
//    self.vipAccountID = nil;
//}
//
//- (void)loginWithQQ {
//    [_qqLoginRequest cancelRequest];
//    _qqLoginRequest = [[BBGQQLoginRequest alloc] init];
//    _qqLoginRequest.delegate = self;
//    _qqLoginRequest.openId = _tencentOAuth.openId;
//    _qqLoginRequest.accessToken = _tencentOAuth.accessToken;
//    [_qqLoginRequest send];
//}
//
//- (void)saveQQMessage {
//    NSMutableDictionary *msg = [NSMutableDictionary dictionary];
//    if (_tencentOAuth.accessToken) {
//        [msg setObject:_tencentOAuth.accessToken forKey:@"AccessToken"];
//    }
//    if (_tencentOAuth.openId) {
//        [msg setObject:_tencentOAuth.openId forKey:@"OpenId"];
//    }
//    if (_tencentOAuth.expirationDate) {
//        [msg setObject:_tencentOAuth.expirationDate forKey:@"ExpirationDate"];
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"QQMESSAGE"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (NSDictionary *)getQQMessage {
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"QQMESSAGE"];
//}
//
//#pragma mark - BBGRequestDelegate Methods
//- (void)requestCompleted:(BBGRequest *)request response:(BBGResponse *)response {
//    if (request == _qqLoginRequest) {
//        BBGQQLoginResponse *loginResponse = (BBGQQLoginResponse *)response;
//        if (loginResponse.isError) {
//            if (self.delegate && [self.delegate respondsToSelector:@selector(passportLoginFailed:error:)]) {
//                [self.delegate passportLoginFailed:self error:[NSError errorWithDomain:response.errorMsg code:405 userInfo:nil]];
//            }
//        }else{
//            if (loginResponse.loginResult.usertoken && loginResponse.loginResult.usersecret) {
//                _loginID = _loginUsername;
//                self.vipUsertoken = loginResponse.loginResult.usertoken;
//                _usertoken = _vipUsertoken;
//                self.vipUsersecret = loginResponse.loginResult.usersecret;
//                _usersecret = _vipUsersecret;
//                self.vipAccountID = loginResponse.loginResult.accountID;
//                _accountID = _vipAccountID;
//                self.vipNewUser = loginResponse.loginResult.isNewUser;
//                _newUser = _vipNewUser;
//                if (self.delegate && [self.delegate respondsToSelector:@selector(passportLoginSuccessful:)]) {
//                    [self.delegate passportLoginSuccessful:self];
//                }
//            }else{
//                if (self.delegate && [self.delegate respondsToSelector:@selector(passportLoginFailed:error:)]) {
//                    
//                    NSString *errorMsg;
//                    if (loginResponse.loginResult.errorMsg) {
//                        errorMsg = loginResponse.loginResult.errorMsg;
//                    }else{
//                        errorMsg = @"QQ登录失败，请重试！";
//                    }
//                    [self.delegate passportLoginFailed:self error:[NSError errorWithDomain:errorMsg code:405 userInfo:nil]];
//                }
//            }
//            
//        }
//    }
//}
//
//- (void)requestError:(BBGRequest *)request error:(NSError *)error {
//    if (request == _qqLoginRequest) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(passportLoginFailed:error:)]) {
//            [self.delegate passportLoginFailed:self error:[NSError errorWithDomain:@"网络请求失败，请再次尝试！" code:408 userInfo:nil]];
//        }
//    }
//}
//
//#pragma mark - TencentSessionDelegate Method
//- (void)tencentDidLogin {
//    if ([_tencentOAuth.accessToken length] > 0) {
//        // 记录登录用户的OpenID、Token以及过期时间
//        _loginUsername = _tencentOAuth.openId;
//        [self saveQQMessage];
//        [self loginWithQQ];
//    }else{
//        if (self.delegate && [self.delegate respondsToSelector:@selector(passportLoginFailed:error:)]) {
//            [self.delegate passportLoginFailed:self error:[NSError errorWithDomain:@"QQ授权登录失败" code:405 userInfo:nil]];
//        }
//    }
//}
//
//-(void)tencentDidNotLogin:(BOOL)cancelled {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(passportLoginFailed:error:)]) {
//        [self.delegate passportLoginFailed:self error:[NSError errorWithDomain:cancelled ? @"用户取消登录" : @"QQ授权登录失败" code:405 userInfo:nil]];
//    }
//}
//
//-(void)tencentDidNotNetWork
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(passportLoginFailed:error:)]) {
//        [self.delegate passportLoginFailed:self error:[NSError errorWithDomain:@"网络请求失败，请再次尝试！" code:408 userInfo:nil]];
//    }
//}
//
//#pragma mark - UIAlertViewDelegate Methods
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (alertView.tag == QQLOGINALERTTAG) {
//        if (buttonIndex == 0) {
//            [_tencentOAuth authorize:_permissions inSafari:NO];
//        }else{
//            [self loginWithQQ];
//        }
//    }else{
//        if (buttonIndex == 1) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/qq/id444934666?mt=8"]];
//        }
//    }
//}

@end
