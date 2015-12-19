//
//  BBGPayCompleteViewController_iPhoneViewController.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayCompleteViewController_iPhone.h"
#import <Common/Common.h>
#import "BBGJumpManager.h"
#import "BBGOrderDetailViewController_iPhone.h"
#import "BBGPaidShareRequest.h"
#import "BBGFirstShareResponse.h"
#import "BBGShareModel.h"
#import "BBGPaidShareRequest.h"
#import "BBGRedPaperView.h"
#import "BBGShareManager.h"
#import "BBGLaunchManager.h"
#import "BBGOrderListViewController_iPhone.h"
#import "UMSocialSnsService.h"
#import "BBGSpecialWebViewController_iPhone.h"

@interface BBGPayCompleteViewController_iPhone ()

//刮刮乐按钮，如果BMMS开启了刮刮乐就显示  HOOK按钮设置不可见 否则反过来
@property (strong, nonatomic) IBOutlet UIButton *guaguaLeBtn;
@property (strong, nonatomic) IBOutlet UIButton *hookBtn;

@property (strong, nonatomic) IBOutlet UIButton *searchOrderBtn;
@property (strong, nonatomic) IBOutlet UIButton *continueSaleBtn;
@property (strong, nonatomic) IBOutlet UIView *buttomView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSString *contact;
@property (nonatomic,strong) BBGPaidShareRequest *request ;
@property (nonatomic,strong) BBGShareModel *first ;
@property (nonatomic,strong) BBGRedPaperView *redView ;
@property (nonatomic,assign) BOOL status ;
@end

@implementation BBGPayCompleteViewController_iPhone

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated] ;
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            BBGFirstShareResponse *responseData = (BBGFirstShareResponse *)response ;
            _first = [[BBGShareModel alloc]init] ;
            _first = responseData.shareInfo ;
            if (_first.shareUrl!=nil) {
                [BBGRedPaperView showWithModel:_first statue:YES];
                
            }
        }
    }] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _status = [BBGLaunchManager sharedInstance].payBeniftSwitch ;
//    
//    if (_status == NO) {
//        [_searchOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal] ;
//    }else {
//        [_searchOrderBtn setTitle:@"领取红包" forState:UIControlStateNormal] ;
//
//    }
    
    if(![BBGLaunchManager sharedInstance].payActivitySwitch)
    {
        _guaguaLeBtn.hidden = YES;
    }else
    {
        _hookBtn.hidden = YES;
        
        
        if([BBGLaunchManager sharedInstance].payActivityImage != nil)
        {
            [_guaguaLeBtn sd_setBackgroundImageWithURL:[[NSURL alloc] initWithString:[BBGLaunchManager sharedInstance].payActivityImage] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
             {
                 if(image)
                 {
                     [_guaguaLeBtn setBackgroundImage:image forState:UIControlStateNormal];
                 }
             }];
        }else
        {
            _guaguaLeBtn.hidden = YES;
            _hookBtn.hidden = NO;
        }
    }
    
    CGRect frame = self.buttomView.frame;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, frame.origin.x + frame.size.height+20);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height/2 + 200, self.scrollView.frame.size.width, self.scrollView.frame.size.height/2)];
    view.backgroundColor = UIColorFromRGB(236, 235, 232);
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [self.scrollView addSubview:view];
    [self.scrollView sendSubviewToBack:view];
    
    
    [self.searchOrderBtn setBackgroundImage:[[UIImage imageNamed:@"查看订单按钮"] stretchImage] forState:UIControlStateNormal];
    [self.continueSaleBtn setBackgroundImage:[[UIImage imageNamed:@"继续购物按钮"] stretchImage] forState:UIControlStateNormal];
    
    self.contact = @"400-888-881";
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)dismissView:(id)sender {
    if (self.paySource == CHECKOUTORDER) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if(self.paySource == USERCENTERORDERDETAIL){
        NSArray * childViewControllers= self.navigationController.childViewControllers;
        if ([childViewControllers count]>0) {
            for (UIViewController *viewController in childViewControllers) {
                if ([viewController isKindOfClass:[BBGOrderDetailViewController_iPhone  class]]) {
                    [self.navigationController popToViewController:viewController animated:YES];
                    return;
                }
                
            }
            
        }
    }else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeToWaitSend" object:nil];
    }
}

- (IBAction)searchOrderAction:(id)sender {
    if (self.paySource==CHECKOUTORDER) {
        [self dismissViewControllerAnimated:YES completion:^{
            [[BBGJumpManager sharedInstance] managerJumpTo:BBGJumpOrderList];
        }];
    }else{
        [self dismissView:nil];
    }
}

- (void)shareClick {
    [BBGShareManager sharedInstance].isBenifit = YES ;

    [self shareToSNSWithImage:[UIImage imageNamed:@"sc_redpaperwx"]] ;
}

- (void)cancelClick {
    [_redView removeFromSuperview] ;
}

-(void)shareToSNSWithImage:(UIImage *)shareImage{
    NSString *shareUrl = _first.shareUrl ;
    NSString *shareText = _first.shareContent ;

    [[BBGShareManager sharedInstance] shareToSnsSheetView:self shareText:shareText shareImage:shareImage shareToSnsNames:nil shareUrl:shareUrl clickPlatformCallBack:^(NSString *snsName) {
        
        // 朋友圈分享的标题会覆盖内容
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = _first.shareTitle ;
        [UMSocialData defaultData].extConfig.wechatSessionData.title = _first.shareTitle ;
        [UMSocialData defaultData].extConfig.qqData.title = _first.shareTitle ;
        [UMSocialData defaultData].extConfig.qzoneData.title = _first.shareTitle ;
        
        [[BBGShareManager sharedInstance]shareToSnsSheetView:self shareText:shareText shareImage:shareImage shareToSnsNames:nil shareUrl:shareUrl callBack:^(BOOL sucessful, NSString *snsName) {
            if (sucessful) {
                [_redView removeFromSuperview] ;
            }
        }] ;
    }];
}

- (void)updateData:(LoadDataCallback)callback {
    [_request cancelRequest];
    if (!_request) {
        _request = [[BBGPaidShareRequest alloc] init];
    }
    _request.orderId = _orderId ;
    [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {

        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];

}

- (IBAction)continueSaleAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [BBGJumpManager sharedInstance].tabBarController.selectedIndex = 0;
}
- (IBAction)customerServiceAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.contact]]];
}

- (IBAction)guaguaLeAction:(id)sender
{
    NSString *url = [BBGLaunchManager sharedInstance].payActivityURL;
    if(url != nil  && ![url isEqualToString:@""])
    {
        BBGSpecialWebViewController_iPhone * webViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:url]];
//        webViewController.title = @"双11刮刮乐";
        webViewController.title = ([BBGLaunchManager sharedInstance].payActivityTitle == nil)?@"":[BBGLaunchManager sharedInstance].payActivityTitle;
        [self.navigationController pushViewController:webViewController animated:YES];
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
