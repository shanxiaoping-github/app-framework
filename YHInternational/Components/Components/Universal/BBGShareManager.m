//
//  BBGShareManager.m
//  Components
//
//  Created by BubuGao on 15-4-21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShareManager.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "BBGProduct.h"
#import "BBGURLManager.h"
@interface BBGShareManager()<UMSocialUIDelegate>
@property (nonatomic,copy)shareResultCallback callback;
@property (nonatomic,copy)clickPlatformCallback platformcallback;
@property (nonatomic,strong)NSArray *shareToSnsNames;
@property (nonatomic,strong)NSString *shareUrl;
@end

@implementation BBGShareManager

DECLARE_SINGLETON(BBGShareManager)

- (id)init {
    self = [super init];
    if (self) {
        
//        [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
        
        [UMSocialData setAppKey:UMENG_APPKEY];
//            [UMSocialData openLog:YES];
//        设置QQ的应用Id，和分享url
//        [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKey url:@"www.baidu.com"];
        [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKey url:@"http://g.yunhou.com"];
//        设置微信AppId，设置分享url
//        [UMSocialWechatHandler setWXAppId:WECHATKEY appSecret:WECHATSECRET url:@"www.baidu.com"];
        [UMSocialWechatHandler setWXAppId:WECHATKEY appSecret:WECHATSECRET url:@"http://g.yunhou.com"];
        
        //设置支持没有客户端情况下使用SSO授权
        [UMSocialQQHandler setSupportWebView:YES];
        //打开新浪微博的SSO开关
        [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
        
        
        
        self.shareToSnsNames = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina];
        
    }
    return self;
}

//回调分享成功or失败
- (void)shareToSnsSheetView:(UIViewController *)controller
                  shareText:(NSString *)shareText
                 shareImage:(UIImage *)shareImage
            shareToSnsNames:(NSArray *)shareToSnsNames
                   shareUrl:(NSString *)shareUrl
                   callBack:(shareResultCallback)callBack
{
    self.callback = callBack;
    [self shareToSnsSheetView:controller shareText:shareText shareImage:shareImage shareToSnsNames:shareToSnsNames shareUrl:shareUrl];
}


//回调点击的分享平台
- (void)shareToSnsSheetView:(UIViewController *)controller
                  shareText:(NSString *)shareText
                 shareImage:(UIImage *)shareImage
            shareToSnsNames:(NSArray *)shareToSnsNames
                   shareUrl:(NSString *)shareUrl
      clickPlatformCallBack:(clickPlatformCallback)callBack
{
    self.platformcallback = callBack;
    [self shareToSnsSheetView:controller shareText:shareText shareImage:shareImage shareToSnsNames:shareToSnsNames shareUrl:shareUrl];
}




- (void)shareToSnsSheetView:(UIViewController *)controller
                  shareText:(NSString *)shareText
                 shareImage:(UIImage *)shareImage
            shareToSnsNames:(NSArray *)shareToSnsNames
                   shareUrl:(NSString *)shareUrl
{
    self.shareUrl = shareUrl;
    if (self.isBenifit) {
        self.shareToSnsNames = @[UMShareToWechatSession,UMShareToWechatTimeline];
    }else{
        self.shareToSnsNames = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina];
    }
    
    if (!shareToSnsNames) {
        shareToSnsNames = self.shareToSnsNames;
    }
    if (self.shareUrl) {
        shareText = [NSString stringWithFormat:@"%@%@",shareText,self.shareUrl];
        [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKey url:self.shareUrl];
        [UMSocialWechatHandler setWXAppId:WECHATKEY appSecret:WECHATSECRET url:self.shareUrl];
    }else{
        //分享URL为空时 默认到云猴网主页
        [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKey url:@"http://g.yunhou.com"];
        [UMSocialWechatHandler setWXAppId:WECHATKEY appSecret:WECHATSECRET url:@"http://g.yunhou.com"];
    }
    //调用快速分享接口

    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:UMENG_APPKEY
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:shareToSnsNames
                                       delegate:self];
}



//下面得到分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    NSString *snsName = [[response.data allKeys] objectAtIndex:0];
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",snsName);
        
        if (self.callback) {
            self.callback(YES,snsName);
        }
        
    }else{
        
        if (self.callback) {
            self.callback(NO,snsName);
        }
    }
}


-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    
    if (platformName == UMShareToSina) {
        
    }else if (platformName == UMShareToQQ) {
        [UMSocialData defaultData].extConfig.qqData.url = self.shareUrl;
    }else if (platformName == UMShareToQzone){
        [UMSocialData defaultData].extConfig.qzoneData.url = self.shareUrl;
    }else if (platformName == UMShareToWechatSession){
        [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrl;
    }else if (platformName == UMShareToWechatTimeline){
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.shareUrl;
    }
    if (self.platformcallback) {
        self.platformcallback(platformName);
    }
}

-(BOOL)isDirectShareInIconActionSheet{
    
    return NO;
}

- (void)dealloc{
    self.callback = nil;
    self.platformcallback = nil;
    self.shareToSnsNames = nil;
    self.shareUrl = nil;
    
}

@end

