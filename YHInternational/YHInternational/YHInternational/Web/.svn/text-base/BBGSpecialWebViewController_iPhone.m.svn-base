//
//  BBGSpecialWebViewController_iPhone.m
//  BuBuGao
//
//  Created by calvin on 14-9-9.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSpecialWebViewController_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGJumpManager.h"
#import "BBGShareManager.h"
#import "BBGLoginViewController_iPhone.h"
#import "BBGEvaluateViewController_iPhone.h"
#import "BBGAllCommentViewController_iPhone.h"
#import "BBGGoodsSeckillViewController_iPhone.h"
#import "Common.h"
#import "BBGNavigationController.h"
#import "BBGLaunchManager.h"
#import <AVFoundation/AVFoundation.h>
@interface BBGSpecialWebViewController_iPhone ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,AlbumPhotoSelectedDelage>
@property (nonatomic,strong) AlbumGroupViewController* albums;
@property (nonatomic,strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic,strong) NSMutableArray *willUploadImgArray;
@property (nonatomic,strong) NSMutableArray *picDataArray;
@property (nonatomic,strong) BBGUploadImgRequest *uploadImgRequest;

@property (nonatomic,strong) NSMutableDictionary * argDic;

@property (nonatomic,assign) NSInteger imgCount;

@property (nonatomic,strong) UIButton *shareBtn;

//分亭内容
@property (nonatomic,strong) UIImageView *shareImageView;
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *urlStr;
@property (nonatomic,strong) NSString *textStr;
@property (nonatomic,strong) NSString *imgStr;
@property (nonatomic,strong) BBGRongRequest * rongRequest;

@property (nonatomic,strong) UILabel *navTitleLabel;

@end

@implementation BBGSpecialWebViewController_iPhone

- (id)initWithConnectServer{
    self = [super init];
    if (self) {
        WS(ws)
        _rongRequest = [[BBGRongRequest alloc] init];
        if (![BBGSession sharedInstance].isLogin) {
            _rongRequest.memberId = [BBGLaunchManager sharedInstance].rongCloudId;
            _rongRequest.userName = @"用户";
        }else{
            _rongRequest.memberId = [BBGSession sharedInstance].userInfo.memberId;
            _rongRequest.userName = [BBGSession sharedInstance].userDetailInfo.nickName;
        }
        [_rongRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
            BBGRongResponse * response = (BBGRongResponse *)responseData;
            [BBGLaunchManager sharedInstance].rongToken = response.rongToken;
            [ws loadURL:[NSURL URLWithString:[BBGLaunchManager sharedInstance].contactURL]];
            
        } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
            [[BBGLoadingTips sharedInstance]showLoading:@"融云信息获取失败，请重试"];
        }];
        self.title = @"联系客服";
        self.hasBottomView = NO;
        self.hasShareBtn = NO;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)reLoadNavView{
    [super reLoadNavView];
    self.hasShareBtn = NO;
}


- (void)collectUserinfoWithFunctionName:(NSString *)functionName function:(NSString *)function callbackMethodKey:(NSString*)callbackMethodKey{
    if (!functionName) {
        return;
    }
    NSMutableDictionary *argumentsInfo = [[NSMutableDictionary alloc] init];
    [argumentsInfo setObject:[BBGSession sharedInstance].userInfo.accessToken ? [BBGSession sharedInstance].userInfo.accessToken : @"" forKey:@"token"];
    //[argumentsInfo setObject:[BBGSession sharedInstance].userInfo.memberId ? [BBGSession sharedInstance].userInfo.memberId : @"" forKey:@"userid"];
    [argumentsInfo setObject:[BBGSession sharedInstance].userDetailInfo.nickName ? [BBGSession sharedInstance].userDetailInfo.nickName : @"" forKey:@"nickname"];
    [argumentsInfo setObject:function ? function : @"" forKey:@"callbackMethod"];
    [argumentsInfo setObject:@"ios" forKey:@"system"];
    [argumentsInfo setObject:callbackMethodKey ? callbackMethodKey : @"" forKey:@"callbackMethodKey"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:argumentsInfo options:0 error:&error];
    if (!error) {
        NSString *arguments = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@');",functionName,arguments]];
    }
}

 - (BOOL)parseURLString:(NSString *)url {
    NSDictionary *info = [self pasingWithString:url];
    if (info) {
        NSString *service = [info objectForKey:@"functionname"];
        if (service) {
            NSLog(@"WEB 调用方法:%@",service);
            NSDictionary *args = info[@"args"];
            if ([service isEqualToString:@"goodsProductIndex"]||[service isEqualToString:@"vItem"]) {
                //普通商品跳转
                NSString *productID = args[@"prdouctid"];
                 if (productID) {
                    BBGGoodsDetailViewController_iPhone *goodsDetail = [[BBGGoodsDetailViewController_iPhone alloc] init];
                     goodsDetail.productId = productID;
                    [self.navigationController pushViewController:goodsDetail animated:YES] ;
                    return NO;
                }
            }else if ([service isEqualToString:@"goodsKillIndex"]) {
                //秒杀商品跳转
                NSString *productID = args[@"prdouctid"];
                NSString *activeID = args[@"activeid"];
                if (productID && activeID) {
                    BBGGoodsSeckillViewController_iPhone *goodsSeckillDetail = [[BBGGoodsSeckillViewController_iPhone alloc] init];
                    goodsSeckillDetail.productId = productID;
                    goodsSeckillDetail.activityId = activeID;
                    [self.navigationController pushViewController:goodsSeckillDetail animated:YES] ;
                    return NO;
                }
            }else if ([service isEqualToString:@"ready"]) {
                NSString *functionName = args[@"funName"];
                NSString *function = args[@"callbackMethod"];
                NSString *callbackMethodKey = args[@"callbackMethodKey"];
                [self collectUserinfoWithFunctionName:functionName function:function callbackMethodKey:callbackMethodKey];
//                if ([BBGSession sharedInstance].isLogin) {
//                    
//                }
                //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请您先登录帐号，是否登录？" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                //[alertView show];
            }else if([service isEqualToString:@"vLogin"]){//跳转登录
                NSString *functionName = args[@"funName"];
                NSString *function = args[@"callbackMethod"];
                NSString *callbackMethodKey = args[@"callbackMethodKey"];
                __weak BBGSpecialWebViewController_iPhone * weakSelf= self;
                [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                    if(successful){
                         [weakSelf collectUserinfoWithFunctionName:functionName function:function callbackMethodKey:callbackMethodKey];
                    } 
                }];
                return NO;
            }else if([service isEqualToString:@"vPLike"]){//跳转点赞
                NSString *goodsId =args[@"goodsid"];
                BBGEvaluateViewController_iPhone *evaluateVC = [[BBGEvaluateViewController_iPhone alloc] init];
                evaluateVC.googsId = goodsId ;
                
                [self.navigationController pushViewController:evaluateVC animated:YES] ;

                return NO;
            }else if([service isEqualToString:@"vComment"]){//跳转评论
                 NSString *goodsId =args[@"goodsid"];
                BBGAllCommentViewController_iPhone *allComment = [[BBGAllCommentViewController_iPhone alloc]init] ;
                allComment.goodsId = goodsId ;
                 [self.navigationController pushViewController:allComment animated:YES] ;
                
                return NO;
            }else if([service isEqualToString:@"xTitle"]){//设置标题
                NSString * htmlTitle = args[@"title"];
                self.title=htmlTitle;
                return NO;
            } else if([service isEqualToString:@"log"]){
                NSString *h5log = info[@"args"][@"message"];
                NSLog(@"h5log : %@",h5log);
            }else if ([service isEqualToString:@"vPreviewImage"]){
                //查看大图
                
                NSNumber * index = args[@"index"];
                
                NSArray * array = args[@"url"];
                NSMutableArray * urlArray = [NSMutableArray arrayWithArray:array];
                
                NSMutableArray * imgArray = [NSMutableArray array];
                
                for ( int i = 0;i < urlArray.count; i ++) {
                    NSString * urlStr = urlArray[i];
                    if (![BBGTools checkStringIsBlank:urlStr]) {
                        BBGPhotoModel * model = [BBGPhotoModel photoWithURL:[NSURL URLWithString:urlStr]];
                        [imgArray addObject:model];
                    }
                    
                }
                
                BBGPhotoBrowserViewController * browserViewController = [[BBGPhotoBrowserViewController alloc]init];
                
                browserViewController.imgArray = imgArray;
                browserViewController.currentImgIndex = index.intValue;
                
                [self presentViewController:browserViewController animated:YES completion:nil];
            }else if ([service isEqualToString:@"vUploadImage"]){
                //上传图片
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                if (!_argDic) {
                    _argDic = [NSMutableDictionary dictionary];
                }
                [dic setObject:args[@"type"] forKey:@"type"];
                [dic setObject:args[@"source"] forKey:@"source"];
                [_argDic setObject:dic forKey:@"content"];
                UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
                [sheet showInView:[UIApplication sharedApplication].keyWindow];
                
            }else if ([service isEqualToString:@"vReadyImage"]){
                //准备上传图片
                NSString *functionName = args[@"funName"];
                NSString *callbackMethodKey = args[@"callbackMethodKey"];
                if (!_argDic) {
                    _argDic = [NSMutableDictionary dictionary];
                }
                [_argDic setObject:functionName forKey:@"funName"];
                [_argDic setObject:callbackMethodKey forKey:@"callbackMethodKey"];
            }else if ([service isEqualToString:@"vSetupInfo"]){
                //初始化联系客服数据
                
                NSString *functionName = args[@"funName"];
                NSString *callbackMethodKey = args[@"callbackMethodKey"];
                
                [self setupServiceConnect:functionName callbackMethodKey:callbackMethodKey];
            }else if([service isEqual:@"vShareVisible"]){
                self.hasShareBtn = (BOOL)args;
                
                
            }else if ([service isEqualToString:@"vShare"]){
                self.titleStr = [args DICT_OBJ_FOR_K(@"title")];
                self.textStr = [args DICT_OBJ_FOR_K(@"text")];
                self.urlStr = [args DICT_OBJ_FOR_K(@"url")];
                self.imgStr = [args DICT_OBJ_FOR_K(@"image")];
            }else if ([service isEqualToString:@"vShow"]){
                [[BBGLoadingTips sharedInstance] hideTips];
                [[BBGLoadingTips sharedInstance] showLoading:nil];
            }else if ([service isEqualToString:@"vHide"]){
                [[BBGLoadingTips sharedInstance] hideTips];
            }else if([service isEqualToString:@"vShowTips"]){
                
                [[BBGLoadingTips sharedInstance] showTips:@""];
            }
        }
    }
    return YES;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setHidden:YES];
    [_shareBtn addTarget:self action:@selector(shareBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_shareBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn sizeToFit];
    _shareBtn.titleLabel.font = APP_FONT(15);
    UIBarButtonItem *shareBarBtn = [[UIBarButtonItem alloc] initWithCustomView:_shareBtn];
    self.navigationItem.rightBarButtonItem = shareBarBtn;
    
    _navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)];
    _navTitleLabel.font = APP_FONT_DEMI_LIGHT(18.0f);
    _navTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _navTitleLabel ;
}

- (void)setTitle:(NSString *)title{
    [_navTitleLabel setText:title];
}

- (void)shareBtnPressed:(UIButton*)btn{
    self.shareImageView = [[UIImageView alloc] init];
    WS(ws)
    [BBGShareManager sharedInstance].isBenifit = NO ;
    [[BBGLoadingTips sharedInstance] showLoading:@""];
    [self.shareImageView sd_setImageWithURL:[NSURL URLWithString:self.imgStr] placeholderImage:[UIImage imageNamed:@"Default.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [[BBGLoadingTips sharedInstance] hideTips];
        [ws shareToSNSWithImage:image];
    }];
}

-(void)shareToSNSWithImage:(UIImage *)shareImage{
    if ([BBGTools checkStringIsBlank:self.titleStr]) {
        self.titleStr = @"购全球，上云猴";
    }
    if ([BBGTools checkStringIsBlank:self.textStr]) {
        self.textStr = @"购全球，上云猴";
    }
    
    [[BBGShareManager sharedInstance] shareToSnsSheetView:self
                                                shareText:self.textStr
                                               shareImage:shareImage
                                          shareToSnsNames:nil
                                                 shareUrl:self.urlStr
                                    clickPlatformCallBack:^(NSString *snsName) {
        
        if ([snsName isEqual:@"sina"]) {
            [UMSocialData defaultData].shareText = [NSString stringWithFormat:@"%@ %@",self.textStr,self.url];
        }
        // 朋友圈分享的标题会覆盖内容
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.textStr;
        
        [UMSocialData defaultData].extConfig.wechatSessionData.title = self.titleStr;
        [UMSocialData defaultData].extConfig.qqData.title = self.titleStr;
        [UMSocialData defaultData].extConfig.qzoneData.title = self.titleStr;
        
    }];
}

- (void)setHasShareBtn:(BOOL)hasShareBtn{
    _hasShareBtn = hasShareBtn;
    [_shareBtn setHidden:!_hasShareBtn];
}

#pragma mark 初始化联系客服数据
- (void)setupServiceConnect:(NSString *)functionName callbackMethodKey:(NSString *)callbackMethodKey{
    NSMutableDictionary * setupDic = [NSMutableDictionary dictionary];
    
    NSMutableDictionary * contentDic = [NSMutableDictionary dictionary];
    
    
    [setupDic setObject:functionName forKey:@"funName"];
    [setupDic setObject:callbackMethodKey forKey:@"callbackMethodKey"];
    
    
    //用户id，用户昵称，用户头像
    if (![BBGSession sharedInstance].isLogin) {
        //        [contentDic setObject:@"lY/o0UmcsJ5bPZrKOfUhYd6i5AZjNgTSAbFr/X/Hg+MX4d/KcXYivdKHY2eVcZ9BZGhJjd9gjYJ6eDCeQRkN/Q==" forKey:@"token"];
        
        if ([BBGLaunchManager sharedInstance].rongToken) {
            [contentDic setObject:[BBGLaunchManager sharedInstance].rongToken forKey:@"token"];
        }
        if ([BBGLaunchManager sharedInstance].rongCloudId) {
            [contentDic setObject:@{@"id":[BBGLaunchManager sharedInstance].rongCloudId,@"name":@"用户",@"portraitUri":@"",@"guest":@"true"} forKey:@"user"];
        }
        
        
    }else{
        
        
        NSString * nickName = @"用户";
        NSString * headImg = @"";
        NSString * memberId = @"";
        
        if([BBGLaunchManager sharedInstance].rongToken){
            [contentDic setObject:[BBGLaunchManager sharedInstance].rongToken forKey:@"token"];
        }
        
        //        [contentDic setObject:@"lY/o0UmcsJ5bPZrKOfUhYd6i5AZjNgTSAbFr/X/Hg+MX4d/KcXYivdKHY2eVcZ9BZGhJjd9gjYJ6eDCeQRkN/Q==" forKey:@"token"];
        
        if ([BBGSession sharedInstance].userDetailInfo.nickName) {
            nickName = [BBGSession sharedInstance].userDetailInfo.nickName;
        }
        if ([BBGSession sharedInstance].userDetailInfo.headImg) {
            headImg = [BBGSession sharedInstance].userDetailInfo.headImg;
        }
        
        if ([BBGSession sharedInstance].userInfo.memberId) {
            memberId = [BBGSession sharedInstance].userInfo.memberId;
        }
        
        [contentDic setObject:@{@"id":memberId,@"name":nickName,@"portraitUri":headImg,@"guest":@"false"} forKey:@"user"];
    }
    
    //货品链接数组
    if (_contentArray) {
        NSMutableArray * contentArray = [NSMutableArray array];
        for(NSString * productId in _contentArray){
            
            
            [contentArray addObject:[NSString stringWithFormat:@"http://item.yunhou.com/%@.html",productId]];
        }
        [contentDic setObject:@{@"url":contentArray} forKey:@"product"];
    }else{
        [contentDic setObject:@{@"url":@""} forKey:@"product"];
    }
    
    //订单号
    if (!_orderId) {
        [contentDic setObject:@{@"id":@""} forKey:@"order"];
    }else{
        [contentDic setObject:@{@"id":[NSString stringWithFormat:@"%@",_orderId]} forKey:@"order"];
    }
    [setupDic setObject:contentDic forKey:@"content"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:setupDic options:0 error:&error];
    if (!error) {
        NSString *arguments = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@');",@"iOS.callHandler",arguments]];
    }
    
}

#pragma mark 图片地址
-(void)uploadImageaddress:(BBGUploadImgResponse *)imgResponse{
    if (!_argDic) {
        return;
    }
    NSMutableDictionary * dic = _argDic[@"content"];
    [dic setObject:imgResponse.imgModel.imgBase64Str forKey:@"content"];
    [dic setObject:imgResponse.imgModel.url forKey:@"url"];
    [_argDic removeObjectForKey:@"content"];
    [_argDic setObject:dic forKey:@"content"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_argDic options:0 error:&error];
    if (!error) {
        NSString *arguments = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@');",@"iOS.callHandler",arguments]];
    }
    
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
                [[BBGLoadingTips sharedInstance] showTips:@"请在设置->隐私里打开本应用对相机的使用权限"];
                return;
            }
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
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
        if (self.albums == nil) {
            self.albums = [[AlbumGroupViewController alloc] init];
            self.albums.selectedDelegate = self;
        }
        
        self.albums.maxSelectCount = 1;
        BBGNavigationController* navi = [[BBGNavigationController alloc] initWithRootViewController:self.albums];
        
        [self presentViewController:navi animated:YES completion:^{
            
        }];
    }
}

#pragma mark AlbumPhotoSelectedDelage
- (void)selectPhotos:(NSArray*)photoInfoArray{
    if (self.assetLibrary == nil) {
        self.assetLibrary = [[ALAssetsLibrary alloc] init];
    }
    
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i=0; i<[photoInfoArray COUNT]; i++) {
        NSDictionary *photoInfo = [photoInfoArray ARRAY_OBJ_AT(i)];
        ALAssetRepresentation *assetRep = [photoInfo DICT_OBJ_FOR_K(@"assetRep")];
        UIImage *img = [UIImage imageWithCGImage:[assetRep fullScreenImage]];
        
        UIImage* newImg = [img imageByScalingToSize:img.size];
        newImg = [newImg reSizeImage:CGSizeMake(600, 600)];
        
        [array addObject:newImg];
    }
    
    [self uploadAllPhoto:array];
}

- (void)uploadAllPhoto:(NSArray *)imgArray{
    __weak BBGSpecialWebViewController_iPhone *weakSelf = self;
    
    if ([imgArray count] > 0) {
        [[BBGLoadingTips sharedInstance] showLoading:@"正在上传..."];
        [self uploadAllImg:imgArray callBack:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                [[BBGLoadingTips sharedInstance] hideTips];
                BBGUploadImgResponse *uploadImgResponse = (BBGUploadImgResponse*)response;
                [weakSelf uploadImageaddress:uploadImgResponse];
            }else{
                [[BBGLoadingTips sharedInstance] showTips:@"上传失败，请重试"];
            }

        }];
    }
    
}

- (void)uploadAllImg:(NSArray*)imgArray callBack:(LoadDataCallback)callback{
    if (!self.uploadImgRequest) {
        self.uploadImgRequest = [[BBGUploadImgRequest alloc] init];
        
    }
    self.uploadImgRequest.isNotLogin = YES;
    self.uploadImgRequest.isUseBase64 = YES;
    _uploadImgRequest.willUploadImgArray = nil;
    _uploadImgRequest.willUploadImgArray = imgArray;
    [_uploadImgRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}

#pragma mark  UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //NSLog(@"imagePickerController info:%@",info);
    [picker dismissViewControllerAnimated:NO completion:^{
        
    }];
    UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //这步必须
    UIImage* newImg = [originImage imageByScalingToSize:originImage.size];
    newImg = [newImg reSizeImage:CGSizeMake(600, 600)];
    
    [self.willUploadImgArray removeAllObjects];
    if (!self.willUploadImgArray) {
        _willUploadImgArray = [NSMutableArray array];
    }
    [self.willUploadImgArray addObject:newImg];
    [self uploadAllPhoto:self.willUploadImgArray];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated: YES completion:^{
        
    }];
}

#pragma mark - UIAlertViewDelegate Method
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 1) {
//        [alertView dismissWithClickedButtonIndex:1 animated:NO];
//        [self performSelector:@selector(doLogin) withObject:nil afterDelay:0.5];
//    }else if (buttonIndex == 0){
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*#pragma mark -
- (BBGCollectionTemplateDisplayType)displayType {
    if ([self.identify isEqualToString:@"chb"]) {
        return BBGCollectionTemplateDisplayPresent;
    }else{
        return BBGCollectionTemplateDisplayPush;
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
