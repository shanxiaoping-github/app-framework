//
//  BBGMainViewController_iPhone.m
//  YHInternational
//
//  Created by Damon on 15/4/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMainViewController_iPhone.h"
#import "BBGViewController.h"
#import "BBGNavigationController.h"
#import "BBGUserCenterViewController_iPhone.h"
#import "BBGShoppingCartViewController_iPhone.h"
#import "BBGGoodsListViewController_iPhone.h"
#import "BBGFindCenterViewController_iPhone.h"
#import "UITabBarItem+CustomBadge.h"
#import "BBGIndexRecommendViewController_iPhone.h"
#import "BBGMaternalAndBeautyViewController_iPhone.h"
#import "MainCenterViewController_iPhoneViewController.h"
@interface BBGMainViewController_iPhone ()

@property (nonatomic,strong) UITabBarItem * mainItem;
@property (nonatomic,strong) UITabBarItem * findItem;
@property (nonatomic,strong) UITabBarItem * cartItem;
@property (nonatomic,strong) UITabBarItem * userItem;


@end

@implementation BBGMainViewController_iPhone

- (id)init{
    self = [super init];
    if (self) {
        
        NSMutableArray * controllers = [NSMutableArray array];
        
        UIImage *homeSelectedImage = THEME_IMAGE(@"Home_Clicked");
        _mainItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:THEME_IMAGE(@"Home")selectedImage:[homeSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHexadecimalRGB(0x746a68), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHexadecimalRGB(0xf03468),NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
        
       MainCenterViewController_iPhoneViewController * mainViewController = [[MainCenterViewController_iPhoneViewController alloc]initWithMenus:[self loadMainMenuData]];
        
        
        BBGNavigationController * mainnav = [[BBGNavigationController alloc]initWithRootViewController:mainViewController];
        mainnav.isFirstView = YES;
        mainnav.isChangeTheme = YES;
        mainViewController.isMainViewController = YES;
        mainViewController.tabBarItem = _mainItem;
        [controllers addObject:mainnav];
        
        UIImage *findSelectedImage = THEME_IMAGE(@"Find_Clicked");
        _findItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:THEME_IMAGE(@"Find")selectedImage:[findSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        BBGFindCenterViewController_iPhone *findCenterController = [[BBGFindCenterViewController_iPhone alloc] initWithMenus:[self loadFindMenuData]];
        BBGNavigationController * findNav = [[BBGNavigationController alloc]initWithRootViewController:findCenterController];
        findNav.isFirstView = YES;
        findNav.isChangeTheme = YES;
        findCenterController.isMainViewController = YES;
        findCenterController.tabBarItem = _findItem;
        [controllers addObject:findNav];

        UIImage  *shoppingCartSelectedImage = THEME_IMAGE(@"ShoppingCart_Clicked");
        _cartItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:THEME_IMAGE(@"ShoppingCart")selectedImage:[shoppingCartSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        BBGShoppingCartViewController_iPhone * cartViewController = [[BBGShoppingCartViewController_iPhone alloc]init];
        BBGNavigationController * cartNav = [[BBGNavigationController alloc]initWithRootViewController:cartViewController];
        cartNav.isFirstView = YES;
        cartViewController.isMainViewController = YES;
        cartViewController.title = @"购物车";
        cartViewController.tabBarItem = _cartItem;
        [controllers addObject:cartNav];
        
        /*!
         *  购物车KVO
         */
        [[BBGCartManager sharedInstance] setValue:@(0) forKey:@"cartCount"];
        [[BBGCartManager sharedInstance] addObserver:self forKeyPath:@"cartCount" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        UIImage *userCenterSelectedImage = THEME_IMAGE(@"UserCenter_Clicked");
        _userItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:THEME_IMAGE(@"UserCenter")selectedImage:[userCenterSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

        BBGUserCenterViewController_iPhone * userController = [[BBGUserCenterViewController_iPhone alloc]init];
        BBGNavigationController * userNav = [[BBGNavigationController alloc]initWithRootViewController:userController];
        userNav.isFirstView = YES;
        userNav.isChangeTheme = YES;
        userController.isMainViewController = YES;
        userController.title = @"个人中心";
        userController.tabBarItem = _userItem;
        [controllers addObject:userNav];

        self.viewControllers = controllers;
        
        
        UIImageView *tabBarBgImg = [[UIImageView alloc] initWithImage:THEME_IMAGE(@"tab_bar_bgimg")];
        tabBarBgImg.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        tabBarBgImg.contentMode = UIViewContentModeScaleToFill;
        [[self tabBar] insertSubview:tabBarBgImg atIndex:0];
        
        [[BBGConfiguration sharedInstance] bk_addObserverForKeyPath:@"theme" task:^(id target) {
            CATransition *transtition = [CATransition animation];
            transtition.duration = 0.3;
            transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transtition.type = kCATransitionFade;
            [tabBarBgImg.layer addAnimation:transtition forKey:@"changTabBgImg"];
            [tabBarBgImg setImage:THEME_IMAGE(@"tab_bar_bgimg")];
            [tabBarBgImg.layer removeAnimationForKey:@"changTabBgImg"];
        }];
        
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"cartCount"]) {
        UITabBarItem * item = self.tabBar.items[2];
        NSNumber *cartCount = [[BBGCartManager sharedInstance] valueForKey:@"cartCount"];
        if ([cartCount intValue] == 0 || !cartCount) {
            item.badgeValue = nil;
        }else{
            [item setCustomBadgeValue:[NSString stringWithFormat:@"%@",cartCount] withFont:APP_FONT(12) andFontColor:[UIColor whiteColor] andBackgroundColor:UICOLOR_FONT_IMPORTANT_RED];
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [BBGJumpManager sharedInstance].selectedIndex = 0;
    [BBGJumpManager sharedInstance].tabBarController = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)indexForViewController:(UIViewController *)viewController {
    int index = -1;
    int i = 0;
    for (UIViewController *controller in self.viewControllers) {
        if (controller == viewController) {
            index = i;
            break;
        }
        i ++;
    }
    if (index < 2) {
        [BBGJumpManager sharedInstance].selectedIndex = index;
    }
    return index;
}

-(NSArray *)loadFindMenuData{
    
    NSMutableArray *menus = [NSMutableArray arrayWithCapacity:2];
    BBGMenuItem *item1 = [[BBGMenuItem alloc] init];
    item1.menuID = @"111";
    item1.menuName = @"分类";
    [menus addObject:item1];
    
    BBGMenuItem *item2 = [[BBGMenuItem alloc] init];
    item2.menuID = @"222";
    item2.menuName = @"国家";
    [menus addObject:item2];
    
    return menus;
}

-(NSArray *)loadMainMenuData{
    NSMutableArray *menus = [NSMutableArray arrayWithCapacity:2];
    BBGMenuItem *item1 = [[BBGMenuItem alloc] init];
    item1.menuID = @"1111";
    item1.menuName = @"热门";
    [menus addObject:item1];
    
    BBGMenuItem *item2 = [[BBGMenuItem alloc] init];
    item2.menuID = @"2222";
    item2.menuName = @"母婴";
    [menus addObject:item2];
    
    BBGMenuItem *item3 = [[BBGMenuItem alloc] init];
    item3.menuID = @"3333";
    item3.menuName = @"美妆";
    [menus addObject:item3];
    
    BBGMenuItem *item4 = [[BBGMenuItem alloc] init];
    item4.menuID = @"4444";
    item4.menuName = @"食品保健";
    [menus addObject:item4];
    
    return menus;
}

- (void)dealloc{
    [[BBGCartManager sharedInstance] removeObserver:self forKeyPath:@"cartCount"];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
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
