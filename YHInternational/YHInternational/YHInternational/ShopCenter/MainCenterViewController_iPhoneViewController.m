//
//  MainCenterViewController_iPhoneViewController.m
//  YHInternational
//
//  Created by Damon on 15/7/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "MainCenterViewController_iPhoneViewController.h"
#import "BBGSpecialWebViewController_iPhone.h"
#import "BBGQrCodeViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGSearchViewController_iPhone.h"
#import "BBAboutViewController_iPhone.h"
#import "PTCountDown.h"
#import "BBGShareModel.h"
#import "BBGRedPaperView.h"
#import "BBGShareManager.h"
#import "PTTimerAppear.h"
@interface MainCenterViewController_iPhoneViewController ()<UISearchBarDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) BBGSearchBar *searchBar;
@property (strong, nonatomic) BBGRedPaperView *redView;
@property (strong, nonatomic) BBGShareModel *model;
@property (strong, nonatomic) PTCountDown *cd;
@end

@implementation MainCenterViewController_iPhoneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - 创建红包入口
- (void)createRedpaper:(NSNotification*)notification {

    _model = [[BBGShareModel alloc]init];
    _model = [notification object];
    
    if (_model.shareUrl!=nil) {
        _cd = [[PTCountDown alloc]initWithFrame:CGRectMake(10, IPHONE_HEIGHT-300, 74, 90)];
        _cd.overTime = _model.overTime;
        [_cd handlerButtonAction:^{
            [BBGRedPaperView showWithModel:_model statue:NO];
        }];
        [self.view addSubview:_cd];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleTopMargin;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createRedpaper:) name:@"redPaperPost" object:nil];
    
    
    //首页浮层
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(bmmsFinish:) name:BMMS_FINISH_NOTIFICATION object:nil];
    
//    UIButton *logoBtn = [self createLeftBarButtonItemWithTarget:self action:@selector(logoImage) normalImage:THEME_IMAGE(@"logo") highlightedImage:THEME_IMAGE(@"logo")];
//    _searchBar = [[BBGSearchBar alloc] initWithFrame:CGRectMake(0, 0, 2000, 35)];
//    _searchBar.delegate = self;
//    _searchBar.placeholder = @"购全球，上云猴";
//    _searchBar.placeholderTextColor = UIColorFromHexadecimalRGB(0xfc94c2);
//    _searchBar.searchBarBgImage = [THEME_IMAGE(@"SearchBarBg_red") stretchImage];
//    _searchBar.searchLeftViewImage = THEME_IMAGE(@"SearchIcon_red");
//    self.navigationItem.titleView = _searchBar;
//    UIButton *qrBtn = [self createRightBarButtonItemWithTarget:self action:@selector(saoMa) normalImage:THEME_IMAGE(@"QR_code") highlightedImage:nil];
//    
//    WS(ws)
//    [[BBGConfiguration sharedInstance] bk_addObserverForKeyPath:@"theme" task:^(id target) {
//        [logoBtn setImage:THEME_IMAGE(@"logo") forState:UIControlStateNormal];
//        [logoBtn setImage:THEME_IMAGE(@"logo") forState:UIControlStateHighlighted];
//    
//        ws.searchBar.placeholderTextColor = UIColorFromHexadecimalRGB(0x735098);
//        ws.searchBar.searchBarBgImage = [THEME_IMAGE(@"SearchBarBg_red") stretchImage];
//        ws.searchBar.searchLeftViewImage = THEME_IMAGE(@"SearchIcon_red");
//        
//        [qrBtn setImage:THEME_IMAGE(@"QR_code") forState:UIControlStateNormal];
//    }];
    UIButton *logoBtn = [self createLeftBarButtonItemWithTarget:self action:@selector(saoMa) normalImage:THEME_IMAGE(@"QR_code") highlightedImage:THEME_IMAGE(@"QR_code")];
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"云猴全球购" forState:UIControlStateNormal];
    btn.titleLabel.font =APP_FONT(20);
    [btn addTarget:self action:@selector(logoImage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView =btn;
    [self createRightBarButtonItemWithTarget:self action:@selector(searchBarShouldBeginEditing:) normalImage:[UIImage imageNamed:@"TopSearch"] highlightedImage:nil];
    
    //    WS(ws)
    [[BBGConfiguration sharedInstance] bk_addObserverForKeyPath:@"theme" task:^(id target) {
        [logoBtn setImage:THEME_IMAGE(@"QR_code") forState:UIControlStateNormal];
        [logoBtn setImage:THEME_IMAGE(@"QR_code") forState:UIControlStateHighlighted];
    }];
}

- (void)logoImage {
#ifdef TEST
    NSRange range = [SERVER_URL rangeOfString:@"global.api.yunhou.com/yunhou-global-api"];
    if (range.location == NSNotFound) {
        BBAboutViewController_iPhone * aboutViewController = [[BBAboutViewController_iPhone alloc]initWithNibName:@"BBAboutViewController_iPhone" bundle:nil];
        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:aboutViewController];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
    }
#endif
}

- (UIButton *)createRightBarButtonItemWithTarget:(id)target action:(SEL)action normalImage:(UIImage *)nImage highlightedImage:(UIImage *)hImage {
    
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
    [lButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:lButton];
    self.navigationItem.rightBarButtonItem =  rightItem;
    
    return lButton;
    
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
    [lButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:lButton];
    self.navigationItem.leftBarButtonItem =  rightItem;
    
    return lButton;
}

- (void)saoMa {
    BOOL cameraCanUse = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (cameraCanUse) {
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending) {
            //判断IOS７下相机是否允许使用
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status != AVAuthorizationStatusAuthorized && status != AVAuthorizationStatusNotDetermined) {
                //不可使用
                [[BBGLoadingTips sharedInstance] showTips:@"请在设置->隐私里打开本应用对相机的使用权限"];
                return;
            }
        }
    }else{
        [[BBGLoadingTips sharedInstance] showTips:@"关闭了相机的使用权限或当前设备没有可用相机"];
        return;
    }
    BBGQrCodeViewController_iPhone *qrCodeViewController = [[BBGQrCodeViewController_iPhone alloc] init];
    BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:qrCodeViewController];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

#pragma mark- UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    BBGSearchViewController_iPhone *seachrController = [[BBGSearchViewController_iPhone alloc] init];
    seachrController.isFormFindCenterCtrl = YES;
    BBGNavigationController *praiseNav = [[BBGNavigationController alloc] initWithRootViewController:seachrController];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:praiseNav animated:YES completion:nil];
    
    return NO;
}


- (UINavigationController *)contentViewController{
    return self.navigationController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)isShowBackGroundView{
    
    return @"选中";
}


- (void)goWebController:(UITapGestureRecognizer *)sender{
    NSString *url = [BBGLaunchManager sharedInstance].URL_DOOR;
    BBGSpecialWebViewController_iPhone * webViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:url]];
    BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:webViewController];
    webViewController.title = [BBGLaunchManager sharedInstance].urlDoorTitle;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        
    }];
}


-(void)ShowOverfload{
    BOOL isShow =[BBGLaunchManager sharedInstance].urlDoorSwitch;
    if (isShow) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[BBGLaunchManager sharedInstance].urlDoorImage]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (cacheType ==SDImageCacheTypeNone) {
                [imageView setFadeInWithDefaultTime];
            }
        }];
        imageView.userInteractionEnabled=YES;
        [self.view addSubview:imageView];
        __weak MainCenterViewController_iPhoneViewController *weakSelf = self;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(10);
            make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-7);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goWebController:)];
        [imageView addGestureRecognizer:gesture];
        
    }
}

-(void)bmmsFinish:(NSNotification *)sender{
    [self ShowOverfload];
    if ([BBGTools checkStringIsBlank:[BBGLaunchManager sharedInstance].searchText]) {
        _searchBar.placeholder = @"购全球，上云猴";
    }else{
        _searchBar.placeholder = [BBGLaunchManager sharedInstance].searchText;
    }
}
@end
