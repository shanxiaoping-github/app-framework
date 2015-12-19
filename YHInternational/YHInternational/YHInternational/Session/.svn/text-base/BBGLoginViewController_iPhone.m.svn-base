//
//  BBGLoginViewController_iPhone.m
//  YHInternational
//
//  Created by Damon on 15/9/22.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGLoginViewController_iPhone.h"
#import "BBGTextCell.h"
#import "BlocksKit+UIKit.h"
#import "BBGRegisterViewController_iPhone.h"
#import "OtherAttributView.h"
#import "ThirdPartyView.h"
#import "LoginBtnView.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "DVSwitch.h"
#import "BBGFastMobileLoginViewController_iPhone.h"
#import "UIImage+Stretch.h"
#import "IQKeyboardManager.h"
#import "BBGNavigationController.h"
#import "BBGSessionViewController_iPhone.h"
#import "BBGSpecialWebViewController_iPhone.h"
#define HEADER_HEIGHT 17

@interface BBGLoginViewController_iPhone ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIImageView * loginBgView;
@property (nonatomic, strong) OtherAttributView * otherAttributeView;
@property (nonatomic, strong) ThirdPartyView * thirdPartyView;
@property (nonatomic, strong) LoginBtnView * loginBtnView;
@property (nonatomic, assign) BOOL showVertificationCell;
//顶部 滑动开关
@property (strong, nonatomic) DVSwitch *loginSwitch;
@end

@implementation BBGLoginViewController_iPhone

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createLeftBarButtonItemWithTarget:self action:@selector(closeAction) normalImage:[UIImage imageNamed:@"Cancel_white"] highlightedImage:[UIImage imageNamed:@"Cancel_white"]];
}

- (void)closeAction{
    [BBGSessionManager sharedInstance].isLoginViewController = NO;
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    WS(weakSelf)
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    //滑动开关
    _loginSwitch = [DVSwitch switchWithStringsArray:@[@"手机号登录", @"账号登录"]];
    _loginSwitch.frame = CGRectMake(0, 0, 200, 34);
    [_loginSwitch forceSelectedIndex:1 animated:YES];
    
    _loginSwitch.cornerRadius = _loginSwitch.frame.size.height/2;
    _loginSwitch.backgroundColor = [UIColor colorWithRed:138/255.0 green:45/255.0 blue:99/255.0 alpha:1.0];
    _loginSwitch.sliderColor = [UIColor colorWithRed:190/255.0 green:50/255.0 blue:103/255.0 alpha:1.0];
    _loginSwitch.font = APP_FONT_DEMI_LIGHT(14.0);
    _loginSwitch.labelTextColorInsideSlider = [UIColor whiteColor];
    _loginSwitch.labelTextColorOutsideSlider = UICOLOR_FONT_WEAK_GRAYLIGHT;

    [_loginSwitch setPressedHandler:^(NSUInteger index) {
        //滑动或点击事件
        if (index == 0) {
            [weakSelf fastLogin:nil];
            [weakSelf.loginSwitch forceSelectedIndex:1 animated:YES];
            
        }
        
    }];
    self.navigationItem.titleView = _loginSwitch;
    _loginBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login_bg"]];
    [self.navigationController.view addSubview:self.loginBgView];
    [self.navigationController.view sendSubviewToBack:self.loginBgView];
    [self.loginBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(IPHONE_WIDTH, IPHONE_HEIGHT - 64));
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self createRightBarButtonItemWithTarget:self action:@selector(click:) title:@"注册"];
    
    _thirdPartyView = [[[NSBundle mainBundle] loadNibNamed:@"ThirdPartyView" owner:self options:nil] lastObject];
    [self.view addSubview:_thirdPartyView];
    [self.thirdPartyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-22);
        make.height.mas_equalTo(70);
    }];
    
    [_thirdPartyView.leftBtn bk_whenTapped:^{
        
        [weakSelf webCahtLoginFinish:^(BOOL successful) {
            if (successful) {
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    if (weakSelf.callback) {
                        weakSelf.callback(YES);
                    }
                }];
            }
        }];
        
        
    }];
    
    [_thirdPartyView.centerBtn bk_whenTapped:^{
        [weakSelf sinaLoginFinish:^(BOOL successful) {
            if (successful) {
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    if (weakSelf.callback) {
                        weakSelf.callback(YES);
                    }
                }];
            }
        }];
    }];
    
    [_thirdPartyView.rightBtn bk_whenTapped:^{
        [weakSelf qqLoginFinish:^(BOOL successful) {
            if (successful) {
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    if (weakSelf.callback) {
                        weakSelf.callback(YES);
                    }
                }];
            }
        }];
        
        
    }];
    
    _otherAttributeView = [[[NSBundle mainBundle] loadNibNamed:@"OtherAttributeView" owner:self options:nil] lastObject];
    [_otherAttributeView.lineView setImage:[UIImage imageNamed:@"or"]];
    _otherAttributeView.orLabel.textColor = UIColorFromRGB(186, 168, 168);
    [self.view addSubview:_otherAttributeView];
    [self.otherAttributeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(IPHONE_WIDTH, 15));
        make.bottom.mas_equalTo(weakSelf.thirdPartyView.mas_top).offset(-7);
    }];
    

    _loginBtnView = [[LoginBtnView alloc] initWithFrame:CGRectMake(25, 0, IPHONE_WIDTH - 50, 70)];
    _loginBgView.backgroundColor = [UIColor blackColor];
    [_loginBtnView.button setBackgroundImage:[[UIImage imageNamed:@"RedBtn_normal"] stretchImage] forState:UIControlStateNormal];
    [_loginBtnView.button setBackgroundImage:[[UIImage imageNamed:@"RedBtn_highlight"] stretchImage] forState:UIControlStateHighlighted];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:@"登录" attributes:@{NSFontAttributeName:APP_FONT(14.0),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.loginBtnView.button setAttributedTitle:str forState:UIControlStateNormal];
    [self.loginBtnView.button setAttributedTitle:str forState:UIControlStateHighlighted];

    [self.loginBtnView.button bk_whenTapped:^{
        [[BBGLoadingTips sharedInstance] showLoading:@"登录中"];
        [weakSelf getLoginInfo];
        [weakSelf login];
    }];
    [self.loginBtnView.forgetBtn bk_whenTapped:^{
        BBGSpecialWebViewController_iPhone * forgetWebViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:@"http://api-app.yunhou.com/applogin/app-next.php"]];
        forgetWebViewController.title = @"忘记密码";
        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:forgetWebViewController];
        [weakSelf presentViewController:nav animated:YES completion:^{
            
        }];
    }];
    
    
    self.tableView.tableFooterView = self.loginBtnView;
    
    NSInteger thirdPartyNum = 3;
    
    if (![QQApiInterface isQQInstalled]) {
        thirdPartyNum -= 1;
        weakSelf.thirdPartyView.rightItem.hidden = YES;
    }
    
    if (![WXApi isWXAppInstalled]) {
        thirdPartyNum -= 1;
        weakSelf.thirdPartyView.leftItem.hidden = YES;
    }
    
    if (thirdPartyNum == 1) {
        self.thirdPartyView.centerConstraint.constant = 0;

    }else if (thirdPartyNum == 2){
        if (self.thirdPartyView.leftItem.hidden) {
            self.thirdPartyView.centerConstraint.constant = -46;
            self.thirdPartyView.rightConstraint.constant = 46;
        }
        if (self.thirdPartyView.rightItem.hidden) {
            self.thirdPartyView.leftConstraint.constant = -46;
            self.thirdPartyView.centerConstraint.constant = 46;
        }
    }
    
}

- (void)fastLogin:(id)sender {
    WS(weakSelf)
    BBGFastMobileLoginViewController_iPhone *fastLoginCtrl = [[BBGFastMobileLoginViewController_iPhone alloc] initWithBlock:^(BOOL successful, id response) {
        if (weakSelf.callback) {
            weakSelf.callback(YES);
        }
    }];
    
    [self.navigationController pushViewController:fastLoginCtrl animated:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click:(UIButton *)sender{
    BBGRegisterViewController_iPhone * registerViewController = [[BBGRegisterViewController_iPhone alloc]initWithNibName:@"BBGRegisterViewController_iPhone" bundle:nil];
    registerViewController.callback = self.callback;
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)updateTableView:(BOOL)showVertification{
    self.showVertificationCell = showVertification;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView beginUpdates];
    if (showVertification) {
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView endUpdates];
}

- (void)dismissTheView{
    if (self.callback) {
        self.callback(NO);
    }
}

- (void)getLoginInfo{
    /**
     *  获取登录的信息
     *
     */
    BBGTextCell * cell1 = (BBGTextCell *)[self.view viewWithTag:10];
    BBGTextCell * cell2 = (BBGTextCell *)[self.view viewWithTag:11];
    [cell1.loginTextField resignFirstResponder];
    [cell2.loginTextField resignFirstResponder];
    
    self.loginStr = cell1.loginTextField.text;
    
    self.password = cell2.loginTextField.text;
    
    if (self.showVertificationCell) {
        BBGTextCell * cell3 = (BBGTextCell *)[self.view viewWithTag:12];
        [cell3.loginTextField resignFirstResponder];
        self.vertification = cell3.loginTextField.text;
        
    }
    
}

- (void)login{
    /**
     *  登录方法
     */
    if (self.loginStr.length > 0 && self.password.length > 0) {
        __weak BBGLoginViewController_iPhone * weakSelf = self;
        [self mobileLoginFinish:^(BOOL successful) {
            
            if (successful) {
                [[BBGLoadingTips sharedInstance] showTips:@"登录成功"];
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    if (weakSelf.callback) {
                        weakSelf.callback(YES);
                    }
                }];
            }else{
                BBGLoginResponse * response = (BBGLoginResponse *)[BBGSession sharedInstance].response;
                [[BBGLoadingTips sharedInstance] showTips:response.message];
                
                    if (response.requireCaptcha) {
                        if (!weakSelf.showVertificationCell) {
                            [weakSelf updateTableView:YES];
                        }

                        [weakSelf getCaptchaImage:^(BOOL successful) {
                            if(successful){
                                [weakSelf.view layoutIfNeeded];
                                BBGTextCell * cell = (BBGTextCell *)[self.view viewWithTag:12];
                                [cell updateVertificationView:weakSelf.imageUrl];
                                [BBGSession sharedInstance].sessionId = weakSelf.sessionId;
                                
                            }
                        }];
                }
                
            }
            
        }];
    }else if (self.loginStr.length == 0){
        [[BBGLoadingTips sharedInstance] showTips:@"请输入用户名"];
    }else{
        [[BBGLoadingTips sharedInstance] showTips:@"请输入密码"];
    }
        
    
    
}

- (void)textFieldDone:(UITextField *)field{
    [self getLoginInfo];
    if (self.password.length > 0 && self.loginStr.length > 0) {
        if (self.showVertificationCell) {
            if (self.vertification.length > 0) {
                [self login];
            }
        }else{
            [self login];
        }
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return self.showVertificationCell;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellidentifier = @"BBGTextCell";
    BBGTextCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellidentifier owner:self options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.loginTextField.delegate = self;
        [cell.loginTextField addDoneOnKeyboardWithTarget:self action:@selector(textFieldDone:)];
    }
    if(indexPath.section == 1){
        if (cell.passwordBtn.isSelected) {
            cell.loginTextField.secureTextEntry = YES;
        }else{
            cell.loginTextField.secureTextEntry = NO;

        }
    }
    
    cell.tag = 10 + indexPath.section;
    if (indexPath.section == 2) {
        WS(weakSelf)
        [cell.rVertificationBtn bk_addEventHandler:^(id sender) {
           [weakSelf getCaptchaImage:^(BOOL successful) {
               if(successful){
                   [weakSelf.view layoutIfNeeded];
                   [cell updateVertificationView:weakSelf.imageUrl];
                   [BBGSession sharedInstance].sessionId = weakSelf.sessionId;
                   
               }
           }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    [cell updateCellWithIndex:indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (self.showVertificationCell) {
            return 50;
        }else{
            return 1;
        }
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return HEADER_HEIGHT;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UITableViewHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerLoginView"];
        if (headerView == nil) {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerLoginView"];
            headerView.contentView.backgroundColor = [UIColor clearColor];
            if (!headerView.backgroundView) {
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), HEADER_HEIGHT)];
                imageView.backgroundColor = [UIColor clearColor];
                headerView.backgroundView = imageView;
            }
        }
        return headerView;
    }
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 2) {
//        return 50;
//    }
//    return 0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 2) {
//        if (!self.loginBtnView) {
//            WS(weakSelf)
//            _loginBtnView = [[[NSBundle mainBundle] loadNibNamed:@"LoginBtnView" owner:self options:nil] lastObject];
//            
//            [_loginBtnView.loginBtn setBackgroundImage:[[UIImage imageNamed:@"RedBtn_normal"] stretchImage] forState:UIControlStateNormal];
//            [_loginBtnView.loginBtn setBackgroundImage:[[UIImage imageNamed:@"RedBtn_highlight"] stretchImage] forState:UIControlStateHighlighted];
////            self.tableView.tableFooterView = _loginBtnView;
//        }
//        return self.loginBtnView;
//    }
//    return nil;
//}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self getLoginInfo];
    if (self.password.length > 0 && self.loginStr.length > 0) {
        if (self.showVertificationCell) {
            if (self.vertification.length > 0) {
                [self login];
            }
        }else{
            [self login];
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        BBGTextCell * cell2 = (BBGTextCell *)[self.view viewWithTag:11];
//
//        if (cell2.loginTextField == textField)
//        {
//            if ([toBeString length] > 20) {
//                textField.text = [toBeString substringToIndex:20];
//                return NO;
//            }
//        }
    return YES;
    
    
}

- (void)dealloc{
    [BBGSessionManager sharedInstance].isLoginViewController = NO;
}

@end
