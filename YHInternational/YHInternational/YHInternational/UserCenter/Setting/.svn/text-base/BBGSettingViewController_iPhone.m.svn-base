//
//  BBGSettingViewController_iPhone.m
//  BuBuGao
//
//  Created by elvis.peng on 14-9-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSettingViewController_iPhone.h"
#import "BBGTableView.h"
#import "MobClick.h"
#import <Common/Common.h>
#import "BBGConstants.h"
#import "MobClick.h"
#import "BBAboutViewController_iPhone.h"
#import "UMFeedback.h"
#import "OpenUDID.h"
#import "BBGLaunchManager.h"
#import "BBGAlertView.h"
#import "BBGSpecialWebViewController_iPhone.h"
#import "BBGUMFeedbackViewController.h"

@interface BBGSettingViewController_iPhone ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isClear;
@property (nonatomic, strong) NSString *updateUrl;
@property (nonatomic, strong) NSMutableArray *settingData;
@property (nonatomic, assign) BOOL isFeedBack;
@end

@implementation BBGSettingViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //        self.title = @"设置";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
        label.text = @"设置" ;
        label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
        label.textColor = [UIColor blackColor] ;
        label.textAlignment = NSTextAlignmentCenter ;
        self.navigationItem.titleView = label ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.settingData = [NSMutableArray array];
    
    //电信免流量URL
    NSString *telecomFlowURL = [BBGLaunchManager sharedInstance].telecomFlowURL;
    if (![BBGTools checkStringIsBlank:telecomFlowURL]) {
        [self.settingData addObject:@"telecomFlow"];
    }
    
    BOOL showCheckUpdate = [BBGLaunchManager sharedInstance].openUpdateSwitch;
    if (showCheckUpdate) {
        [self.settingData addObject:@"checkUpdate"];
    }
    [self.settingData addObject:@"clearData"];
    [self.settingData addObject:@"feedback"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setSeparatorColor:RGB_CELL_GRAY];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.view.backgroundColor = UIColorFromRGB(239, 239, 239);
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    [UMFeedback setAppkey:UMENG_APPKEY];
    
    if ([[BBGSession sharedInstance] isLogin]) {
        [self createBottomView];
    }
}

- (void)createBottomView{
    UIImage *logoutImg = [[UIImage imageNamed:@"RedBtn_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton setBackgroundImage:logoutImg forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
    [logoutButton setFrame:CGRectMake(10, 30, GETWIDTH(self.view)-20, 40)];
    logoutButton.titleLabel.font  = APP_FONT(17);
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GETWIDTH(self.view), 80)];
    view.backgroundColor = UIColorFromRGB(239, 239, 239);
    [view addSubview:logoutButton];
    self.tableView.tableFooterView = view;
}

-(void)logoutAction:(id)sender{
    
    __weak BBGSettingViewController_iPhone * weakSelf = self;
    [BBGAlertView showWithTitle:nil message:@"确定要退出？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex==0) {
            if ([[BBGSession sharedInstance] isLogin]) {
                [[BBGSessionManager sharedInstance] doLogout:^(BOOL successful) {
                    [BBGJumpManager sharedInstance].tabBarController.selectedIndex = 0;
                    [BBGCartManager sharedInstance].cartCount = @(0);
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }];
            }
            
        }
    } buttonTitles:@"确定", nil];
    
}

#pragma mark - BBGTableViewDataSource And BBGTableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(BBGTableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(BBGTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? [self.settingData count] : 1;
}

- (CGFloat)tableView:(BBGTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(BBGTableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//设置分割线左边距
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (BBGTableViewCell *)tableView:(BBGTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    BBGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BBGTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        CGRect frame = cell.frame;
        frame.size.width = GETWIDTH(self.view);
        cell.frame = frame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usercenterArrow"]];
        cell.textLabel.textColor = UIColorFromRGB(102, 102, 102);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    if (indexPath.section==0) {
        NSString *str = [self.settingData objectAtIndex:indexPath.row];
        if ([@"telecomFlow" isEqualToString:str]) {
            cell.imageView.image = [UIImage imageNamed:@"setting_gift"];
            
            cell.textLabel.font = APP_FONT(14);
            cell.textLabel.textColor = UIColorFromHexadecimalRGB(0x333333);
            cell.textLabel.text = @"免费领流量";
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
        }else if ([@"checkUpdate" isEqualToString:str]) {
            cell.imageView.image = [UIImage imageNamed:@"setting_check_version_icon"];
            
            cell.textLabel.font = APP_FONT(14);
            cell.textLabel.textColor = UIColorFromHexadecimalRGB(0x333333);
            cell.textLabel.text = @"检查更新";
            cell.accessoryView = nil;
        }else if ([@"clearData" isEqualToString:str]) {
            cell.imageView.image = [UIImage imageNamed:@"setting_clear_cache_icon"];
            
            cell.textLabel.font = APP_FONT(14);
            cell.textLabel.textColor = UIColorFromHexadecimalRGB(0x333333);
            cell.textLabel.text = @"清除缓存";
            
            SDImageCache * cache = [SDImageCache sharedImageCache];
            double trueSize = 0.0;
            if (self.isClear) {
                trueSize = 0.0;
            }else{
                unsigned long long size = cache.getSize;
                //NSLog(@"-----------%lld",size);
                trueSize = size / 1024.0 / 1024.0;
            }
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 20)];
            lbl.textAlignment = NSTextAlignmentRight;
            lbl.textColor = UIColorFromHexadecimalRGB(0xf03468);
            lbl.font = APP_FONT(14);
            lbl.text = [NSString stringWithFormat:@"当前缓存%.01fMB",trueSize];
            cell.accessoryView = lbl;
        }else if ([@"feedback" isEqualToString:str]) {
            cell.imageView.image = [UIImage imageNamed:@"setting_comment_icon"];
            cell.textLabel.font = APP_FONT(14);
            cell.textLabel.textColor = UIColorFromHexadecimalRGB(0x333333);
            cell.textLabel.text = @"意见反馈";
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
        }
        
    }else{
        //        usercenterArrow
        cell.imageView.image = [UIImage imageNamed:@"setting_about_icon"];
        cell.textLabel.font = APP_FONT(14);
        cell.textLabel.textColor = UIColorFromHexadecimalRGB(0x333333);
        cell.textLabel.text = @"关于";
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
    }
    return cell;
}

- (void)tableView:(BBGTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section ==0) {
        NSString *str = [self.settingData objectAtIndex:indexPath.row];
        if ([@"telecomFlow" isEqualToString:str]) {
            NSString *telecomFlowURL = [BBGLaunchManager sharedInstance].telecomFlowURL;
            BBGSpecialWebViewController_iPhone *con = [[BBGSpecialWebViewController_iPhone alloc] initWithURL:[NSURL URLWithString:telecomFlowURL]];
            con.title = @"免费领流量";
            [self.navigationController pushViewController:con animated:YES];
        }else if ([@"checkUpdate" isEqualToString:str]) {
            //NSLog(@"检查更新");
            [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
            //友盟检测更新
            [MobClick checkUpdateWithDelegate:self selector:@selector(checkUpdateAPP:)];
            
            //沃易玩检测更新
            //            WS(ws)
            //            [self requestUpgradeData:^(BOOL sucessful, NSDictionary *responseDict) {
            //                [[BBGLoadingTips sharedInstance] hideTips];
            //                if (sucessful) {
            //                    [ws WSPXcheckUpdateAPP:responseDict];
            //                }else{
            //                    [[BBGLoadingTips sharedInstance] showTips:@"请求出错"];
            //                }
            //            }];
            
        }else if ([@"clearData" isEqualToString:str]) {
            self.isClear = YES;
            SDImageCache * cache = [SDImageCache sharedImageCache];
            [cache cleanDisk];
            [cache clearDisk];
            [cache clearMemory];
            [self.tableView reloadData];
            unsigned long long size = cache.getSize;
            NSLog(@"%lld",size);
            self.isClear = NO;
            
            //清除搜索历史缓存
            [BBGCache removeCacheForType:BBGCacheTypeSearchHistory];
            [[BBGLoadingTips sharedInstance] showTips:@"缓存清除成功"];
        }if ([@"feedback" isEqualToString:str]) {
            [self showNativeFeedback];
        }
        
    }else{
        BBAboutViewController_iPhone * aboutViewController = [[BBAboutViewController_iPhone alloc]initWithNibName:@"BBAboutViewController_iPhone" bundle:nil];
        [self.navigationController pushViewController:aboutViewController animated:YES];
        
    }
}


- (void)showNativeFeedback{
    BBGUMFeedbackViewController *con = [[BBGUMFeedbackViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
}


#pragma mark--
#pragma mark UITableViewDataSource methods.
#pragma mark
#pragma mark MobClick methods.

-(void) checkUpdateAPP:(NSDictionary *)appUpdateInfo;{
    [[BBGLoadingTips sharedInstance] hideTips];
    NSString *update = [appUpdateInfo objectForKey:@"update" ];
    if([@"NO" compare:update] == NSOrderedSame){
        [BBGAlertView showWithTitle:@"" message:@"当前版本已是最新版本."  handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            
        } buttonTitles:@"确定", nil];
    }
    if([@"YES" compare:update] == NSOrderedSame){
        NSString *title=[NSString stringWithFormat:@"有可用的新版本%@",[appUpdateInfo objectForKey:@"version" ]];
        self.updateUrl=[appUpdateInfo objectForKey:@"path" ];
        [[[UIAlertView alloc] initWithTitle:title message:[appUpdateInfo objectForKey:@"update_log" ] delegate:self cancelButtonTitle:@"忽略此版本"otherButtonTitles:@"在线升级", nil] show];
    }
    
}

/**
 *  沃易玩检测更新
 *
 *  @param appUpdateInfo <#appUpdateInfo description#>
 */
- (void)WSPXcheckUpdateAPP:(NSDictionary *)appUpdateInfo{
    NSString *returnCode = [appUpdateInfo DICT_OBJ_FOR_K(@"returnCode")];
    if ([returnCode intValue] == 1) {
        NSDictionary *dict = [appUpdateInfo DICT_OBJ_FOR_K(@"content")];
        NSString *isUpdate = [dict DICT_OBJ_FOR_K(@"isUpdate")];
        if ([isUpdate intValue] == 0) {
            [[BBGLoadingTips sharedInstance] showTips:@"当前是最新版本"];
        }else{
            NSString *downloadUrl = [dict DICT_OBJ_FOR_K(@"downloadUrl")];
            NSString *strInstallUrl = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",downloadUrl];
            [BBGAlertView showWithTitle:@"" message:@"检测到有新版本，是否更新？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString : strInstallUrl]];
                }
            } buttonTitles:@"是", nil];
        }
    }else{
        NSString *returnMsg = [appUpdateInfo DICT_OBJ_FOR_K(@"returnMsg")];
        [[BBGLoadingTips sharedInstance] showTips:returnMsg];
    }
}

#pragma mark--
#pragma mark UIAlertViewDelegate methods.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateUrl]];
    }
}



-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
