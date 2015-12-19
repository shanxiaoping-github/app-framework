//
//  BBGChannelViewController.m
//  Components
//
//  Created by elvis.peng on 14-8-26.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGChannelViewController.h"
#import "BBGMenuItem.h"
#import "BBGMenuNavigationView.h"
#import "BBGAutoresizingScrollView.h"
#import "BBGMacro.h"
@interface BBGChannelViewController ()<BBGMenuNavigationViewDataSource,BBGMenuNavigationViewDelegate,UIScrollViewDelegate>
/**
 *  导航栏
 */
@property (nonatomic, strong) BBGMenuNavigationView *menuNavigationView;
/**
 *  展示内容的ScrollView
 */
@property (nonatomic, strong) BBGAutoresizingScrollView *contentScrollView;
/**
 *  所有内容的视图控制器
 */
@property (nonatomic, strong) NSMutableArray *contents;

@end

@implementation BBGChannelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMenus:(NSArray *)menus {
    self = [super init];
    if (self) {
        _menus = menus;
        _currentMenuIndex = 0;
    }
    return self;
}

- (void)loadContent {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _menuNavigationView = [[BBGMenuNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 39)];
    _menuNavigationView.backgroundColor = UIColorFromRGB(247, 247, 247);
    _menuNavigationView.dataSource = self;
    _menuNavigationView.delegate = self;
    [self.view addSubview:_menuNavigationView];
    
    self.contentScrollView = [[BBGAutoresizingScrollView alloc] initWithFrame:CGRectMake(0, self.menuNavigationView.frame.origin.y + self.menuNavigationView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.menuNavigationView.frame.size.height + 5)];
    self.contentScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.scrollsToTop = NO;
    [self.view addSubview:self.contentScrollView];
    [self reloadContent];
    [_menuNavigationView selectItemAtIndex:_currentMenuIndex];
}
//重新加载所有内容
- (void)reloadContent {
    
    for (id content in self.contents) {
        if ([content isKindOfClass:[UIViewController class]]) {
            [((UIViewController *)content).view removeFromSuperview];
        }
    }
    NSInteger contentCount = [self.menus count];
    CGRect contentFrame = self.contentScrollView.frame;
    self.contentScrollView.contentSize = CGSizeMake(contentFrame.size.width * contentCount, contentFrame.size.height);
    self.contentScrollView.contentOffset = CGPointMake(_currentMenuIndex *contentFrame.size.width, 0);
    self.contents = [NSMutableArray arrayWithCapacity:contentCount];
    for (int i = 0; i < contentCount; i ++) {
        [self.contents addObject:[NSNull null]];
    }
    [self loadPageAtIndex:_currentMenuIndex];
}

- (void)loadSubPageContentAtIndex:(NSInteger)index{
    UIViewController<BBGContentProtocol> *controller = [self.contents objectAtIndex:index];
    BBGMenuItem *menu = [self.menus objectAtIndex:index];

    if ([controller respondsToSelector:@selector(isLoadCustomDataWithMenu:)]) {
        BOOL isload = [controller isLoadCustomDataWithMenu:menu];
        if (isload) {
            [controller distributionData:[self loadCustomDataWithMenu:menu]];
        }
    }
}

- (void)loadPageAtIndex:(NSInteger)index {
    [self loadPageContentAtIndex:index - 1];
    [self loadPageContentAtIndex:index];
    [self loadPageContentAtIndex:index + 1];
    UIViewController<BBGContentProtocol> *controller = [self.contents objectAtIndex:index];
    BBGMenuItem *menu = [self.menus objectAtIndex:index];
    if ([controller respondsToSelector:@selector(contentViewController:)]) {
        [controller contentViewController: [self contentViewController]];
    }
    if ([controller respondsToSelector:@selector(isLoadCustomDataWithMenu:)]) {
        BOOL isload = [controller isLoadCustomDataWithMenu:menu];
        if (isload) {
            [controller distributionData:[self loadCustomDataWithMenu:menu]];
        }
    }
    [controller loadDataWithMenu:menu force:NO];
}

- (void)loadPageContentAtIndex:(NSInteger)index {
    if (index < 0 || index >= [self.menus count]) {
        return;
    }
    CGRect contentFrame = _contentScrollView.bounds;
    BBGMenuItem *item = [self.menus objectAtIndex:index];
    id content = [self.contents objectAtIndex:index];
    if ([content isKindOfClass:[NSNull class]]) {
        UIViewController *controller = [self buildContentByMenuItem:item];//[[BBGContentFactory_iPhone sharedInstance] buildContentByMenuItem:item];
        controller.view.frame = CGRectMake(index * contentFrame.size.width, 0, contentFrame.size.width, contentFrame.size.height);
        [self.contentScrollView addSubview:controller.view];
        [self.contents replaceObjectAtIndex:index withObject:controller];
    }
}

- (void)scrollFromPage:(NSInteger)fromPage toPage:(NSInteger)toPage animated:(BOOL)animated {
    CGRect contentFrame = _contentScrollView.bounds;
    NSTimeInterval duration = animated ? 0.25 : 0.0;
    if (labs(fromPage - toPage) > 1) {
        NSInteger willToPage = fromPage > toPage ? fromPage - 1 : fromPage + 1;
        UIViewController *controller = [self.contents objectAtIndex:toPage];
        __block CGRect frame = controller.view.frame;
        frame.origin.x = willToPage * contentFrame.size.width;
        controller.view.frame = frame;
        [self.contentScrollView bringSubviewToFront:controller.view];
        
        __weak BBGChannelViewController * weakSelf = self;
        [UIView animateWithDuration:duration animations:^{
            weakSelf.contentScrollView.contentOffset = CGPointMake(contentFrame.size.width * willToPage, 0);
        } completion:^(BOOL finished) {
            frame.origin.x = toPage * contentFrame.size.width;
            controller.view.frame = frame;
            weakSelf.contentScrollView.contentOffset = CGPointMake(contentFrame.size.width * toPage, 0);
            weakSelf.currentMenuIndex = toPage;
        }];
    }else{
        __weak BBGChannelViewController * weakSelf = self;

        [UIView animateWithDuration:duration animations:^{
            weakSelf.contentScrollView.contentOffset = CGPointMake(contentFrame.size.width * toPage, 0);
        } completion:^(BOOL finished) {
            weakSelf.currentMenuIndex = toPage;
        }];
    }
}

- (void)goToMenuAtIndex:(NSInteger)index animated:(BOOL)animated {
    if (index >= 0 && index < [self.menus count]) {
        if (index != _currentMenuIndex) {
            [self loadPageAtIndex:index];
            [self scrollFromPage:_currentMenuIndex toPage:index animated:animated];
            [self.menuNavigationView selectItemAtIndex:index];
        }
    }
}

- (UIViewController<BBGContentProtocol> *)buildContentByMenuItem:(BBGMenuItem *)item{

    //空实现，在子类实现
    return nil;
}

-(id)loadCustomDataWithMenu:(BBGMenuItem *)menu{

    //空实现，在子类实现
    return nil;
}

-(UIViewController *)viewControllerWithMenuIndex:(NSInteger) index{
    if (index >= 0 && index < _menus.count) {
        UIViewController<BBGContentProtocol> *controller = [self.contents objectAtIndex:index];
        return controller;
    }
    return nil;
}

/**
 *  传递事件
 *
 *  @param sender <#sender description#>
 */
- (void)touchEventWithEventId:(id)sender{
    
  UIViewController<BBGContentProtocol> *controller = [self.contents objectAtIndex:self.currentMenuIndex];
    if (controller && [controller respondsToSelector:@selector(touchEventWithEventId:)]) {
        [controller touchEventWithEventId:sender];
    }
}
/**
 *  可以子类实现替换NAV
 *
 *  @return <#return value description#>
 */
-(UINavigationController *)contentViewController{

    return self.navigationController;
}

#pragma mark - BBGMenuNavigationViewDataSource And BBGMenuNavigationViewDelegate Methods
- (NSInteger)numberOfItemsInMenuNavigationView:(BBGMenuNavigationView *)menuNavigationView {
    return [self.menus count];
}

- (BBGMenuItemView *)menuNavigationView:(BBGMenuNavigationView *)menuNavigationView itemForMenuNavigationViewAtIndex:(NSInteger)index {
    BBGMenuItem *item = [self.menus objectAtIndex:index];
    BBGMenuItemView *itemView = [[BBGMenuItemView alloc] initWithFrame:CGRectMake(0, 0, 70, menuNavigationView.frame.size.height) itemTitle:item.menuName];
    itemView.itemViewFoucusColor = UIColorFromRGB(236, 18, 82);
    itemView.itemViewCommonColor = UIColorFromRGB(38, 38, 38);
    itemView.itemViewFocusFont = APP_FONT(15);
    itemView.itemViewCommonFont = APP_FONT(15);
    BOOL showBadge = [self isShowBadgeWithMenu:item];
    if (showBadge) {
        itemView.badgeCount = [self badgeCountWithMenu:item];
    }
    
    NSString *backImg = [self isShowBackGroundView];
    if (backImg) {
        itemView.backgroundView.image = _ResizeImage([UIImage imageNamed:backImg]);
    }
    return itemView;
}

- (void)menuNavigationView:(BBGMenuNavigationView *)menuNavigationView didSelectItemAtIndex:(NSInteger)index animated:(BOOL)animated {
    for (int i=0; i<[self.contents count]; i++) {
        UIViewController<BBGContentProtocol> *controller = [self.contents objectAtIndex:i];
        if ([controller respondsToSelector:@selector(changeViewController)]) {
                [controller changeViewController];
        }
    }
    [self loadPageAtIndex:index];
    [self scrollFromPage:_currentMenuIndex toPage:index animated:YES];
}

- (CGFloat)menuNavigationView:(BBGMenuNavigationView *)menuNavigationView spaceForItemAtIndex:(NSInteger)index {

    //整个menu的宽度
    CGFloat width = menuNavigationView.frame.size.width;
    //item的总个数
    NSInteger numberOfItems = menuNavigationView.numberOfItems;
    //计算space
    CGFloat space = (width-75*numberOfItems)/(numberOfItems+1);
    if (menuNavigationView.numberOfItems <=4) {
        return space;
    }
    return 10;
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _currentMenuIndex = page;
    [self loadPageAtIndex:page];
    [self.menuNavigationView selectItemAtIndex:page];
}


-(BOOL)isShowBadgeWithMenu:(BBGMenuItem *)menu{
    
    return NO;
}


-(NSString *)isShowBackGroundView{
    
    return nil;
}

-(NSInteger)badgeCountWithMenu:(BBGMenuItem *)menu{
    
    return 0;
}

-(void)reloadMenuView{

    [self.menuNavigationView reloadDataWithItemIndex:self.currentMenuIndex];
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
