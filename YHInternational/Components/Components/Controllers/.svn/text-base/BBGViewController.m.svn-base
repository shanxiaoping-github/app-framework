//
//  BBGViewController.m
//  Components
//
//  Created by Damon on 15/4/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGPushAnimator.h"
#import "BBGPopAnimator.h"
#import "BBGNavigationController.h"
#import "BBGLoginViewController.h"
#import "BBGRegisterViewController.h"
#import "MobClick.h"
#import "BBGSessionViewController.h"
#import "Common.h"
#import <SobotSDK.framework/Headers/SobotSDK.h>

@interface BBGViewController ()<UINavigationControllerDelegate,UIAlertViewDelegate>
{
    BOOL tabBarIsShow;

}
@property (nonatomic, strong) BBGPushAnimator * pushAnimator;
@property (nonatomic, strong) BBGPopAnimator  * popAnimator;
@property (nonatomic,strong) BBGRongRequest * rongRequest;

@end

@implementation BBGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.bounds = [UIApplication sharedApplication].keyWindow.bounds;
    self.view.frame = self.view.bounds;
    
    self.navigationController.delegate = self;
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    self.pushAnimator = [[BBGPushAnimator alloc] init];
    self.popAnimator = [[BBGPopAnimator alloc] init];
    
}

- (void)connectServer{
    WS(ws)
    _rongRequest = [[BBGRongRequest alloc] init];
    if (![BBGSession sharedInstance].isLogin) {
        _rongRequest.memberId = [BBGLaunchManager sharedInstance].rongCloudId;
        _rongRequest.userName = @"用户";
    }else{
        _rongRequest.memberId = [BBGSession sharedInstance].userInfo.memberId;
        _rongRequest.userName = [BBGSession sharedInstance].userDetailInfo.nickName;
    }

    ZCInitInfo * info = [ZCInitInfo new];
        
    info.enterpriseId = @"dc4ff8354775446d8fcfe7669014bbef";
    info.customBannerColor = UIColorFromHexadecimalRGB(0xf03468);
    info.phone        = @"4008888881";
    info.userId  = [BBGSession sharedInstance].userInfo.memberId;
    info.nickName = ws.rongRequest.userName;
//    [ZCSobot startZCChatView:info with:self];
    ZCSDKSobotChatController * chat = [[ZCSDKSobotChatController alloc]initWithInitInfo:info];
    [self.navigationController pushViewController:chat animated:YES];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (_isFrom3DTouch) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion{
    if (![viewControllerToPresent isKindOfClass:[BBGSessionViewController class]]) {
        [BBGSessionManager sharedInstance].currentViewController = viewControllerToPresent;
        [BBGSessionManager sharedInstance].isLoginViewController = NO;
    }else{
        if ([BBGSessionManager sharedInstance].isLoginViewController) {
            return;
        }
        [BBGSessionManager sharedInstance].isLoginViewController = YES;
    }
    
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    

    if (operation == UINavigationControllerOperationPush) {

        return self.pushAnimator;
    }
    
    if (operation == UINavigationControllerOperationPop) {
        return self.popAnimator;
    }
    
    return nil;
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [BBGSessionManager sharedInstance].currentViewController = self;
    if(!([self isKindOfClass:[BBGLoginViewController class]] || [self isKindOfClass:[BBGRegisterViewController class]])){
        self.navigationController.delegate  = self;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate  = self;
    if(!self.isMainViewController){
    if (!self.navigationItem.leftBarButtonItem) {
        UIButton * button;
        if (self.leftImage) {
                button = [self createLeftBarButtonItemWithTarget:self action:@selector(dismissViewController) normalImage:self.leftImage highlightedImage:nil];
        }
        if (!button) {
            [self createLeftBarButtonItemWithTarget:self action:@selector(dismissViewController) normalImage:[UIImage imageNamed:@"Cancel"] highlightedImage:nil];
        }
    }
    }
    
    [MobClick beginLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
    [[BBGLoadingTips sharedInstance] hideTips];
    
   // NSLog(@"%@",[NSString stringWithUTF8String:object_getClassName(self)]);
    [MobClick endLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
    
}

- (void)dismissViewController{
    
    //解决奇葩的当键盘弹出点关闭节目时，title不释放到bug
    [self.view endEditing:YES];
    
    if (self.navigationController.viewControllers.count == 1) {
                
        [self dismissViewControllerAnimated:YES completion:^{

        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- CreateButton

- (UIBarButtonItem *)createFlexSpacerBarButtonItemWithTarget:(id)target
                                                      action:(SEL)action
                                                       width:(CGFloat)width {
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:target
                                                                               action:action];
    flexSpacer.width = width;
    return flexSpacer;
}


- (UIBarButtonItem *)createBarButtonItemWithTarget:(id)target
                                            action:(SEL)action
                                             title:(NSString *)title
                                        titleColor:(UIColor *)titleColor
                                       normalImage:(UIImage *)nImage
                                  highlightedImage:(UIImage *)hImage {

    UIBarButtonItem *item = nil;
    if (!title) {
        
        UIButton *lButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lButton.exclusiveTouch = YES;
        CGSize defaultSize = CGSizeMake(40, 44);
        if (nImage.size.width > defaultSize.width) {
            defaultSize.width = nImage.size.width;
        }
        lButton.frame = CGRectMake(0, 0, defaultSize.width, defaultSize.height);
        [lButton setImage:nImage forState:UIControlStateNormal];
        [lButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [lButton setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        item = [[UIBarButtonItem alloc] initWithCustomView:lButton];

    }else {
        
        CGSize defaultSize = CGSizeMake(40, 44);
        UIFont *font = APP_FONT(15);
        CGSize titleSize = [title sizeWithStringFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
        titleSize.width = titleSize.width < defaultSize.width ? defaultSize.width : titleSize.width + 10;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
        button.titleLabel.font = font;
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setTitle:title forState:UIControlStateHighlighted];
        [button setTitle:title forState:UIControlStateNormal];
        item = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    return item;
}

- (UIButton *)createRightBarButtonItemWithTarget:(id)target action:(SEL)action normalImage:(UIImage *)nImage highlightedImage:(UIImage *)hImage {
    UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rButton.exclusiveTouch = YES;
    CGSize defaultSize = CGSizeMake(30, 44);
    if (nImage.size.width > defaultSize.width) {
        defaultSize.width = nImage.size.width;
    }
    if (hImage.size.width > defaultSize.width) {
        defaultSize.width = hImage.size.width;
    }
    rButton.frame = CGRectMake(0, 0, defaultSize.width, defaultSize.height);
    [rButton setImage:nImage forState:UIControlStateNormal];
    [rButton setImage:hImage forState:UIControlStateHighlighted];
    [rButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rButton];
    
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[flexSpacer,rightItem];
    
    return rButton;
}

- (UIButton *)createRightBarButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title {
    CGSize defaultSize = CGSizeMake(40, 44);
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize titleSize = [title sizeWithStringFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    titleSize.width = titleSize.width < defaultSize.width ? defaultSize.width : titleSize.width + 10;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setContentEdgeInsets:UIEdgeInsetsMake(4, 0, 0, 0)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    button.titleLabel.font = font;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[flexSpacer,rightItem];
    
    return button;
}

- (UIButton *)createRightBarButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor {
    
    CGSize defaultSize = CGSizeMake(40, 44);
    UIFont *font = APP_FONT(15);
    CGSize titleSize = [title sizeWithStringFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    titleSize.width = titleSize.width < defaultSize.width ? defaultSize.width : titleSize.width + 10;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    button.titleLabel.font = font;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[flexSpacer,rightItem];
    
    return button;

}

- (UIButton *)createLeftBarButtonItemWithTarget:(id)target action:(SEL)action normalImage:(UIImage *)nImage highlightedImage:(UIImage *)hImage {
    UIButton *lButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lButton.exclusiveTouch = YES;
    CGSize defaultSize = CGSizeMake(30, 30);
    if (nImage.size.width > defaultSize.width) {
        defaultSize.width = nImage.size.width;
    }
    if (hImage.size.width > defaultSize.width) {
        defaultSize.width = hImage.size.width;
    }
    lButton.frame = CGRectMake(0, 0, defaultSize.width, defaultSize.height);
    [lButton setImage:nImage forState:UIControlStateNormal];
    [lButton setImage:hImage forState:UIControlStateHighlighted];
    [lButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [lButton setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:lButton];
    self.navigationItem.leftBarButtonItem =  rightItem;
    
    return lButton;
}

- (UIButton *)createLeftBarButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title {
    CGSize defaultSize = CGSizeMake(40, 44);
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize titleSize = [title sizeWithStringFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    titleSize.width = titleSize.width < defaultSize.width ? defaultSize.width : titleSize.width + 10;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    button.titleLabel.font = font;
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem =  rightItem;
    
    return button;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateData:(LoadDataCallback)callback{
    @throw [NSException exceptionWithName:@"没有实现抽象方法" reason:@"请在子类里实现loadData:方法" userInfo:nil];
}


- (void)showDefaultViewWithStampImage:(UIImage *)image
                                 tips:(NSString *)tips
                               target:(id)target
                          actionTitle:(NSString *)actionTitle
                               action:(SEL)action
                   WithResponseResult:(BBGResponseResult)result
                               offset:(CGPoint)offset
                               onView:(UIView *)view {
    UIImage *showImage = image;
    NSString *showTips = tips;
    switch (result) {
        case BBGResponseNetError:
        {
            if (!showImage) {
                showImage = [UIImage imageNamed:@"universalStampUncollect"];
            }
            if (!showTips) {
                showTips = @"当前网络不佳，请检查网络";
            }
        }
            break;
        case BBGResponseNotData:
        {
            if (!showImage) {
                showImage = [UIImage imageNamed:@"universalStampSearch"];
            }
            if (!showTips) {
                showTips = @"没找到相关数据，请重试";
            }
        }
            break;
        case BBGResponseError:
        {
            if (!showImage) {
                showImage = [UIImage imageNamed:@"universalStampSearch"];
            }
            if (!showTips) {
                showTips = @"数据错误，请重试";
            }
        }
            break;
        default:
        {
            return;
        }
            break;
    }
    [_defaultView dismiss];
    
   _defaultView = [[BBGDefaultView alloc] initWithStampImage:showImage tips:showTips target:target action:action actionTitle:actionTitle];

    
    CGRect dFrame = _defaultView.frame;
    dFrame.origin.x = offset.x;
    dFrame.origin.y = offset.y;
    _defaultView.frame = dFrame;
    if (view) {
       [_defaultView showOnView:view];
        

    }else{
        [_defaultView showOnView:self.view];
    }
}

- (void)showAlertViewWithTips:(NSString *)tips
                       target:(id)target
                       action:(SEL)action
           WithResponseResult:(BBGResponseResult)result{

    NSString *showTips = tips;
    switch (result) {
        case BBGResponseNetError:
        {
                        if (!showTips) {
                showTips = @"当前网络不佳，请检查网络";
            }
        }
            break;
        case BBGResponseNotData:
        {
                        if (!showTips) {
                showTips = @"没找到相关数据，请重试";
            }
        }
            break;
        case BBGResponseError:
        {
                       if (!showTips) {
                showTips = @"数据错误，请重试";
            }
        }
            break;
        default:
        {
            return;
        }
            break;
    }
}


- (void)showDefaultViewWithStampImage:(UIImage *)image
                                 tips:(NSString *)tips
                               target:(id)target
                          actionTitle:(NSString *)actionTitle
                               action:(SEL)action
                   WithResponseResult:(BBGResponseResult)result
                               offset:(CGPoint)offset {
    [self showDefaultViewWithStampImage:image
                                   tips:tips
                                 target:target
                            actionTitle:actionTitle
                                 action:action
                     WithResponseResult:result
                                 offset:CGPointZero
                                 onView:nil];
}

- (void)showDefaultViewWithStampImage:(UIImage *)image
                                 tips:(NSString *)tips
                               target:(id)target
                          actionTitle:(NSString *)actionTitle
                               action:(SEL)action
                   WithResponseResult:(BBGResponseResult)result {
    [self showDefaultViewWithStampImage:image
                                   tips:tips
                                 target:target
                            actionTitle:actionTitle
                                 action:action
                     WithResponseResult:result
                                 offset:CGPointZero];
}


- (void)dismissDefaultView {
    [_defaultView dismiss];
}


- (void)dealloc{
    self.pushAnimator = nil;
    self.navigationController.delegate = nil;
    self.popAnimator = nil;
    self.response = nil;
    self.defaultView = nil;
    self.leftImage = nil;
    self.response = nil;
    _searchDisplayViewController = nil;
    NSLog(@"%@ dealloc",self.class);
}

#pragma mark -- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[BBGLoginViewController class]]) {
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.navigationController.view.backgroundColor = [UIColor clearColor];
    }else if([viewController isKindOfClass:[BBGRegisterViewController class]]){
        self.navigationController.navigationBar.translucent = NO;
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = nil;
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
