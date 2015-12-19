//
//  BBGRegisterViewController_iPhone.m
//  YHInternational
//
//  Created by Damon on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegisterViewController_iPhone.h"
#import "UIImage+Stretch.h"
#import "IQKeyboardManager.h"
#import "BBGWebViewController.h"
#import "BBGNavigationController.h"
@interface BBGRegisterViewController_iPhone ()<UITextFieldDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UIImageView *phoneBg;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *vertificationTextfield;
@property (strong, nonatomic) IBOutlet UITextField *imageVertificationTextfield;
@property (strong, nonatomic) IBOutlet UIButton *showPwdBtn;
@property (strong, nonatomic) IBOutlet UIButton *getVertificationBtn;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
@property (strong, nonatomic) IBOutlet UIImageView *horizontaolLine;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmConstraint;
@property (strong, nonatomic) IBOutlet UIButton *refreshBtn;
@property (strong, nonatomic) IBOutlet UIImageView *vertificationImageView;
@property (strong, nonatomic) IBOutlet UIButton *userDelegateBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pwdConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pwdTextFieldTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showBtnTopConstarint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getVertifyBtnConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneBgConstaint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getVertifyTextConstraint;
@property (nonatomic, assign) NSInteger countDown;
@end

@implementation BBGRegisterViewController_iPhone

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil];
//    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
//    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = nil;
    
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    self.navigationController.delegate = self;
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"NavBar_white"] stretchImage] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar_Clear"] forBarMetrics:UIBarMetricsDefault];
}

- (IBAction)showUserDelegate:(id)sender {
    /*!
     *  用户协议
     *
     */
    BBGWebViewController * webViewController = [[BBGWebViewController alloc]initWithURL:[NSURL URLWithString:@"http://app.bubugao.com/mall/protocol.html"]];
    
    BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:webViewController];
    webViewController.title = @"用户协议";
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.confirmBtn.enabled = NO;
    
    self.countDown = 60;
    
    self.phoneTextField.delegate = self;
    self.phoneTextField.tintColor = [UIColor colorWithRed:240.0/255.0 green:72.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    self.passwordTextField.tintColor = [UIColor colorWithRed:240.0/255.0 green:72.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    self.vertificationTextfield.tintColor = [UIColor colorWithRed:240.0/255.0 green:72.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    self.imageVertificationTextfield.tintColor = [UIColor colorWithRed:240.0/255.0 green:72.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    self.vertificationTextfield.returnKeyType = UIReturnKeyDone;
    self.imageVertificationTextfield.returnKeyType = UIReturnKeyDone;
    
    self.phoneTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.vertificationTextfield.delegate = self;
    self.imageVertificationTextfield.delegate = self;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"注册" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    self.passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;

    [self.confirmBtn setBackgroundImage:[[UIImage imageNamed:@"RedBtn_normal"] stretchImage] forState:UIControlStateNormal];
    
    [self.confirmBtn setBackgroundImage:[[UIImage imageNamed:@"RedBtn_highlight"] stretchImage] forState:UIControlStateHighlighted];
    
    [self.confirmBtn setBackgroundImage:[[UIImage imageNamed:@"RedBtn_unable"] stretchImage] forState:UIControlStateDisabled];
    
    [self hiddenImageVertification:YES];
    
    NSMutableAttributedString * btnTitle = [[NSMutableAttributedString alloc]initWithString:@"  注册账号就视为已阅读并同意用户协议"];
    
     NSRange range = NSMakeRange(15, 4);
    
    [btnTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    [btnTitle addAttribute:NSForegroundColorAttributeName value:UIColorFromHexadecimalRGB(0xf34568) range:range];
    
    [self.userDelegateBtn setAttributedTitle:btnTitle forState:UIControlStateNormal];
    [self.userDelegateBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [self.userDelegateBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateHighlighted];
    
    
}

- (void)dismissViewController{
    
    [super dismissViewController];
}

- (void)hiddenImageVertification:(BOOL)isImageVertification{
    __weak BBGRegisterViewController_iPhone * weakSelf = self;
    
    [UIView animateWithDuration:0.3f animations:^{
        if (isImageVertification) {
            weakSelf.getVertifyBtnConstraint.constant = 6;
            weakSelf.getVertifyTextConstraint.constant = 6;
            weakSelf.phoneBgConstaint.constant = 6;
            weakSelf.pwdConstraint.constant = 44;
            weakSelf.showBtnTopConstarint.constant = 12;
            weakSelf.refreshBtn.hidden = YES;
            weakSelf.vertificationImageView.alpha = 0.0;
            weakSelf.vertificationImageView.hidden = YES;
            weakSelf.imageVertificationTextfield.alpha = 0.0;
            weakSelf.horizontaolLine.alpha = 0.0;
            weakSelf.imageVertificationTextfield.hidden = YES;
            weakSelf.confirmConstraint.constant = 10.0;
        }else{
            weakSelf.getVertifyBtnConstraint.constant = 50;
            weakSelf.getVertifyTextConstraint.constant = 50;
            weakSelf.phoneBgConstaint.constant = 50;
            weakSelf.pwdConstraint.constant = 88;
            weakSelf.showBtnTopConstarint.constant = 56;
            weakSelf.refreshBtn.hidden = NO;
            weakSelf.vertificationImageView.alpha = 1.0;
            weakSelf.vertificationImageView.hidden = NO;
            weakSelf.imageVertificationTextfield.alpha = 1.0;
            weakSelf.horizontaolLine.alpha = 1.0;
            weakSelf.imageVertificationTextfield.hidden = NO;
            weakSelf.confirmConstraint.constant = 55.0;
        }
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    if (![touch.view isKindOfClass:[UITextField class]]) {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
    }
}

- (IBAction)showPwdAction:(id)sender {
    UIButton * button = (UIButton *)sender;
    button.selected = !button.isSelected;
    self.passwordTextField.enabled = NO;
    self.passwordTextField.secureTextEntry = button.isSelected;
    self.passwordTextField.enabled = YES;
    [self.passwordTextField becomeFirstResponder];
}

- (IBAction)doRegister:(id)sender {

    [[BBGLoadingTips sharedInstance] showLoading:nil];

    [self.passwordTextField resignFirstResponder];
    [self.imageVertificationTextfield resignFirstResponder];
    [self.vertificationTextfield resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    
    self.password = self.passwordTextField.text;
    self.imageCaptcha = self.imageVertificationTextfield.text;
    self.captcha = self.vertificationTextfield.text;
    self.mobile = self.phoneTextField.text;
    if (self.phoneTextField.text.length == 11 && self.passwordTextField.text.length >= 6 && self.captcha && self.sessionId.length > 0) {
        __weak BBGRegisterViewController_iPhone * weakSelf = self;
        [self registerUser:^(BOOL successful, id response) {
            BBGRegisterResponse * responseData = response;

            if (!successful) {
                
                [[BBGLoadingTips sharedInstance] showTips:responseData.message];
                if (responseData.captchaImageUrl) {
                    [weakSelf.vertificationImageView sd_setImageWithURL:[NSURL URLWithString:responseData.captchaImageUrl]];
                    [weakSelf hiddenImageVertification:NO];
                }else{
                }
                
            }else{
                [[BBGLoadingTips sharedInstance] showTips:@"注册成功"];
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    if (weakSelf.callback) {
                        weakSelf.callback(YES);
                    }
                }];
            }
            if (responseData.sessionId)
                weakSelf.sessionId = responseData.sessionId;
        }];
    }else{
        if (self.sessionId.length <= 0)
            [[BBGLoadingTips sharedInstance] showTips:@"短信验证码失效，请重新获取"];
        else if(self.passwordTextField.text.length < 6){
            self.confirmBtn.enabled = NO;
        }else if(self.captcha.length < 6){
            self.confirmBtn.enabled = NO;
        }else if(self.phoneTextField.text.length < 11){
            self.confirmBtn.enabled = NO;
        }else
            [[BBGLoadingTips sharedInstance] showTips:@"尚有参数未填写完全"];
    }
    
}

- (IBAction)refreshVertificationAction:(id)sender {
    __weak BBGRegisterViewController_iPhone * weakSelf = self;
    [self getImageVertification:^(BOOL successful, id response) {
        [weakSelf.vertificationImageView sd_setImageWithURL:[NSURL URLWithString:weakSelf.imageUrl] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageRefreshCached];
        
    }];
}

- (IBAction)getVertificationAction:(id)sender {
    [self.imageVertificationTextfield resignFirstResponder];
    if (self.phoneTextField.text.length == 11) {
//        if (self.imageUrl) {
//            if (self.imageCaptcha.length == 0) {
//                [[BBGLoadingTips sharedInstance] showTips:@"请输入图形验证码之后获取短信验证码"];
//            }
//        }

        UIButton * button = sender;
        button.enabled = NO;
        NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setVertificationCountDown:) userInfo:button repeats:YES];
        [timer fire];
        self.mobile = self.phoneTextField.text;
        
        __weak BBGRegisterViewController_iPhone * weakSelf = self;
        [self getVertification:^(BOOL successful, id response) {
            if (!successful) {
                weakSelf.countDown = 0;
                weakSelf.imageUrl = nil;
                [weakSelf refreshVertificationAction:nil];
            }else{
                BBGRegisterSmsResponse * responseData = response;
                if (responseData.imageUrl) {
                    weakSelf.imageUrl = responseData.imageUrl;
                    weakSelf.countDown = 0;
                    [[BBGLoadingTips sharedInstance] showTips:@"请先输入图形验证码,再次获取短信验证码"];
                    [weakSelf.vertificationImageView sd_setImageWithURL:[NSURL URLWithString:responseData.imageUrl]];
                    [weakSelf hiddenImageVertification:NO];
                }
            }
        }];
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

#pragma mark UITextfieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.mobile = self.phoneTextField.text;
    self.password = self.passwordTextField.text;
    self.captcha = self.vertificationTextfield.text;
    self.imageCaptcha = self.imageVertificationTextfield.text;
    if (self.imageVertificationTextfield.text.length != 0) {
        self.imageCaptcha = self.imageVertificationTextfield.text;
    }
    
    if (self.imageVertificationTextfield.text.length == 0 && self.imageVertificationTextfield.hidden == NO && textField == self.imageVertificationTextfield) {
        [[BBGLoadingTips sharedInstance] showTips:@"请先输入图形验证码之后获取短信验证码"];
    }else if (self.phoneTextField.text.length != 11 && textField == self.phoneTextField) {
        [[BBGLoadingTips sharedInstance] showTips:@"请输入正确的手机号"];
        
        self.confirmBtn.enabled = NO;
        return;
    } else if (self.vertificationTextfield.text.length == 0 && textField == self.vertificationTextfield) {
        [[BBGLoadingTips sharedInstance] showTips:@"请输入验证码"];
        return;
    }else if (self.passwordTextField.text.length < 6 && textField == self.passwordTextField) {
        [[BBGLoadingTips sharedInstance] showTips:@"密码长度需在6~20位之间"];
        
        self.confirmBtn.enabled = NO;
        return;
    }
    
    if (self.phoneTextField.text.length == 11 && self.passwordTextField.text.length >= 6 && self.vertificationTextfield.text.length > 0 ) {
        if (self.imageVertificationTextfield.hidden == NO) {
            if (self.imageVertificationTextfield.text.length > 0) {
                self.confirmBtn.enabled = YES;
            }
        }else{
            self.confirmBtn.enabled = YES;
        }
    }
    
    
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
