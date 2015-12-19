//
//  AppDelegate.m
//  YHInternational
//
//  Created by Damon on 15/4/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import "BBGContentViewController_iPhone.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "UMSocial.h"
#import "BBGShareManager.h"
#import "BBGSessionManager.h"
#import "BBGSessionViewController_iPhone.h"
#import "IQKeyboardManager.h"
#import "BBGRegionManager.h"
#import "BBGLaunchManager.h"
#import "BBGBugFixManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "BBGPayCenter.h"
#import "BBGCountdownManager.h"
#import "MobClick.h"
#import "BBGUpdateManager.h"
#import "BBGWSPXUpdateManager.h"
#import "BBGActivityManager.h"
#import "BBGSessionManager.h"
#import "BBGRedPaperView.h"
#import "BBGShareModel.h"
#import "BBGCartManager.h"
#import "UMOpus.h"
#import "BBGLaunchModel.h"
#import "BaiduMap.h"
#import "APService.h"
#import "BBGSpecialWebViewController_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGRedpaperManager.h"
#import "TalkingDataAppCpa.h"
#import "BBGSearchViewController_iPhone.h"
#import "BBGLogisticsViewController_iPhone.h"
#import "BBGPhoneSeckillViewController_iPhone.h"
#import "Common.h"
#import "JPEngine.h"
#import <BBGSecurityUtil.h>
@interface AppDelegate ()
{
    BMKMapManager * _mapManager;
}

@property (nonatomic, strong) BBGContentViewController_iPhone * viewController;
@property (nonatomic, strong) BBGRedPaperView *redView ;
@property (nonatomic, strong) BBGShareModel *first ;
//@property (nonatomic, strong) UIImageView * defaultView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //TalkingData数据，上线前需要修改渠道！！！！
    //    [TalkingDataAppCpa init:APP_ID withChannelId:CHANNEL_ID];
    //    [Fabric with:@[CrashlyticsKit]];
    //    Crashlytics startWithAPIKey:<#(NSString * __nonnull)#>
    
    [TalkingDataAppCpa init:@"df68eba722684dee934727e45fb2c177" withChannelId:CHANNEL_ID];
    
    //测试用，别删
//    NSString *rc4Key = @"b$bg%1%7bbg@#^&";
//    [JPEngine startEngine];
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
//    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//    script = [BBGSecurityUtil rc4EncryptWithText:script theKey:rc4Key];
//    script = [BBGSecurityUtil rc4DecryptWithText:script theKey:rc4Key];
//    [JPEngine evaluateScript:script];
    /**
     *  百度地图
     */
    if (!TARGET_IPHONE_SIMULATOR) {
        _mapManager = [[BMKMapManager alloc] init];
        BOOL ret = [_mapManager start:@"ciW904IMKnsRjNiNj6Gzoq8F"  generalDelegate:nil];
        if (!ret) {
            NSLog(@"manager start failed!");
        }
    }
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    //去除导航栏自带的黑线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    //友盟统计
    [MobClick startWithAppkey:UMENG_APPKEY];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    //向微信注册(微信支付)
    [WXApi registerApp:WECHATKEY];
    //注册友盟APP版本更新
    [BBGUpdateManager sharedInstance];
    //注册沃易玩APP版本更新
    //[[BBGWSPXUpdateManager sharedInstance] checkWSPXAppUpdate];
    //获取友盟在线参数 这个方法需要在BBGUpdateManager创建后执行
    [MobClick updateOnlineConfig];
    //注册友盟社会化分享组件
    [BBGShareManager sharedInstance];
    [UMOpus setAudioEnable:NO];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    _viewController = [[BBGContentViewController_iPhone alloc] init];
    
    
    [BBGLaunchManager sharedInstance].mainView = self.viewController.view;
    
    [self launchApplication];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [self jPushRegisterWithOptions:launchOptions];
    
    //NSLog(@"UDID:%@",[OpenUDID value]);
    /**
     *  @author holyjoy, 15-10-22 17:10:37
     *
     *  区别是否是从3d touch 标签进入的app，如果是则处理结束逻辑后，返回NO，防止处理逻辑被反复回调。
     */
    //    [[BBGLoadingTips sharedInstance] showTips:@"正常启动"];
    //    if (IOS_VERSION >= 9.0) {
    //        if ([launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey]) {
    //            return NO;
    //        }
    //    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    [self handleURL:url application:application];
    
    return YES;
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    [self handleURL:url application:application];
    
    return YES;
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application   {
    if([BBGSessionManager sharedInstance].isLogin){
        [[BBGCartManager sharedInstance] updateCartData];
    }
    
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)handleURL:(NSURL *)url application:(UIApplication *)application {
    if ([url.scheme isEqualToString:@"YHinternationalForAlixpay"]) {
        //处理支付宝回调
        [[BBGPayCenter sharedInstance] handleAlixpayURL:url];
    }else if ([url.scheme isEqualToString:@"wx9d6e74da636d4fac"] && [url.host isEqualToString:@"pay"]){
        //微信支付回调
        [[BBGPayCenter sharedInstance] handleWeChatURL:url];
    }else{
        //微信以及朋友圈分享以及微博
        [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [MobClick updateOnlineConfig];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"IndexReloadData" object:nil];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*!
 *  @author Damon, 15-04-23 14:04:48
 *
 *  启动App
 */
- (void)launchApplication{
    
    [[BBGSessionManager sharedInstance] setHandler:[BBGSessionViewController_iPhone sharedInstance]];
    [[BBGLaunchManager sharedInstance] addTask:[BBGRegionManager sharedInstance]];
    [[BBGLaunchManager sharedInstance] addTask:[BBGCountdownManager sharedInstance]];
    [[BBGLaunchManager sharedInstance] addTask:[BBGRedpaperManager sharedInstance]];
    [[BBGLaunchManager sharedInstance] addTask:[BBGBugFixManager sharedInstance]];
    
    NSDate * date = [NSDate date];
    NSString * str = [NSString dateWithTimeInterval:date.timeIntervalSince1970 formatter:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"时间是:%@",str);
    
    [[BBGLaunchManager sharedInstance] launch];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = _viewController;
    
    if ([BBGCache queryCache:KEYLAUNCHINFO]) {
        UIImageView * launchImageView = [[UIImageView alloc]init];
        launchImageView.userInteractionEnabled = YES;
        [launchImageView setFrame:[UIScreen mainScreen].bounds];
        BBGLaunchModel * model = [BBGCache queryCache:KEYLAUNCHINFO];
        [launchImageView setImage:model.image];
        [BBGLaunchManager sharedInstance].date = [NSDate date];
        [BBGLaunchManager sharedInstance].launchImageView = launchImageView;
        [[UIApplication sharedApplication].keyWindow addSubview:launchImageView];
        
        
    }
}

#pragma mark 极光推送
- (void)jPushRegisterWithOptions:(NSDictionary *)launchOptions{
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    [APService setupWithOption:launchOptions];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
    [self receivePush:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [self receivePush:userInfo];
}

/**
 *  收到推送处理
 *
 *  @param userInfo
 */
- (void)receivePush:(NSDictionary *)userInfo{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    NSDictionary *dict = [self userInfoTransformKey:userInfo];
    
    NSString *type = [dict DICT_OBJ_FOR_K(@"type")];
    NSString *data = [dict DICT_OBJ_FOR_K(@"data")];
    NSString *title = [dict DICT_OBJ_FOR_K(@"title")];
    NSString *content = [[dict DICT_OBJ_FOR_K(@"aps")] DICT_OBJ_FOR_K(@"alert")];
    
    
    [BBGAlertView showWithTitle:@"推送通知" message:content handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            if ([@"0" isEqualToString:type]) {
                // 普通商品通知
                UIViewController *tempCon = [BBGSessionManager sharedInstance].currentViewController;
                
                BBGGoodsDetailViewController_iPhone *con = [[BBGGoodsDetailViewController_iPhone alloc] init];
                con.productId = data;
                BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:con];
                
                
                [tempCon presentViewController:nav animated:YES completion:^{
                    
                }];
                
            }else if ([@"1" isEqualToString:type]){
                //WEB页面通知
                UIViewController *tempCon = [BBGSessionManager sharedInstance].currentViewController;
                
                BBGSpecialWebViewController_iPhone *con = [[BBGSpecialWebViewController_iPhone alloc] initWithURL:[NSURL URLWithString:data]];
                con.title = title;
                BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:con];
                
                
                [tempCon presentViewController:nav animated:YES completion:^{
                    
                }];
            }
        }
    } buttonTitles:@"查看详情", nil];
    
}

/**
 *  转换Key成小写
 *
 *  @param userInfo <#userInfo description#>
 *
 *  @return <#return value description#>
 */
- (NSDictionary*)userInfoTransformKey:(NSDictionary*)userInfo{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSArray *keyArray = [userInfo allKeys];
    for (int i=0; i<[keyArray COUNT]; i++) {
        NSString *keyStr = [keyArray ARRAY_OBJ_AT(i)];
        id obj = [userInfo DICT_OBJ_FOR_K(keyStr)];
        keyStr = [[keyStr lowercaseString] stringByReplacingOccurrencesOfString:@"" withString:@""];
        [dict DICT_SET_VK(obj, [keyStr lowercaseString])];
    }
    
    return dict;
}

/**
 *  @author holyjoy, 15-10-22 16:10:38
 *
 *  3dTOUCH 回调
 *
 *  @param application       <#application description#>
 *  @param shortcutItem      <#shortcutItem description#>
 *  @param completionHandler <#completionHandler description#>
 */
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    if ([shortcutItem.type isEqualToString:@"PhoneSecondsKill"]) {
        
        // 手机秒杀
        UIViewController *tempCon = [BBGSessionManager sharedInstance].currentViewController;
        
        BBGPhoneSeckillViewController_iPhone *con = [[BBGPhoneSeckillViewController_iPhone alloc] init];
        BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:con];
        nav.is3DTouch = YES;
        nav.isFirstView = YES;
        con.isFrom3DTouch = YES;
        if ([UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController) {
            if (![tempCon isKindOfClass:[BBGPhoneSeckillViewController_iPhone class]]) {
                [tempCon presentViewController:nav animated:YES completion:^{
                    [BBGSessionManager sharedInstance].currentViewController = con;
                }];
            }
        }else{
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        }
        
    }else if ([shortcutItem.type isEqualToString:@"LogisticSquery"]){
        
        // 物流查询
        UIViewController *tempCon = [BBGSessionManager sharedInstance].currentViewController;
        
        [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
            
            BBGLogisticsViewController_iPhone *con = [[BBGLogisticsViewController_iPhone alloc] init];
            
            BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:con];
            con.isFrom3DTouch = YES;
            if ([UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController) {
                if (![tempCon isKindOfClass:[BBGLogisticsViewController_iPhone class]]) {
                    [tempCon presentViewController:nav animated:YES completion:^{
                        [BBGSessionManager sharedInstance].currentViewController = con;
                        
                    }];
                }
            }else{
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            }
            
        }];
        
        
    }else if ([shortcutItem.type isEqualToString:@"Search"]){
        
        // 商品搜索
        UIViewController *tempCon = [BBGSessionManager sharedInstance].currentViewController;
        
        BBGSearchViewController_iPhone *con = [[BBGSearchViewController_iPhone alloc] init];
        
        con.isFormFindCenterCtrl = YES;
        con.isForm3DTouch = YES;
        BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:con];
        
        if ([UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController) {
            if (![tempCon isKindOfClass:[BBGSearchViewController_iPhone class]]) {
                [tempCon presentViewController:nav animated:YES completion:^{
                    [BBGSessionManager sharedInstance].currentViewController = con;
                }];
            }
        }else{
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        }
        
    }
    
    
}

@end
