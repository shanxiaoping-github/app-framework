//
//  BBGOrderCenterViewController_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderCenterViewController_iPhone.h"

@interface BBGOrderCenterViewController_iPhone ()

@end

@implementation BBGOrderCenterViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.title = @"订单";

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"订单" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleTopMargin;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeToWaitSend) name:@"changeToWaitSend" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSArray *)loadMenuData{
    
    NSMutableArray *menus = [NSMutableArray arrayWithCapacity:4];
    BBGMenuItem *item1 = [[BBGMenuItem alloc] init];
    item1.menuID = @"1";
    item1.menuName = @"待付款";
    [menus addObject:item1];
    
    BBGMenuItem *item2 = [[BBGMenuItem alloc] init];
    item2.menuID = @"2";
    item2.menuName = @"待发货";
    [menus addObject:item2];
    
    BBGMenuItem *item3 = [[BBGMenuItem alloc] init];
    item3.menuID = @"3";
    item3.menuName = @"待收货";
    [menus addObject:item3];
    
    BBGMenuItem *item4 = [[BBGMenuItem alloc] init];
    item4.menuID = @"4";
    item4.menuName = @"已收货";
    [menus addObject:item4];
    
    BBGMenuItem *item5 = [[BBGMenuItem alloc] init];
    item5.menuID = @"5";
    item5.menuName = @"已结束";
    [menus addObject:item5];
    
    return menus;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (UINavigationController *)contentViewController{
    
    return self.navigationController;
}

-(NSString *)isShowBackGroundView{
    
    return @"选中";
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeToWaitSend" object:nil];
}

- (void)changeToWaitSend{
    [self goToMenuAtIndex:1 animated:YES];
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
