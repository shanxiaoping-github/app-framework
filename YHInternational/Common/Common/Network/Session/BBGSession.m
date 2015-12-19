//
//  BBGSession.m
//  Common
//
//  Created by calvin on 14-4-3.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSession.h"
#import "BBGMacro.h"
#import "BBGPassport.h"
#import "BBGLoginRequest.h"
#import "UMSocial.h"
#import "BBGUserInfoRequest.h"
#import "AFNetworking.h"
#import "BBGFirstShareRequest.h"
#import "BBGFirstShareResponse.h"
#import "BBGShareModel.h"
#import "BBGRedPaperView.h"

@interface BBGSession ()

@property (nonatomic,strong) BBGLoginRequest * loginRequest;

@property (nonatomic,strong) BBGUserInfoRequest * userRequest;

@property (nonatomic, strong) BBGUserInfoRequest * request;

@property (nonatomic, strong) BBGFirstShareRequest * shareRequest;

@end

@implementation BBGSession

DECLARE_SINGLETON(BBGSession)

- (BOOL)isLogin{
    return self.userInfo.userSecret && self.userInfo.accessToken;
}

- (void)getUserDetailInfo:(LoginBlock)finished{
    if ([BBGSession sharedInstance].isLogin) {
        if (_request) {
            self.request = nil;
        }
        
        _request = [[BBGUserInfoRequest alloc]init];
        [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
            if (!responseData.isError) {
                BBGUserInfoResponse *userDetailResponse = (BBGUserInfoResponse*)responseData;
                [BBGSession sharedInstance].userDetailInfo = userDetailResponse.userDetailInfo;
                if (finished) {
                    finished(YES);
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
            [[BBGLoadingTips sharedInstance] showTips:@"获取个人信息失败"];
            [BBGSession sharedInstance].userDetailInfo = nil;
        }];
    }
    
}

- (void)dologin:(BBGLoginType)type finish:(LoginBlock)block controller:(UIViewController *)controller{
    if (_loginRequest) {
        self.loginRequest = nil;
    }
    _loginRequest = [[BBGLoginRequest alloc]initWithType:type];
    if (type == BBGLoginTypeMobile) {
        _loginRequest.loginName = self.loginName;
        _loginRequest.password = self.password;
        _loginRequest.captcha = self.captcha;
        _loginRequest.sessionId = self.sessionId;
        [self.loginRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
            BBGLoginResponse * response = (BBGLoginResponse *)responseData;
            [BBGSession sharedInstance].response = responseData;
            if (!response.isError) {
                [BBGSession sharedInstance].userInfo = response.userInfo;
                [[BBGSession sharedInstance] getUserDetailInfo:^(BOOL successful) {
                    if (successful) {
                        [[BBGCartManager sharedInstance] updateCartData];
                        //清除搜索历史缓存
                        [BBGCache removeCacheForType:BBGCacheTypeSearchHistory];
                        if (block) {
                            block(YES);
                        }
                        [self firstShareData:^(BOOL successful, id response) {
                            if (successful) {
                                BBGShareModel *model = [[BBGShareModel alloc]init];
                                model = response;
                                if (model.shareUrl!=nil) {
                                    [BBGRedPaperView showWithModel:model statue:NO];
                                }
                            }
                        }];
                    }
                }];
            }else{
                if (block) {
                    block(NO);
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
            if (block) {
                block(NO);
            }
            /*!
             *  @author Damon, 15-04-22 19:04:30
             *
             *  登录失败
             */
        }];
    }else{
        /*!
         *  @author Damon, 15-04-22 22:04:03
         *
         *  第三方登录
         */
        NSString * umStr ;
        switch (type) {
            case BBGLoginTypeQQ:
                umStr = UMShareToQQ;
                break;
            case BBGLoginTypeSina:
                umStr = UMShareToSina;
                break;
            case BBGLoginTypeWebChat:
                umStr = UMShareToWechatSession;
                break;
            default:
                
                break;
        }
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:umStr];
        snsPlatform.loginClickHandler(controller,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            // 获取用户名、uid、token
            if (response.responseCode == UMSResponseCodeSuccess) {
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:umStr];
                
                _loginRequest.openId = snsAccount.usid;
                
                _loginRequest.unionId = snsAccount.unionId;
                
                _loginRequest.thirdAccessToken = snsAccount.accessToken;
                
                [_loginRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
                    BBGLoginResponse * response = (BBGLoginResponse *)responseData;
                    if(!response.isError){
                        [BBGSession sharedInstance].userInfo = response.userInfo;
                        //清除搜索历史缓存
                        [BBGCache removeCacheForType:BBGCacheTypeSearchHistory];
                        [[BBGSession sharedInstance] getUserDetailInfo:^(BOOL successful) {
                            if (successful) {
                                [[BBGCartManager sharedInstance] updateCartData];
                                if (block) {
                                    block(YES);
                                }
                                [self firstShareData:^(BOOL successful, id response) {
                                    if (successful) {
                                        BBGShareModel *model = [[BBGShareModel alloc]init];
                                        model = response;
                                        if (model.shareUrl!=nil) {
                                            [BBGRedPaperView showWithModel:model statue:NO];
                                        }
                                    }
                                }];
                            }
                        }];
                        
                    }else{
                        if (block) {
                            block(NO);
                        }
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
                    if (block) {
                        block(NO);
                    }
                    /*!
                     *  @author Damon, 15-04-22 19:04:30
                     *
                     *  登录失败
                     */
                    
                }];
#ifdef DEBUG
                NSLog(@"username is %@, uid is %@, token is %@ iconUrl is %@,unionId is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL,snsAccount.unionId);
#endif
                self.loginRequest.openId = snsAccount.usid;
                self.loginRequest.thirdAccessToken = snsAccount.accessToken;
            }else{
                //错误请重试
            }
        });
        
    }
    
    
}

- (void)doFastLogin:(BBGLoginType)type finish:(fastLoginBlock)block controller:(UIViewController *)controller{
    
    if (_loginRequest) {
        self.loginRequest = nil;
    }
    _loginRequest = [[BBGLoginRequest alloc]initWithType:type];
    
   if (type == BBGLoginTypeFastMobile){
        
        _loginRequest.mobile = self.mobile;
        _loginRequest.verifyCode = self.verifyCode;
        _loginRequest.captchaCode = self.captchaCode;
        _loginRequest.sessionId = self.sessionId;
        [self.loginRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
            BBGLoginResponse * response = (BBGLoginResponse *)responseData;
            [BBGSession sharedInstance].response = responseData;
            if (!response.isError) {
                [BBGSession sharedInstance].userInfo = response.userInfo;
                [[BBGSession sharedInstance] getUserDetailInfo:^(BOOL successful) {
                    if (successful) {
                        [[BBGCartManager sharedInstance] updateCartData];
                        //清除搜索历史缓存
                        [BBGCache removeCacheForType:BBGCacheTypeSearchHistory];
                        if (block) {
                            block(YES,response);
                        }
                        [self firstShareData:^(BOOL successful, id response) {
                            if (successful) {
                                BBGShareModel *model = [[BBGShareModel alloc]init];
                                model = response;
                                if (model.shareUrl!=nil) {
                                    [BBGRedPaperView showWithModel:model statue:NO];
                                }
                            }
                        }];
                    }
                }];
            }else{
                if (block) {
                    block(NO,response);
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
            if (block) {
                block(NO,nil);
            }
            /*!
             *  @author Damon, 15-04-22 19:04:30
             *
             *  登录失败
             */
        }];
        
    }
}

- (void)firstShareData:(void (^)(BOOL successful,id response))callback {
    _shareRequest = [[BBGFirstShareRequest alloc] init];
    [_shareRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGFirstShareResponse *response = (BBGFirstShareResponse *)responseData;
        callback(YES,response.shareInfo) ;
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}

- (void)setUserInfo:(BBGUserInfo *)userInfo{
    if ([BBGCache queryCache:@"UserInfo"]) {
        [BBGCache removeCacheForKey:@"UserInfo"];
        }
    [BBGCache addCache:@"UserInfo" obj:userInfo];
}

- (BBGUserInfo *)userInfo{
    return [BBGCache queryCache:@"UserInfo"];
}

- (void)setUserDetailInfo:(BBGUserDetailInfo *)userDetailInfo{
    if ([BBGCache queryCache:@"UserDetailInfo"]) {
        [BBGCache removeCacheForKey:@"UserDetailInfo"];
    }
    [BBGCache addCache:@"UserDetailInfo" obj:userDetailInfo];
}

- (BBGUserDetailInfo *)userDetailInfo{
    return [BBGCache queryCache:@"UserDetailInfo"];
}

- (void)logout{
    [BBGCache removeCacheForKey:@"UserDetailInfo"];
    [BBGCache removeCacheForKey:@"UserInfo"];
}

- (void)dealloc{
    self.request = nil;
    self.userRequest = nil;
    self.userInfo = nil;
    self.userDetailInfo = nil;
    self.loginName = nil;
    self.password = nil;
    self.captcha = nil;
    self.loginRequest = nil;
    self.shareRequest = nil;
}
@end
