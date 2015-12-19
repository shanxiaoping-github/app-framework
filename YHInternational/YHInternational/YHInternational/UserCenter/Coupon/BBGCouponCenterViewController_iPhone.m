//
//  BBGCouponCenterViewController_iPhone.m
//  YHInternational
//
//  Created by Damon on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCouponCenterViewController_iPhone.h"
@interface BBGCouponCenterViewController_iPhone ()
@end

@implementation BBGCouponCenterViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.title = @"优惠券";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
        label.text = @"优惠券" ;
        label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
        label.textColor = [UIColor blackColor] ;
        label.textAlignment = NSTextAlignmentCenter ;
        self.navigationItem.titleView = label ;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleTopMargin;
    
    // Do any additional setup after loading the view.
}

- (UINavigationController *)contentViewController{
    
    return self.navigationController;
}
-(NSString *)isShowBackGroundView{
    
    return @"选中";
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
