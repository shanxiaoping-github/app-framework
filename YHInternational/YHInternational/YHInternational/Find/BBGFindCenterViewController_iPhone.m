//
//  BBGFindCenterViewController_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFindCenterViewController_iPhone.h"
#import "BBGCountryViewController_iPhone.h"
#import "BBGCategoryViewController_iPhone.h"
#import "BBGQrCodeViewController_iPhone.h"
#import "BBGSearchViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "common.h"

@interface BBGFindCenterViewController_iPhone ()<UISearchBarDelegate>

@property (nonatomic,strong) BBGFindRequest *findRequest;
@property (nonatomic,strong) BBGFindResponse *findResponse;
@property (nonatomic,strong) NSMutableArray *countryArray;
@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) BBGSearchBar *searchBar;

@end

@implementation BBGFindCenterViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *logoBtn = [self createLeftBarButtonItemWithTarget:self action:@selector(logoImage) normalImage:THEME_IMAGE(@"logo") highlightedImage:THEME_IMAGE(@"logo")];
//    _searchBar = [[BBGSearchBar alloc] initWithFrame:CGRectMake(0, 0, 2000, 35)];
//    _searchBar.delegate = self;
//    if ([BBGTools checkStringIsBlank:[BBGLaunchManager sharedInstance].searchText]) {
//        _searchBar.placeholder = @"购全球，上云猴";
//    }else{
//        _searchBar.placeholder = [BBGLaunchManager sharedInstance].searchText;
//    }
//
//    if ([@"Root" isEqualToString:[BBGConfiguration sharedInstance].theme]) {
//        _searchBar.placeholderTextColor = UIColorFromHexadecimalRGB(0x735098);
//    }else{
//        _searchBar.placeholderTextColor = UIColorFromHexadecimalRGB(0xfc94c2);
//    }
//    
//    
//    _searchBar.searchBarBgImage = [THEME_IMAGE(@"SearchBarBg_red") stretchImage];
//    _searchBar.searchLeftViewImage = THEME_IMAGE(@"SearchIcon_red");
//    self.navigationItem.titleView = _searchBar;
//    UIButton *qrBtn = [self createRightBarButtonItemWithTarget:self action:@selector(saoMa) normalImage:THEME_IMAGE(@"QR_code") highlightedImage:nil];
//    
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
    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleTopMargin;
    
    [self loadCateGoryList];
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

- (void)loadCateGoryList{

    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    
    __weak BBGFindCenterViewController_iPhone *weakSelf = self;
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        
        [weakSelf.defaultView dismiss];
        if (sucessful) {
            [[BBGLoadingTips sharedInstance] hideTips];
            BBGFindResponse *findResponse = (BBGFindResponse *)response;
            _categoryArray = findResponse.findCategory.findCategoryArray;
            _countryArray = findResponse.findCountry.findCountryArray;
            if ([_categoryArray count]) {
                [weakSelf loadSubPageContentAtIndex:0];
            }
        }else{
            if (response) {
                if ([weakSelf.categoryArray count]==0) {
                    [weakSelf showDefaultViewWithStampImage:nil tips:response.errorMsg target:weakSelf actionTitle:@"刷新试试" action:@selector(loadCateGoryList)
                                         WithResponseResult:BBGResponseError offset:CGPointZero onView:weakSelf.view];
                }else{
                    
                    [[BBGLoadingTips sharedInstance] showTips:response.errorMsg];
                }
            }else{
                if ([weakSelf.categoryArray count]==0) {
                    [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf actionTitle:@"重新加载" action:@selector(loadCateGoryList)
                                         WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
                }
            }
        }
    }];

}

- (void)logoImage {

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

- (void)updateData:(LoadDataCallback)callback {
    
    [_findRequest cancelRequest];
    if (!_findRequest) {
        _findRequest = [[BBGFindRequest alloc] init];
    }
    [_findRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        callback(NO,nil);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (id)loadCustomDataWithMenu:(BBGMenuItem *)menu{
    if (menu.menuID.intValue == 222) {
        return _countryArray;
    }else if (menu.menuID.intValue == 111) {
        if (![_categoryArray count]) {
            return nil;
        }
        return _categoryArray;
    }
    return nil;
}

-(NSString *)isShowBackGroundView{
    
    return @"选中";
}

- (void)viewWillDisappear:(BOOL)animated{
    [_findRequest cancelRequest];
}


@end
