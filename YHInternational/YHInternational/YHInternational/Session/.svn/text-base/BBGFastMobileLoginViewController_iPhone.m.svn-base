//
//  BBGFastMobileLoginViewController_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/6/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFastMobileLoginViewController_iPhone.h"
#import "FastMobileTableViewCell.h"
#import "FastMobileImageAuthCell.h"
#import "FastMobileLoginEnterAuthCodeCell.h"
#import "FastMobileLoginFootView.h"
#import "UIImage+Stretch.h"
#import "DVSwitch.h"
#import "Common.h"
@interface BBGFastMobileLoginViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) FastMobileLoginFootView *footView;
@property (nonatomic, assign) NSInteger countDown;

@property (nonatomic, copy) FastLoginBlock block;

//顶部 滑动开关
@property (strong, nonatomic) DVSwitch *loginSwitch;
@end

@implementation BBGFastMobileLoginViewController_iPhone

- (id)initWithBlock:(FastLoginBlock)block{
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar_Clear"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = YES;
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    if(![UINavigationBar appearance].shadowImage){
        [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    }
    [self createLeftBarButtonItemWithTarget:self action:@selector(closeAction) normalImage:[UIImage imageNamed:@"Cancel_white"] highlightedImage:[UIImage imageNamed:@"Cancel_white"]];
}

- (void)closeAction{
    
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImageView setImage:[UIImage imageNamed:@"Login_bg"]];
    [self.view addSubview:bgImageView];
    
    //换成开关，先不用了，留着
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
//    label.text = @"手机号登录" ;
//    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
//    label.textColor = [UIColor blackColor] ;
//    label.textAlignment = NSTextAlignmentCenter ;
//    self.navigationItem.titleView = label;
    
//    滑动开关
    _loginSwitch = [DVSwitch switchWithStringsArray:@[@"手机号登录", @"账号登录"]];
    _loginSwitch.frame = CGRectMake(0, 0, 200, 34);
    _loginSwitch.cornerRadius = _loginSwitch.frame.size.height/2;
    _loginSwitch.backgroundColor = [UIColor colorWithRed:138/255.0 green:45/255.0 blue:99/255.0 alpha:1.0];
    _loginSwitch.sliderColor = [UIColor colorWithRed:190/255.0 green:50/255.0 blue:103/255.0 alpha:1.0];
    _loginSwitch.font = APP_FONT_DEMI_LIGHT(14.0);
    _loginSwitch.labelTextColorInsideSlider = [UIColor whiteColor];
    _loginSwitch.labelTextColorOutsideSlider = UICOLOR_FONT_WEAK_GRAYLIGHT;
    WS(weakSelf)
    [_loginSwitch setPressedHandler:^(NSUInteger index) {
        //滑动或点击事件
        if (index == 1) {
            [weakSelf.navigationController popViewControllerAnimated:NO];
        }
        
    }];
    self.navigationItem.titleView = _loginSwitch;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 150)];
    _tableView.tableHeaderView = headerView;

    _footView = [[[NSBundle mainBundle] loadNibNamed:@"FastMobileLoginFootView" owner:self options:nil] firstObject];
    _footView.fastMobileLoginOkBtn.enabled = NO;
    _countDown = 60;

    _footView.getAuthBtnBlock = ^(){
        [weakSelf didOkBtnGetSms];
    };
    _footView.okBtnBlock = ^(){
        [weakSelf didOkBtnGoFastLogin];
    };
    
    _tableView.tableFooterView = _footView;

}

//手机号登录按钮事件
- (void)didOkBtnGetSms{
    WS(weakSelf)
    if (weakSelf.mobile.length == 11) {
        
        [[BBGLoadingTips sharedInstance] showLoadingOnView:weakSelf.tableView];
        [weakSelf getVertification:^(BOOL successful, id response) {
            
            weakSelf.footView.fastMobileLoginOkBtn.enabled = NO;
            [[BBGLoadingTips sharedInstance] hideTips];
            if (!successful) {
                
                weakSelf.countDown = 0;
                weakSelf.imageUrl = nil;
                
                //刷新图形验证码
                
                [weakSelf getImageVertification:^(BOOL successful, id response) {
                    //cell刷新
                    if (successful) {
                        //如果手机号码格式错误，刷新第一行，如果图形码错误，刷新第二行
                        if ([[weakSelf.tableView visibleCells] COUNT] == 1) {
                            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
                            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
                        }else{
                            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
                            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
                        }
                        
                    }
                    
                }];
                
            }else{
                
                BBGRegisterSmsResponse * responseData = response;
                weakSelf.sessionId = responseData.sessionId;
                if (responseData.imageUrl) {
                    weakSelf.imageUrl = responseData.imageUrl;
                    weakSelf.countDown = 0;
                    weakSelf.needImageCode = YES;
                    
                    if (!weakSelf.hadInsetImageCodecell) {
                        [weakSelf insertImageCodeCell:weakSelf.needImageCode];
                    }
                    
                }else{
                    
                    weakSelf.smsSucsessful = successful;
                    weakSelf.captchaCode = nil;
                    weakSelf.countDown = 60;
                    [weakSelf insertSmsCellAction:weakSelf.smsSucsessful];
                }
                
            }
        }];
    }else{
        [[BBGLoadingTips sharedInstance] showTips:@"请输入正确的手机号"];
    }
    

}

//点击手机号登录事件
- (void)didOkBtnGoFastLogin{
    WS(weakSelf)
    if (weakSelf.verifyCode.length == 6) {
        
        [[BBGLoadingTips sharedInstance] showLoadingOnView:weakSelf.tableView];
        [weakSelf fastMobileLoginFinish:^(BOOL successful, id response) {
            
            [[BBGLoadingTips sharedInstance] hideTips];
            if (successful) {
                [[BBGLoadingTips sharedInstance] showTips:@"登录成功"];
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    if (weakSelf.block) {
                        weakSelf.block(YES,response);
                    }
                    
                }];
            }else{
                
                BBGLoginResponse * response = (BBGLoginResponse *)[BBGSession sharedInstance].response;
                [[BBGLoadingTips sharedInstance] showTips:response.message];
            }
        }];
    }else{
        [[BBGLoadingTips sharedInstance] showTips:@"请输入正确的短信验证码"];
    }

}

/**
 *  @author holyjoy, 15-06-10 17:06:07
 *
 *  获取短信验证码
 */
- (void)insertSmsCellAction:(BOOL)successful {
    
    //修改OK按钮tag可以登录
    self.footView.fastMobileLoginOkBtn.tag = 20;
    [self.footView.fastMobileLoginOkBtn setTitle:@"验证并登录" forState:UIControlStateNormal];
    
    //插入短信验证码cell
    [self.tableView beginUpdates];
    NSMutableArray * indexArray = [NSMutableArray array];
    if (successful) {
        [indexArray addObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    }
    [self.tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

/**
 *  @author holyjoy, 15-06-11 09:06:25
 *
 *  刷新图形验证码
 *
 *  @param sender
 */
- (void)insertImageCodeCell:(BOOL)needImageCode {

    
    //插入图形验证码cell
    [self.tableView beginUpdates];
    NSMutableArray * indexArray = [NSMutableArray array];
    
    if (needImageCode) {
        [indexArray addObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    }
    
    [self.tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    _hadInsetImageCodecell = YES;
}

#pragma mark 刷新图形验证码
- (void)refreshVertificationAction:(UIImageView *)imageCodeView {
    __weak BBGFastMobileLoginViewController_iPhone * weakSelf = self;
    [self getImageVertification:^(BOOL successful, id response) {
        [imageCodeView sd_setImageWithURL:[NSURL URLWithString:weakSelf.imageUrl] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageRefreshCached];
        
    }];
}

#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_needImageCode) {
        if (_smsSucsessful) {
            return 3;
        }
        return 2;
    }
    if (_smsSucsessful) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.row == 0) {
        static NSString *cellIdentifier1 = @"FastMobileTableViewCell";
        FastMobileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FastMobileTableViewCell" owner:nil options:nil] firstObject];;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.mobileNumberTestField.text = self.mobile;
        cell.mobileNumberTestField.delegate = self;
        [cell.mobileNumberTestField becomeFirstResponder];
        cell.mobileNumberTestField.tintColor = [UIColor whiteColor];
        [cell.mobileNumberTestField addRightButtonOnKeyboardWithText:@"手机号登录" target:self action:@selector(didOkBtnGetSms)];
        [cell.mobileNumberTestField addTarget:self action:@selector(didReturn11:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }else if (indexPath.row == 1) {
        
        if (_smsSucsessful) {
            
            static NSString *cellIdentifier2 = @"FastMobileLoginEnterAuthCodeCell";
            FastMobileLoginEnterAuthCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            if (cell==nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FastMobileLoginEnterAuthCodeCell" owner:nil options:nil] firstObject];;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            cell.authCodeTextfield.text = self.verifyCode;
            cell.authCodeTextfield.delegate = self;
            cell.authCodeTextfield.tintColor = [UIColor whiteColor];
            [cell.authCodeTextfield becomeFirstResponder];
            [cell.authCodeTextfield addRightButtonOnKeyboardWithText:@"验证并登录" target:self action:@selector(didOkBtnGoFastLogin)];
            [cell.authCodeTextfield addTarget:self action:@selector(didReturn11:) forControlEvents:UIControlEventEditingChanged];

            cell.resendBtn.enabled = NO;
            NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setVertificationCountDown:) userInfo:cell.resendBtn repeats:YES];
            [timer fire];
            
            __weak BBGFastMobileLoginViewController_iPhone *weakSelf = self;
            __weak FastMobileLoginEnterAuthCodeCell *weakCell = cell;
            cell.resendBtnBlock = ^(){
                
                if (weakSelf.mobile.length == 11) {
                    
                    [[BBGLoadingTips sharedInstance] showLoadingOnView:weakSelf.tableView];
                    [weakSelf getVertification:^(BOOL successful, id response) {
                        
                        [[BBGLoadingTips sharedInstance] hideTips];
                        if (!successful) {
                            
                            weakSelf.countDown = 0;
                            weakSelf.imageUrl = nil;
                            
                        }else{
                            
                            BBGRegisterSmsResponse * responseData = response;
                            weakSelf.sessionId = responseData.sessionId;
                            if (responseData.imageUrl) {
                                
                                weakSelf.imageUrl = responseData.imageUrl;
                                weakSelf.countDown = 60;
                                weakSelf.needImageCode = YES;
                                
                                
                                if (!weakSelf.hadInsetImageCodecell) {

                                    [weakSelf insertImageCodeCell:weakSelf.needImageCode];
                                }else{
                                 
                                    //刷新下一行图像验证码
                                    NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
                                    FastMobileImageAuthCell *cell = (FastMobileImageAuthCell *)[_tableView cellForRowAtIndexPath:path];
                                    
                                    [cell.imageAuthImageView sd_setImageWithURL:[NSURL URLWithString:weakSelf.imageUrl] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageRefreshCached];
                                }
                                
                            }else{
                                
                                weakSelf.smsSucsessful = successful;
                                weakSelf.captchaCode = nil;
                                weakSelf.countDown = 60;
                                
                                weakCell.resendBtn.enabled = NO;
                                NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setVertificationCountDown:) userInfo:weakCell.resendBtn repeats:YES];
                                [timer fire];
                            }
                        }
                    }];
                }else{
                    [[BBGLoadingTips sharedInstance] showTips:@"请输入正确的手机号"];
                }
            };
            
            return cell;
        }else{
            static NSString *cellIdentifier3 = @"FastMobileImageAuthCell";
            FastMobileImageAuthCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
            if (cell==nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FastMobileImageAuthCell" owner:nil options:nil] firstObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            cell.imageAuthTextfield.delegate = self;
            cell.imageAuthTextfield.tintColor = [UIColor whiteColor];
            [cell.imageAuthTextfield becomeFirstResponder];
            [cell.imageAuthTextfield addTarget:self action:@selector(didReturn11:) forControlEvents:UIControlEventEditingChanged];
            [cell.imageAuthTextfield addRightButtonOnKeyboardWithText:@"手机号登录" target:self action:@selector(didOkBtnGetSms)];

            [cell.imageAuthImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageRefreshCached];
            
            __weak BBGFastMobileLoginViewController_iPhone * weakSelf = self;
            __weak FastMobileImageAuthCell *weakCell = cell;
            cell.refreshBtnBlock = ^(){
                
                [weakSelf refreshVertificationAction:weakCell.imageAuthImageView];
            };
            return cell;
            
        }
        
    }else{
        
        static NSString *cellIdentifier3 = @"FastMobileImageAuthCell";
        FastMobileImageAuthCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FastMobileImageAuthCell" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.imageAuthTextfield.delegate = self;
        cell.imageAuthTextfield.tintColor = [UIColor whiteColor];
        [cell.imageAuthTextfield becomeFirstResponder];
        
        [cell.imageAuthImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageRefreshCached];
        
        __weak BBGFastMobileLoginViewController_iPhone * weakSelf = self;
        __weak FastMobileImageAuthCell *weakCell = cell;
        cell.refreshBtnBlock = ^(){
            
            [weakSelf refreshVertificationAction:weakCell.imageAuthImageView];
        };
        return cell;
    }
    
}


- (void)setVertificationCountDown:(NSTimer *)timer{
    UIButton * button = timer.userInfo;
    
    if (self.countDown == 0) {
        [timer invalidate];
        self.countDown = 60;
        [button setTitle:[NSString stringWithFormat:@"(%ld)S",(long)self.countDown] forState:UIControlStateDisabled];
        button.enabled = YES;
    }
    [button setTitle:[NSString stringWithFormat:@"(%ld)S",(long)(self.countDown - 1)] forState:UIControlStateDisabled];
    self.countDown -= 1;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    _footView.fastMobileLoginOkBtn.enabled = NO;
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 11) {
        if (textField.text.length == 11) {
            
            self.mobile = textField.text;
            _footView.fastMobileLoginOkBtn.enabled = YES;
        }else{
            _footView.fastMobileLoginOkBtn.enabled = NO;
        }
    }else if(textField.tag == 22) {
        
        if (textField.text.length > 0) {
            _footView.fastMobileLoginOkBtn.enabled = YES;
            self.captchaCode = textField.text;
        }else{
            _footView.fastMobileLoginOkBtn.enabled = NO;
            [[BBGLoadingTips sharedInstance] showTips:@"请输入图形验证码"];

        }
    }else if(textField.tag == 33) {
        
        if (textField.text.length == 6) {
            _footView.fastMobileLoginOkBtn.enabled = YES;
            self.verifyCode = textField.text;
        }else{
            _footView.fastMobileLoginOkBtn.enabled = NO;
        }
    }
}

#pragma 输入11直接可以获取验证码
- (void)didReturn11:(UITextField *)textField{
    
    if (textField.tag == 11) {
        if (textField.text.length == 11) {
            
            self.mobile = textField.text;
            _footView.fastMobileLoginOkBtn.enabled = YES;
        }else{
            _footView.fastMobileLoginOkBtn.enabled = NO;
        }
    }else if(textField.tag == 22) {
        
        if (textField.text.length > 0) {
            _footView.fastMobileLoginOkBtn.enabled = YES;
            self.captchaCode = textField.text;
        }else{
            _footView.fastMobileLoginOkBtn.enabled = NO;
            [[BBGLoadingTips sharedInstance] showTips:@"请输入图形验证码"];
        }
    }else if(textField.tag == 33) {
        
        if (textField.text.length == 6) {
            _footView.fastMobileLoginOkBtn.enabled = YES;
            self.verifyCode = textField.text;
        }else{
            _footView.fastMobileLoginOkBtn.enabled = NO;
        }
    }

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
