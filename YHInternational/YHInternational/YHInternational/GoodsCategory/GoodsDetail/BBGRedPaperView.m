//
//  BBGRedPaperView.m
//  YHInternational
//
//  Created by 彭腾 on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRedPaperView.h"
#import "UMSocial.h"
#import "BBGShareManager.h"
#import "BBGSessionManager.h"

@interface BBGRedPaperView () {
    NSString *URL;
    BBGShareModel *shareModel;
    BOOL stateBool;
}

@property (nonatomic, strong) UIView *bgView ;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *ad;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation BBGRedPaperView

+ (BBGRedPaperView *)sharedView
{
    static BBGRedPaperView *sharedView = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        UINib *nib = [UINib nibWithNibName:@"BBGRedPaperView"
                                    bundle:nil];
        NSArray *nibViews = [nib instantiateWithOwner:self
                                              options:0];
        
        sharedView = nibViews[0];
    });
    
    return sharedView;
}

- (void)sendShareUrl:(NSString *)shareUrl
                  ad:(NSString *)ad
              statue:(BOOL)note {
    self.ad.text = ad ;
    URL = shareUrl ;
    _contentView.layer.cornerRadius = 5 ;
    _contentView.clipsToBounds = YES ;
    self.titleLab.font = APP_FONT_DEMI_LIGHT(15.0f) ;
    if (note == NO) {
        self.label.hidden = YES ;
        self.titleLab.text = @"嫦娥送你新人红包" ;
    }else {
        self.label.hidden = NO ;
        self.titleLab.text = @"嫦娥送你支付红包" ;
    }
}

- (IBAction)cancel:(UIButton *)sender {
    if (self.button) {
        self.button();
    }
    [self removeFromSuperview] ;
    if (stateBool == NO) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"redPaperPost" object:shareModel];
    }
}

- (IBAction)share:(UIButton *)sender {
    if (self.shareBtn) {
        self.shareBtn();
    }
    [self shareClick];
}

- (void)handlerButtonAction:(CancelButton)block {
    self.button = block;
}

- (void)shareButtionAction:(ShareButton)block {
    self.shareBtn = block;
}

+ (void)showWithUrl:(NSString *)shareUrl
                 ad:(NSString *)ad
             statue:(BOOL)statue
               view:(UIView *)superview
            handler:(ShareButton)block {
    [self sharedView].shareBtn = block;
    [[self sharedView] showWithUrl:shareUrl ad:ad statue:statue view:superview];
}

- (void)showWithUrl:(NSString *)shareUrl
                 ad:(NSString *)ad
             statue:(BOOL)mark
               view:(UIView *)superview {
    self.ad.text = ad;
    URL = shareUrl;
    _contentView.layer.cornerRadius = 5;
    _contentView.clipsToBounds = YES;
    self.titleLab.font = APP_FONT_DEMI_LIGHT(15.0f) ;
    stateBool = mark;
    if (mark == NO) {
        self.label.hidden = YES;
        self.titleLab.text = @"全球购送你新人红包";
    }else {
        self.label.hidden = NO;
        self.titleLab.text = @"全球购送你支付红包";
    }
    
    if (superview==nil) {
        [self addToCurrentWindow];
    }else {
        [superview addSubview:self];
    }
}

- (void)addToCurrentWindow
{
    UIWindow *currentWindow = nil;
    
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            currentWindow = window;
            break;
        }
    }
    if (self.superview != currentWindow) {
        [self addToView:currentWindow];
    }
}

- (void)addToView:(UIView *)superview
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [self setCenter:CGPointMake(superview.frame.size.width / 2, superview.frame.size.height / 2)];
    self.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    [superview addSubview:self];
    [superview bringSubviewToFront:self];
}

+ (void)showWithModel:(BBGShareModel *)model
               statue:(BOOL)statue {
    [[self sharedView]showWithModel:model statue:statue];
}

- (void)showWithModel:(BBGShareModel *)model
               statue:(BOOL)statue {
    self.ad.text = model.ad;
    URL = model.shareUrl;
    shareModel = model;
    _contentView.layer.cornerRadius = 5;
    _contentView.clipsToBounds = YES;
    stateBool = statue;
    self.titleLab.font = APP_FONT_DEMI_LIGHT(15.0f) ;
    if (statue == NO) {
        self.label.hidden = YES;
        self.titleLab.text = @"全球购送你新人红包";
    }else {
        self.label.hidden = NO;
        self.titleLab.text = @"全球购送你支付红包";
    }
    [self addToCurrentWindow];
}

- (void)shareClick {
    [BBGShareManager sharedInstance].isBenifit = YES;
    [self removeFromSuperview];
    [self shareToSNSWithImage:[UIImage imageNamed:@"sc_redpaperwx"]] ;
}

- (void)shareToSNSWithImage:(UIImage *)shareImage{
    NSString *shareUrl = shareModel.shareUrl ;
    NSString *shareText = shareModel.shareContent ;
    [[BBGShareManager sharedInstance] shareToSnsSheetView:[BBGSessionManager sharedInstance].currentViewController shareText:shareText shareImage:shareImage shareToSnsNames:nil shareUrl:shareUrl clickPlatformCallBack:^(NSString *snsName) {
        
        // 朋友圈分享的标题会覆盖内容
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareModel.shareTitle ;
        [UMSocialData defaultData].extConfig.wechatSessionData.title = shareModel.shareTitle ;
        [UMSocialData defaultData].extConfig.qqData.title = shareModel.shareTitle ;
        [UMSocialData defaultData].extConfig.qzoneData.title = shareModel.shareTitle ;
        
        if (stateBool == NO) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"redPaperPost" object:shareModel];
        }
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
