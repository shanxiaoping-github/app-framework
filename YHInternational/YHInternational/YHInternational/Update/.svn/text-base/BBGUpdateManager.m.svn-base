//
//  BBGUpdateManager.m
//  Components
//
//  Created by elvis.peng on 15-1-15.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGUpdateManager.h"
#import "MobClick.h"

@interface BBGUpdateManager()
@property (nonatomic,strong) NSString *appstoreUrl;
@property (nonatomic,strong) UIAlertView *alertView;
@end

@implementation BBGUpdateManager

DECLARE_SINGLETON(BBGUpdateManager)

- (id)init {
    self = [super init];
    if (self) {
       
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(checkAppUpdate)
                                                     name:UMOnlineConfigDidFinishedNotification object:nil];
    }
    return self;
}

-(void)checkAppUpdate{
    [MobClick checkUpdateWithDelegate:self selector:@selector(appUpdate:)];
}

#pragma mark--
#pragma mark MobClickDelegate methods.
- (void)appUpdate:(NSDictionary *)appUpdateInfo{
    
    NSNumber *update = appUpdateInfo[@"update"];
    if (update&&!update.boolValue) {
        return;
    }
    NSString *miniVersion = [MobClick getConfigParams:@"ios_miniVersion"];
    NSString *currVersion = [self currVersionReviewKey];
    NSString *title = @"有可用的新版本";
    NSString *message = appUpdateInfo[@"update_log"];
    if([self isBlankString:message]){
        return;
    }
    self.appstoreUrl = appUpdateInfo[@"path"];
    if (!miniVersion) {
        miniVersion=@"0";
    }
    
    
    if (self.alertView) {
        [self.alertView dismissWithClickedButtonIndex:0 animated:NO];
    }
    
    if ([currVersion compare:miniVersion options:NSNumericSearch] == NSOrderedAscending ||
        [currVersion compare:miniVersion options:NSNumericSearch] ==NSOrderedSame)
    {
        //当前版本号小于或等于友盟上配置的最小版本号则强制更新
        //强制更新
        self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
        self.alertView.delegate = self;
        self.alertView.tag = 1;
        [self.alertView show];
        
    }else{
        //提示升级
        self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"忽略此版本" otherButtonTitles:@"立即更新", nil];
        self.alertView.delegate = self;
        self.alertView.tag = 2;
        [self.alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        
        if (buttonIndex==0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appstoreUrl]];
//            UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//            view.backgroundColor = [UIColor clearColor];
//            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 180, 240, 90)];
//            textView.editable = NO;
//            textView.layer.cornerRadius = 5;
//            textView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//            textView.font = [UIFont boldSystemFontOfSize:15];
//            textView.textColor = [UIColor whiteColor];
//            textView.text = @"您当前版本将无法正常使用.请升级到最新版本!";
//            [view addSubview:textView];
//            [[[[UIApplication sharedApplication] delegate] window] addSubview:view];
        }
        
    }else{
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appstoreUrl]];
        }
        
    }
    self.alertView = nil;
}

-(NSString *) currVersionReviewKey{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currVersion=[infoDic objectForKey:@"CFBundleVersion"];
    return currVersion;
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

-(void)dealloc{
    self.appstoreUrl = nil;
    self.alertView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UMOnlineConfigDidFinishedNotification object:nil];
}

@end
