//
//  BBGContentViewController_iPhone.m
//  YHInternational
//
//  Created by Damon on 15/4/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGContentViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGShoppingCartViewController_iPhone.h"
#import "BBGJumpManager.h"
#import "PTCountDown.h"
#import "BBGShareModel.h"
#import "BBGRedPaperView.h"
#import "BBGShareManager.h"
@interface BBGContentViewController_iPhone ()<UITabBarControllerDelegate,BBGJumpObserver>
@property (strong, nonatomic) BBGRedPaperView *redView;
@property (strong, nonatomic) BBGShareModel *model;
@property (strong, nonatomic) PTCountDown *cd;

@end

@implementation BBGContentViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];

        _mainViewController = [[BBGMainViewController_iPhone alloc] init];
        _mainViewController.view.backgroundColor = [UIColor whiteColor];
        _mainViewController.delegate = self;
        _mainViewController.view.frame = self.view.bounds;
        [self.view addSubview:_mainViewController.view];
        [[BBGJumpManager sharedInstance] addObserver:self];
//        [[BBGCartManager sharedInstance] addObserver:_mainViewController];
//        [[BBGSessionManager sharedInstance] addObserver:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [BBGSessionManager sharedInstance].currentViewController = viewController;
    NSInteger index = [_mainViewController indexForViewController:viewController];
    if (index == 2 ||index == 3 || index == 4) {
        __weak BBGContentViewController_iPhone * weakSelf = self;
        if (![BBGSessionManager sharedInstance].isLogin) {
            [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                if (successful) {
                    if (index != 2) {
                        tabBarController.selectedIndex = index;
                    }else{
                        [weakSelf showShoppingCarView];
                    }
                    
                }
            }];
            return NO;
        }
        if (index == 2) {
            [self showShoppingCarView];
            return NO;
        }
    }
    return YES;
}

- (void)showShoppingCarView{
    BBGShoppingCartViewController_iPhone * cartViewController = [[BBGShoppingCartViewController_iPhone alloc]init];
    BBGNavigationController * cartNav = [[BBGNavigationController alloc]initWithRootViewController:cartViewController];
    [self presentViewController:cartNav animated:YES completion:^{
        
    }];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}

#pragma mark - BBGSessionObserver
- (void)sessionDoLogout {
    self.mainViewController.selectedIndex = 0;
}

#pragma mark -BBGJumpManager Observer
- (void)jumpTo:(NSNumber *)type{
    BBGJumpType jumpType = [type intValue];
    if (jumpType==BBGJumpCart) {
        [self showShoppingCarView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[BBGJumpManager sharedInstance] removeObserver:self];
    self.mainViewController = nil;
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
