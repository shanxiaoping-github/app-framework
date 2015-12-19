//
//  BBGUserCenterViewController_iPhone.m
//  YHInternational
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserCenterViewController_iPhone.h"
#import "BBGLoginViewController_iPhone.h"
#import "BBGTableView.h"
#import "BBGMyPraiseViewController_iPhone.h"
#import "BBGMyAddressViewController_iPhone.h"
#import "BBGMyCommentViewController_iPhone.h"
#import "BBGSettingViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGUserCenterCell.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import <UIKit/UIImage.h>
#import "Masonry.h"
#import "BBGUserCenterHeaderView.h"
#import "BBGOrderCenterViewController_iPhone.h"
#import "BBGCouponCenterViewController_iPhone.h"
#import "BBGCouponViewController_iPhone.h"
#import "BBGShoppingCartViewController_iPhone.h"
#import "BBGLogisticsViewController_iPhone.h"
#import "BBGGoodsListViewController_iPhone.h"
#import "BBGIDCardListViewController_iPhone.h"
#import <AVFoundation/AVFoundation.h>
#import "TOCropViewController.h"

@interface BBGUserCenterViewController_iPhone ()<BBGTableViewDataSource,BBGTableViewDelegate,BBGUserCenterMenuViewDelegate,BBGJumpObserver,UITableViewDataSource,UITableViewDelegate,TOCropViewControllerDelegate>

@property (nonatomic, strong) UITableView *userCenterTableView;
@property (nonatomic, strong) BBGUserCenterHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation BBGUserCenterViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[BBGJumpManager sharedInstance] addObserver:self];
//        [[BBGOrderCountManager sharedInstance] addObserver:self];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [self reloadView];
}

- (void)reloadView{
    __weak BBGUserCenterViewController_iPhone *weakSelf = self;
    [[BBGSession sharedInstance] getUserDetailInfo:^(BOOL successful) {
        if (successful) {
            weakSelf.userDetailInfo = [BBGSession sharedInstance].userDetailInfo;
            NSString *nickName = weakSelf.userDetailInfo.nickName;
            NSString *userHeadUrl = weakSelf.userDetailInfo.headImg;
            
            [weakSelf.headerView.userHeadImage sd_setImageWithURL:[NSURL URLWithString:userHeadUrl] forState:UIControlStateNormal];
            weakSelf.headerView.nameTextField.text = nickName;
        }
    }];
    
    [self getUserCount:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            weakSelf.headerView.unPayBadgeView.number = weakSelf.unpaidOrderCount;
            weakSelf.headerView.unSendBadgeView.number = weakSelf.waitSendGoodsCount;
            weakSelf.headerView.unReceiptBadgeView.number = weakSelf.logisticsCount;
        }
    }];
    
    [self getCommentDetailCount:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            [weakSelf.userCenterTableView reloadData];
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"个人中心";
    label.textColor = [UIColor whiteColor];
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    [self initData];
     // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    UIColor * color = [UIColor whiteColor];
    NSDictionary *colorDict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:colorDict];

    [self createRightBarButtonItemWithTarget:self action:@selector(actionOfSetting:) normalImage:[UIImage imageNamed:@"setting"] highlightedImage:nil];

    self.userCenterTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.userCenterTableView setSeparatorColor:RGB_CELL_GRAY];
    self.userCenterTableView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.userCenterTableView.backgroundColor = [UIColor clearColor];
    self.userCenterTableView.dataSource = self;
    self.userCenterTableView.delegate = self;
    self.view.backgroundColor = UIColorFromRGB(239, 239, 239);
    [self.view addSubview:self.userCenterTableView];
    
    CGSize size = THEME_IMAGE(@"userBckg").size;
    _headerView = [[BBGUserCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_HEIGHT, size.height)];
    [_headerView setDelegate:self];
    _headerView.nameTextField.delegate = self;
    _headerView.nameTextField.tintColor = UICOLOR_FONT_IMPORTANT_RED;
    [_headerView.nameTextField.lineLayer setHidden:YES];
    [_headerView.nameTextField addRightButtonOnKeyboardWithText:@"完成" target:self action:@selector(updateUserNamePressed:)];
    _userCenterTableView.tableHeaderView = self.headerView;
    _userCenterTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 20)];
    
    WS(ws)
    [[BBGConfiguration sharedInstance] bk_addObserverForKeyPath:@"theme" task:^(id target) {
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [ws.headerView.bgImgView.layer addAnimation:transition forKey:@"changeUserBackImg"];
        [ws.headerView.bgImgView setImage:THEME_IMAGE(@"userBckg")];
        [ws.headerView.bgImgView.layer removeAnimationForKey:@"changeUserBackImg"];
    }];
}

//设置
- (IBAction)actionOfSetting:(id)sender {
    BBGSettingViewController_iPhone *settingViewController = [[BBGSettingViewController_iPhone alloc] init];
    BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:settingViewController];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        
    }];
}


- (void)initData{
    _titleArray = [[NSMutableArray alloc] init];
    NSMutableArray *array  = [NSMutableArray array];
    [array addObject:@"comment"];
    [array addObject:@"praise"];
    [array addObject:@"coupons"];
    [array addObject:@"address"];
    [array addObject:@"IDCard"];
    [array addObject:@"logistics"];
    [_titleArray addObject:array];
    
    array = [NSMutableArray array];
    [array addObject:@"phone"];
    [self.titleArray addObject:array];
}

#pragma mark - UITableViewDataSource And UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.titleArray COUNT];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    NSArray *array = [self.titleArray ARRAY_OBJ_AT(section)];
    rows = [array COUNT];
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (BBGTableViewCell *)tableView:(BBGTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"userCenterTableViewCellIdentifier";
    BBGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[BBGTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        
        UIImageView *iconImg = [UIImageView new];
        iconImg.tag = 1000;
        [cell.contentView addSubview:iconImg];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.tag = 1001;
        [titleLabel setFont:APP_FONT(13)];
        [titleLabel setTextColor:UICOLOR_FONT_IMPORTANT_BLACK];
        [cell.contentView addSubview:titleLabel];
        
        UILabel *valueLabel = [UILabel new];
        valueLabel.tag = 1002;
        [valueLabel setFont:APP_FONT(12)];
        [valueLabel setTextColor:UICOLOR_FONT_IMPORTANT_RED];
        [cell.contentView addSubview:valueLabel];
        
        UIImageView *arrowImgView = [UIImageView imageViewWithMyImage:@"rightArrow"];
        arrowImgView.tag = 1003;
        [cell.contentView addSubview:arrowImgView];
        
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(cell.contentView).offset(10);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(iconImg.mas_right).offset(10);
        }];
        
        [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(arrowImgView.mas_left).offset(-5);
        }];
        
        [arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(cell.contentView).offset(-10);
        }];
    }
    NSArray *array = [_titleArray ARRAY_OBJ_AT(indexPath.section)];
    NSString *str = [array ARRAY_OBJ_AT(indexPath.row)];
    
    UIImageView *iconImg = (UIImageView*)[cell viewWithTag:1000];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1001];
    UILabel *valueLabel = (UILabel *)[cell viewWithTag:1002];
    UIImageView *arrowImgView = (UIImageView*)[cell viewWithTag:1003];

    
    [arrowImgView setHidden:NO];
    [valueLabel setText:@""];
    [valueLabel setTextColor:UICOLOR_FONT_IMPORTANT_RED];
    [valueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(arrowImgView.mas_left).offset(-5);
    }];
    
    if ([@"phone" isEqualToString:str]){
        [arrowImgView setHidden:YES];
        [valueLabel setTextColor:UICOLOR_FONT_GENERAL_GRAY];
        [valueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(arrowImgView.mas_left).offset(10);
        }];
    }
    
    
    if ([@"comment" isEqualToString:str]) {
        [iconImg setImage:[UIImage imageNamed:@"comment"]];
        [titleLabel setText:@"评论晒单"];
        if (self.countsForShareOrder == 0) {
            [valueLabel setText:@""];
        }else{
            [valueLabel setText:[NSString stringWithFormat:@"%ld",(long)self.countsForShareOrder]];
        }
        
    }else if ([@"praise" isEqualToString:str]){
        [iconImg setImage:[UIImage imageNamed:@"praise"]];
        [titleLabel setText:@"点赞"];
    }else if ([@"coupons" isEqualToString:str]){
        [iconImg setImage:[UIImage imageNamed:@"coupon"]];
        [titleLabel setText:@"优惠券"];
    }else if ([@"address" isEqualToString:str]){
        [iconImg setImage:[UIImage imageNamed:@"address"]];
        [titleLabel setText:@"地址"];
    }else if ([@"IDCard" isEqualToString:str]){
        [iconImg setImage:[UIImage imageNamed:@"IDCardManager"]];
        [titleLabel setText:@"身份证"];
    }else if ([@"logistics" isEqualToString:str]){
        [iconImg setImage:[UIImage imageNamed:@"logistics"]];
        [titleLabel setText:@"物流"];
    }else if ([@"phone" isEqualToString:str]){
        [iconImg setImage:[UIImage imageNamed:@"phoneIcon"]];
        [titleLabel setText:@"客服电话"];
        [valueLabel setText:@"400-888-8881"];
    }
    return cell;
}

//设置分割线左边距
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }

    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(BBGTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = [_titleArray ARRAY_OBJ_AT(indexPath.section)];
    NSString *str = [array ARRAY_OBJ_AT(indexPath.row)];
    if ([@"comment" isEqualToString:str]) {
        BBGMyCommentViewController_iPhone *commentListViewController = [[BBGMyCommentViewController_iPhone alloc] init];
        commentListViewController.title = @"评论晒单";
        commentListViewController.noCommentGoodsNumber = self.countsForShareOrder;
        BBGNavigationController * nav = [[BBGNavigationController alloc] initWithRootViewController:commentListViewController];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        }];
    }else if ([@"praise" isEqualToString:str]){
        BBGMyPraiseViewController_iPhone *praiseViewController = [[BBGMyPraiseViewController_iPhone alloc] init];
        praiseViewController.title = @"点赞";
        BBGNavigationController *praiseNav = [[BBGNavigationController alloc] initWithRootViewController:praiseViewController];
        [ [UIApplication sharedApplication].keyWindow.rootViewController presentViewController:praiseNav animated:YES completion:nil];
    }else if ([@"coupons" isEqualToString:str]){
        BBGCouponCenterViewController_iPhone * couponCenterViewController = [[BBGCouponCenterViewController_iPhone alloc] initWithMenus:[self loadCouponMenuData]];
        couponCenterViewController.currentMenuIndex = 0;
        
        BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:couponCenterViewController];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
    }else if ([@"address" isEqualToString:str]){
        BBGMyAddressViewController_iPhone *addressViewController = [[BBGMyAddressViewController_iPhone alloc] init];
        addressViewController.title = @"地址";
        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:addressViewController];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
    }else if ([@"IDCard" isEqualToString:str]){
        BBGIDCardListViewController_iPhone * IDCardViewController = [[BBGIDCardListViewController_iPhone alloc]init];
        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:IDCardViewController];
        IDCardViewController.title = @"身份证";
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
        
    }else if ([@"logistics" isEqualToString:str]){
        BBGLogisticsViewController_iPhone * logisticsViewController = [[BBGLogisticsViewController_iPhone alloc]init];
        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:logisticsViewController];
        logisticsViewController.title = @"物流";

        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
        
    }else if ([@"phone" isEqualToString:str]){
        [BBGTools callPhone:@"400-888-8881" alertTitle:@"是否拨打电话号码"];
    }
    
}

- (NSArray *)loadCouponMenuData{
    NSMutableArray *menus = [NSMutableArray arrayWithCapacity:3];
    
    BBGMenuItem *item5 = [[BBGMenuItem alloc] init];
    item5.menuID = @"11";
    item5.menuName = @"可使用";
    [menus addObject:item5];
    
    BBGMenuItem *item6 = [[BBGMenuItem alloc] init];
    item6.menuID = @"12";
    item6.menuName = @"已使用";
    [menus addObject:item6];
    
    BBGMenuItem *item7 = [[BBGMenuItem alloc] init];
    item7.menuID = @"13";
    item7.menuName = @"已失效";
    [menus addObject:item7];
    
    return menus;
}

#pragma mark - BBGUserCenterHeaderDelegate
// 选择用户头像
- (void)chooseUserIcons {
    if (![BBGSession sharedInstance].isLogin) {
        [[BBGLoadingTips sharedInstance] showTips:@"请先登录"];
        return;
    }
    
    [self.view endEditing:YES];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];

}

// 编辑用户名
- (void)editUserName {
    BBGLoginViewController_iPhone *loginViewController = [[BBGLoginViewController_iPhone alloc] init];
    loginViewController.title = @"登录";
    
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- BBGUserCenterMenuViewDelegate
- (void)menuItemSelected:(BBGUserCenterHeaderView *)menuView atIndex:(NSInteger)index{
    NSLog(@"index :%ld",(long)index);
    BBGOrderCenterViewController_iPhone *orderCenterViewController = [[BBGOrderCenterViewController_iPhone alloc] initWithMenus:[self loadMenuData]];
    orderCenterViewController.currentMenuIndex = index;
    
    BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:orderCenterViewController];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        
    }];
}


-(NSArray *)loadMenuData{
    
    NSMutableArray *menus = [NSMutableArray array];
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
    item5.menuName = @"全部";
    [menus addObject:item5];
    
    return menus;
}

#pragma mark UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
               [[BBGLoadingTips sharedInstance] showTips:@"请在设置->隐私里打开本应用对相机的使用权限"];
                return;
            }
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }else{
            [BBGAlertView showWithTitle:@"" message:@"抱歉！该手机没有摄像头" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                
            } buttonTitles: nil];
            return;
        }
    }else if (buttonIndex == 1){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }
}


#pragma mark  UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{ 
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:originImage];
        cropController.delegate = self;
        [self presentViewController:cropController animated:YES completion:^{
            [cropController.cropView setAspectLockEnabledWithAspectRatio:CGSizeMake(100, 100) animated:YES];
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated: YES completion:^{
        
    }];
}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle{
    
    image = [image reSizeImage:CGSizeMake(300, 300)];
    WS(ws)
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        
        [[BBGLoadingTips sharedInstance] showLoading:@"正在上传"];
        [ws uploadUserHeadImg:image callBack:^(BOOL sucessful, BBGResponse *response) {
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                BBGUploadUserHeadResponse *tempResponse = (BBGUploadUserHeadResponse*)response;
                ws.headImg = tempResponse.userHeader.imageId;
                [ws setUserHeadImg:^(BOOL sucessful, BBGResponse *response) {
                    [ws reloadView];
                }];
            }
        } data:^(NSUInteger bytes, long long totalBytes, long long totalBytesExpected) {
            
        }];
    }];
    
    
    
    
}


-(void)updateUserNamePressed:(id)sender{
    if (![BBGSession sharedInstance].isLogin) {
        [[BBGLoadingTips sharedInstance] showTips:@"请先登录"];
        return;
    }
    
    NSString *updateNameStr = _headerView.nameTextField.text;
    [_headerView.nameTextField endEditing:YES];
    if ([BBGTools checkStringIsBlank:updateNameStr]) {
        [[BBGLoadingTips sharedInstance] showTips:@"请输入昵称"];
        return;
    }
    
    if ([updateNameStr isEqualToString:self.userDetailInfo.nickName]) {
        return;
    }
    self.nickName = updateNameStr;
    
    
    __weak BBGUserCenterViewController_iPhone *weakSelf = self;
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            [weakSelf.headerView.nameTextField setText:self.nickName];
        }
    }];
}

#pragma mark  UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [_headerView.nameTextField.lineLayer setHidden:NO];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [_headerView.nameTextField.lineLayer setHidden:YES];
    self.userDetailInfo = [BBGSession sharedInstance].userDetailInfo;
    NSString *nickName = self.userDetailInfo.nickName;
    NSString *userHeadUrl = self.userDetailInfo.headImg;
    
    [_headerView.userHeadImage sd_setImageWithURL:[NSURL URLWithString:userHeadUrl] forState:UIControlStateNormal];
    _headerView.nameTextField.text = nickName;
}


#pragma mark - 跳转
- (void)jumpTo:(NSNumber *)type{
    BBGJumpType jumpType = [type intValue];
    switch (jumpType) {
        case BBGJumpOrderList:
        {
            BBGOrderCenterViewController_iPhone *orderCenterViewController = [[BBGOrderCenterViewController_iPhone alloc] initWithMenus:[self loadMenuData]];
            orderCenterViewController.currentMenuIndex = 1;
            BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:orderCenterViewController];
            [self presentViewController:nav animated:YES completion:nil];
            self.tabBarController.selectedIndex = 3;
        }
            break;
        default:
            break;
    }
    
}

-(void)dealloc{
    [[BBGJumpManager sharedInstance] removeObserver:self];
}


@end
