//
//  BBGNavigationController.m
//  Components
//
//  Created by Damon on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGNavigationController.h"
#import "BBGMacro.h"
#import "BBGSessionManager.h"
#import "BBGSessionViewController.h"
#import "BBGLoginViewController.h"
@interface BBGNavigationController ()

@property (nonatomic,strong) NSString *token;

@end

@implementation BBGNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
//        [self setNeedsStatusBarAppearanceUpdate];

        [self setIsFirstView:NO];
        _mutableViewControllers = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


- (void)setIsFirstView:(BOOL)isFirstView{
    _isFirstView = isFirstView;
    if (_isFirstView) {
        [self.navigationBar setBackgroundImage:[THEME_IMAGE(@"NavBar") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
        
        WS(ws)
        _token = [[BBGConfiguration sharedInstance] bk_addObserverForKeyPath:@"theme" task:^(id target) {
            if (ws.isFirstView && ws.isChangeTheme) {
                CATransition *transition = [CATransition animation];
                transition.duration = 0.3;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [ws.navigationBar.layer addAnimation:transition forKey:@"NavBar"];
                [ws.navigationBar setBackgroundImage:[THEME_IMAGE(@"NavBar") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
                [ws.navigationBar.layer removeAnimationForKey:@"NavBar"];
            }
        }];
        
    }else{
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar_white"] forBarMetrics:UIBarMetricsDefault];
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (![viewController isKindOfClass:[BBGSessionViewController class]]) {
        [BBGSessionManager sharedInstance].currentViewController = viewController;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    return [super popViewControllerAnimated:animated];
}

- (void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    if (_token) {
        [[BBGConfiguration sharedInstance] bk_removeObserverForKeyPath:@"theme" identifier:_token];
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
