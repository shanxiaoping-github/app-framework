//
//  BBGGoodsDetailViewController_iPhone.m
//  YHInternational
//
//  Created by 彭腾 on 15-5-5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGGoodsDetailHeaderCell.h"
#import "BBGGoodsTextCell.h"
#import "BBGGDEmptyCell.h"
#import "BBGGoodsPlaceCell.h"
#import "BBGGoodsTimeCell.h"
#import "BBGGoodsCommentCell.h"
#import "BBGGoodsPreferentialCell.h"
#import "AllCommentTextCell.h"
#import "AllCommentImageCell.h"
#import "AllReplyTextCell.h"
#import "AllReplyImageCell.h"
#import "BBGPraiseView.h"
#import "BBGPraiseMembs.h"
#import "BBGAllCommentViewController_iPhone.h"
#import "BBGAddPraiseRequest.h"
#import "BBGCancelPraiseRequest.h"
#import "BBGEvaluateViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGShareManager.h"
#import "BBGGoodsDetailImages.h"
#import "UIImage+Stretch.h"
#import "BBGGoodsSpecCell.h"
#import "BBGGoodsSpecValue.h"
#import "BBGGoodsSpecQuery.h"
#import "BBGGoodsDetailPushImage.h"
#import "BBGShoppingCartViewController_iPhone.h"
#import "BBGGoodsListViewController_iPhone.h"
#import "BBGCartNumModel.h"
#import "BBGPromotionActivities.h"
#import "BBGPushAnimator.h"
#import "BBGPopAnimator.h"
#import "BBGDetailSpecCell.h"
#import "BBGGoodsShopCell.h"
#import "BBGDetailGiftViewController_iPhone.h"
#import "BBGSpecialWebViewController_iPhone.h"
#import "BBGPhoneSeckillViewController_iPhone.h"
#import "BBGBeautyEffectViewController_iPhone.h"
#import "BBGSettlementViewController_iPhone.h"
#import "BBGCommentHeadCell.h"
#import "BBGCommentFootCell.h"
#import "BBGTableBottomCell.h"
#import "PTFlowLayout.h"
#import "BBGSpecHeader.h"
#import "BBGSpecFooter.h"
#import "BBGGDCountDownButton.h"
#import "BBGGDCountDownView.h"
#import "BBGGDPriceView.h"
#import "BBGGDCheckButton.h"
#import "BBGGDBuyButton.h"
#import "BBGGDSeckillView.h"
#import "BBGGoodsSeckillViewController_iPhone.h"
//#import "SobotViewController_iPhone.h"
@interface BBGGoodsDetailViewController_iPhone ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ImageCollectionViewCellDelegate,BBGAdvViewDataSource,BBGAdvViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PTFlowLayoutDelegate,BBGGDCountDownViewDelegate> {
    //是否展开
    BOOL isExpand;
    BOOL isUp;
    NSInteger cellHeight;
    
    UIImageView *_confirmImage;
    NSInteger sectionNum;
    NSMutableArray *specArr;
    UITapGestureRecognizer *tap;
    
    NSTimer *countDownTimer;
    NSInteger secondsCountDown;
    NSMutableString *specString;
    
    UIButton *returnTop;
    NSMutableArray *sectionArr;
    PTFlowLayout *flowLayout;
    /**
     *  规格值字典
     */
    NSMutableDictionary *specIdDic;
    /**
     *  规格名字典
     */
    NSMutableDictionary *specNameDic;
    /**
     *  tableHeaderView
     */
    UIView *headView;
}
@property (nonatomic, assign) BOOL isDisplay;
/**
 *  规格弹出视图控件
 */
@property (nonatomic, strong) UICollectionView *pushCollectionView;
@property (nonatomic, strong) UIImageView *specImage;
@property (nonatomic, strong) UILabel *pushTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *confirmBtn;
/**
 *  去结算按钮
 */
@property (nonatomic, strong) BBGGDCheckButton *checkButton;
/**
 *  买买买按钮
 */
@property (nonatomic, strong) BBGGDBuyButton *buyButton;
/**
 *  价格View
 */
@property (nonatomic, strong) BBGGDPriceView *priceView;
/**
 *  加入购物车倒计时按钮
 */
@property (nonatomic, strong) BBGGDCountDownButton *countDownButton;
/**
 *  买买买倒计时View
 */
@property (nonatomic, strong) BBGGDCountDownView *countDownView;
/**
 *  普通加入购物车按钮
 */
@property (nonatomic, strong) UIButton *shopBtn;
/**
 *  秒杀提示窗
 */
@property (nonatomic, strong) BBGGDSeckillView *seckillView;

@end

@implementation BBGGoodsDetailViewController_iPhone

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    secondsCountDown = 2;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - 倒计时5秒去掉进入商品详情动画
- (void)timeFireMethod{
    secondsCountDown--;
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"imageCompleted" object:nil];
    }
}

#pragma mark - 判断由哪个页面进入商品详情
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([fromVC isKindOfClass:[BBGGoodsListViewController_iPhone class]]) {
        [self viewDidDisappear:YES] ;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"imageCompleted" object:nil];
    }
    
    if (operation == UINavigationControllerOperationPush) {
        BBGPushAnimator * pushAnimator = [[BBGPushAnimator alloc] init];
        return pushAnimator;
    }
    
    if (operation == UINavigationControllerOperationPop) {
        BBGPopAnimator * animator = [[BBGPopAnimator alloc]init];
        return animator;
    }
    
    return nil;
}

#pragma mark - 刷新商品详情评论列表
- (void)getInfo:(NSNotification *)notification {
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    NSMutableString *conditions = [notification object];
    if (conditions!=nil) {
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                [weakSelf getSectionNum];
                [weakSelf.BBGGoodsDetail reloadData];
            }
        }];
    }
}

#pragma mark - 进入联系客服
- (void)getWeb {
    if (![BBGLaunchManager sharedInstance].isOpenContactURL) {
        [BBGTools callPhone:@"400-888-8881" alertTitle:@"当前在线客服系统暂不可用，请电话联系客服。"];
    }else{
        //        BBGNavigationController * nav = (BBGNavigationController *)self.navigationController;
        [self connectServer];
        
    }
    
}

#pragma mark - 初始化UI
- (void)initUI {
    /**
     *  初始化需要的数组或状态
     */
    [self getSectionNum];
    
    [self initSpecDic];
    
    self.userDetail = [BBGSession sharedInstance].userDetailInfo;
    self.userInfo = [BBGSession sharedInstance].userInfo;
    isExpand = NO;
    isUp = YES;
    cellHeight = 60;
    
    for (NSInteger i = 0; i < self.promotionActivitiesArr.count; i++) {
        BBGPromotionActivities *model = self.promotionActivitiesArr[i];
        if ([model.type isEqualToString:@"ump-goods-xsqg"]) {
            self.tips = model.tips;
        }
        if ([model.type isEqualToString:@"ump-goods-sjzx"]) {
            self.tips = model.tips;
        }
    }
    
    self.BBGGoodsDetail = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-124)] ;
    self.BBGGoodsDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.BBGGoodsDetail.delegate = self;
    self.BBGGoodsDetail.dataSource = self;
    self.BBGGoodsDetail.backgroundColor = [UIColor clearColor];
    [self.BBGGoodsDetail addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:@"tableviewY"];
    [self.view addSubview:self.BBGGoodsDetail];
    
    /**
     *  回到顶部按钮
     */
    returnTop = [UIButton buttonWithType:UIButtonTypeCustom];
    returnTop.hidden = YES;
    returnTop.frame = CGRectMake(IPHONE_WIDTH-50, IPHONE_HEIGHT-213, 40, 40);
    [returnTop setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [returnTop setBackgroundImage:[UIImage imageNamed:@"BackToTop"] forState:UIControlStateNormal];
    [returnTop addTarget:self action:@selector(returnTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnTop];
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH)];
    self.BBGGoodsDetail.tableHeaderView = headView;
    
    /**
     *  添加轮播图
     */
    [self initAdvView];
    
    /**
     *  底部视图
     */
    [self addBottomView];
    
    self.seckillView = [BBGGDSeckillView buttonWithType:UIButtonTypeCustom];
    self.seckillView.frame = CGRectMake(0, IPHONE_HEIGHT-164, IPHONE_WIDTH, 40);
    [self.seckillView addTarget:self action:@selector(goGoodsSeckill) forControlEvents:UIControlEventTouchUpInside];
    self.seckillView.seckillActity = self.basicInfo.seckillActity;
    //    self.seckillView.seckillActity = YES;
    [self.view addSubview:self.seckillView];
}

#pragma mark - 初始化规格值字典
- (void)initSpecDic {
    specString = [NSMutableString string];
    specIdDic = [NSMutableDictionary dictionary];
    specNameDic = [NSMutableDictionary dictionary];
    
    NSArray *array = [self.basicInfo.productSpecText componentsSeparatedByString:@";"];
    /**
     *  规格id字典初始化
     */
    if (self.basicInfo.productSpecText.length!=0) {
        for (NSInteger i = 0; i < self.goodsSpecsListArr.count; i++) {
            NSString *string = [NSString stringWithFormat:@"%@;",[array ARRAY_OBJ_AT(i)]];
            NSString *specKey = [NSString stringWithFormat:@"%ld",(long)i];
            [specIdDic setObject:string forKey:specKey];
        }
    }
    
    /**
     *  规格名称初始化
     */
    if (self.basicInfo.productSpecText.length != 0) {
        for (NSInteger i = 0; i < self.goodsSpecsListArr.count; i++) {
            BBGGoodsSpecQuery *query = [self.goodsSpecsListArr ARRAY_OBJ_AT(i)];
            NSString *specKey = [NSString stringWithFormat:@"%ld",(long)i];
            for (NSInteger j = 0; j < query.values.count; j++) {
                BBGGoodsSpecValue *value = [query.values ARRAY_OBJ_AT(j)];
                NSString *str = [specIdDic objectForKey:specKey];
                if ([str isEqualToString:[NSString stringWithFormat:@"%@;",value.text]]) {
                    NSString *string;
                    if (i==0) {
                        string = [NSString stringWithFormat:@"%@",value.name];
                    }else {
                        string = [NSString stringWithFormat:@",%@",value.name];
                    }
//                    if (self.basicInfo.goodsStatus==0) {
                    [specString appendString:string];
//                    }
                    NSString *specKey = [NSString stringWithFormat:@"%ld",(long)i];
                    [specNameDic setObject:string forKey:specKey];
                }
            }
        }
    }
}

#pragma mark - 轮播图初始化
- (void)initAdvView {
    /**
     轮播图
     */
    self.pictureView = [[BBGAdvView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH)];
    self.pictureView.dataSource = self;
    self.pictureView.delegate = self;
    self.pictureView.enableAutoPage = NO;
    self.pictureView.focusImage = [[UIImage imageNamed:@"goodsSelect"] stretchImage];
    self.pictureView.pageImage = [[UIImage imageNamed:@"goodsNoSelect"] stretchImage];
    [headView addSubview:self.pictureView];
}

#pragma mark - 添加普通商品底部视图
- (void)addBottomView {
    /**
     底部主视图
     */
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,  IPHONE_HEIGHT-124, IPHONE_WIDTH, 60)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    UIImageView *_separateLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _bottomView.frame.size.width, 1)];
    [_separateLine setImage:[UIImage imageNamed:@"separateLine"]];
    [self.bottomView addSubview:_separateLine];
    
    CGFloat checkWidth = 90.0f/375.0f*IPHONE_WIDTH;
    CGFloat shopWidth = 115.0f/375.0f*IPHONE_WIDTH;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *startDate = [formatter dateFromString:self.basicInfo.activityStartDate];
    NSDate *endDate = [formatter dateFromString:self.basicInfo.activityEndDate];
    NSDate *sysDate = [formatter dateFromString:self.basicInfo.sysDate];
    NSTimeInterval start = [startDate timeIntervalSince1970];
    NSTimeInterval end = [endDate timeIntervalSince1970];
    NSTimeInterval sys = [sysDate timeIntervalSince1970];
    
    self.priceView = [[BBGGDPriceView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, IPHONE_WIDTH-40-checkWidth-shopWidth, 40.0f)];
    if (self.basicInfo.crossedPrice!=0) {
        self.priceView.crossPrice = [NSString stringWithFormat:@"%f",self.basicInfo.crossedPrice];
    }
    self.priceView.unCrossPrice = [NSString stringWithFormat:@"%f",self.basicInfo.unCrossedPrice];
    [self.bottomView addSubview:self.priceView];
    
    if (self.basicInfo.goodsStatus == 0) {
        if (self.basicInfo.productType == 0) {
            /**
             去结算按钮UI
             */
            self.checkButton = [BBGGDCheckButton buttonWithType:UIButtonTypeCustom];
            self.checkButton.frame = CGRectMake(IPHONE_WIDTH-10.0f-checkWidth, 8, checkWidth, 44.0f);
            self.checkButton.totalType = self.cartNum.totalType;
            self.checkButton.isLogin = [BBGSession sharedInstance].isLogin;
            [self.checkButton addTarget:self action:@selector(goCheck) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:self.checkButton];
            /**
             加入购物车倒计时按钮UI
             */
            if (start!=0||end!=0) {
                self.countDownButton = [BBGGDCountDownButton buttonWithType:UIButtonTypeCustom];
                self.countDownButton.frame = CGRectMake(self.checkButton.frame.origin.x-10.0f-shopWidth, 8, shopWidth, 44.0f);
                self.countDownButton.tag = 12;
                self.countDownButton.enabled = YES;
                [self.countDownButton addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
                if (sys <= start) {
                    self.countDownButton.startTime = sys;
                    self.countDownButton.endTime = start;
                    self.countDownButton.buyButtonTips = self.basicInfo.buyButtonTips;
                    self.countDownButton.isBegin = YES;
                }else {
                    self.countDownButton.startTime = sys;
                    self.countDownButton.endTime = end;
                    self.countDownButton.buyButtonTips = self.basicInfo.buyButtonTips;
                    self.countDownButton.isBegin = YES;
                }
                [self.bottomView addSubview:self.countDownButton];
            }else {
                self.shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                self.shopBtn.frame = CGRectMake(self.checkButton.frame.origin.x-10.0f-shopWidth, 8, shopWidth, 44.0f);
                self.shopBtn.layer.cornerRadius = 4.0f;
                self.shopBtn.layer.borderWidth = 1.0f;
                self.shopBtn.layer.borderColor = [UICOLOR_FONT_IMPORTANT_RED CGColor];
                self.shopBtn.clipsToBounds = YES;
                self.shopBtn.tag = 12;
                self.shopBtn.enabled = YES;
                [self.shopBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
                [self.shopBtn setTitle:self.basicInfo.buyButtonTips forState:UIControlStateNormal];
                self.shopBtn.titleLabel.font = APP_FONT(14.0f);
                [self.shopBtn addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
                [self.bottomView addSubview:self.shopBtn];
            }
        }else {
            /**
             *  买买买按钮UI
             */
            self.buyButton = [BBGGDBuyButton buttonWithType:UIButtonTypeCustom];
            self.buyButton.frame = CGRectMake(IPHONE_WIDTH-10.0f-checkWidth, 8, checkWidth, 44.0f);
            self.buyButton.tag = 17;
            [self.buyButton addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
            if ((sys>=start&&sys<end)||self.basicInfo.activityEndDate==nil) {
                self.buyButton.status = 0;
                self.buyButton.enabled = YES;
            }else if (sys<start) {
                self.buyButton.status = 1;
                self.buyButton.enabled = NO;
            }else {
                self.buyButton.status = 2;
                self.buyButton.enabled = NO;
            }
            
            [self.bottomView addSubview:self.buyButton];
            /**
             *  买买买倒计时View
             */
            if (start!=0||end!=0) {
                self.countDownView = [[BBGGDCountDownView alloc]initWithFrame:CGRectMake(self.buyButton.frame.origin.x-10.0f-shopWidth, 8, shopWidth, 44.0f)];
                self.countDownView.startTime = start;
                self.countDownView.endTime = end;
                self.countDownView.isBegin = YES;
                self.countDownView.delegate = self;
                [self.bottomView addSubview:self.countDownView];
            }
        }
    }else {
        /**
         去结算按钮UI
         */
        self.checkButton = [BBGGDCheckButton buttonWithType:UIButtonTypeCustom];
        self.checkButton.frame = CGRectMake(IPHONE_WIDTH-10.0f-checkWidth, 8, checkWidth, 44.0f);
        self.checkButton.totalType = self.cartNum.totalType;
        self.checkButton.isLogin = [BBGSession sharedInstance].isLogin;
        [self.checkButton addTarget:self action:@selector(goCheck) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.checkButton];
        
        /**
         加入购物车按钮UI
         */
        self.shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shopBtn.frame = CGRectMake(self.checkButton.frame.origin.x-10.0f-shopWidth, 8, shopWidth, 44.0f);
        self.shopBtn.layer.cornerRadius = 4.0f;
        self.shopBtn.layer.borderWidth = 1.0f;
        self.shopBtn.clipsToBounds = YES;
        self.shopBtn.tag = 12;
        [self.shopBtn addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
        self.shopBtn.layer.borderColor = [UIColorFromHexadecimalRGB(0xfaa9bf) CGColor];
        [self.shopBtn setTitleColor:UIColorFromHexadecimalRGB(0xfaa9bf) forState:UIControlStateNormal];
        self.shopBtn.enabled = NO;
        [self.shopBtn setTitle:self.basicInfo.buyButtonTips forState:UIControlStateNormal];
        self.shopBtn.titleLabel.font = APP_FONT(14.0f);
        [self.bottomView addSubview:self.shopBtn];
    }
}

#pragma mark - 多规格点击底部视图刷新
- (void)addSpecBottomView {
    /**
     底部主视图
     */
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,  IPHONE_HEIGHT-124, IPHONE_WIDTH, 60)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    UIImageView *_separateLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _bottomView.frame.size.width, 1)];
    [_separateLine setImage:[UIImage imageNamed:@"separateLine"]];
    [_bottomView addSubview:_separateLine];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *startDate = [formatter dateFromString:self.basicInfo.activityStartDate];
    NSDate *endDate = [formatter dateFromString:self.basicInfo.activityEndDate];
    NSTimeInterval start = [startDate timeIntervalSince1970];
    NSTimeInterval end = [endDate timeIntervalSince1970];
    
    CGFloat checkWidth = 90.0f/375.0f*IPHONE_WIDTH;
    CGFloat shopWidth = 115.0f/375.0f*IPHONE_WIDTH;
    
    self.priceView = [[BBGGDPriceView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, IPHONE_WIDTH-40-checkWidth-shopWidth, 40.0f)];
    if (self.basicInfo.crossedPrice!=0) {
        self.priceView.crossPrice = [NSString stringWithFormat:@"%f",self.basicInfo.crossedPrice];
    }
    self.priceView.unCrossPrice = [NSString stringWithFormat:@"%f",self.basicInfo.unCrossedPrice];
    [self.bottomView addSubview:self.priceView];
    
    if (self.specInfo.productType == 0) {
        /**
         去结算按钮UI
         */
        self.checkButton = [BBGGDCheckButton buttonWithType:UIButtonTypeCustom];
        self.checkButton.frame = CGRectMake(IPHONE_WIDTH-10.0f-checkWidth, 8, checkWidth, 44.0f);
        self.checkButton.totalType = self.cartNum.totalType;
        self.checkButton.isLogin = [BBGSession sharedInstance].isLogin;
        [self.checkButton addTarget:self action:@selector(goCheck) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.checkButton];
        
        self.shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shopBtn.frame = CGRectMake(self.checkButton.frame.origin.x-10.0f-shopWidth, 8, shopWidth, 44.0f);
        self.shopBtn.layer.cornerRadius = 4.0f;
        self.shopBtn.layer.borderWidth = 1.0f;
        self.shopBtn.layer.borderColor = [UICOLOR_FONT_IMPORTANT_RED CGColor];
        self.shopBtn.clipsToBounds = YES;
        self.shopBtn.tag = 12;
        self.shopBtn.enabled = YES;
        [self.shopBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
        [self.shopBtn setTitle:self.basicInfo.buyButtonTips forState:UIControlStateNormal];
        self.shopBtn.titleLabel.font = APP_FONT(14.0f);
        [self.shopBtn addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.shopBtn];
    }else {
        /**
         *  买买买按钮UI
         */
        self.buyButton = [BBGGDBuyButton buttonWithType:UIButtonTypeCustom];
        self.buyButton.frame = CGRectMake(IPHONE_WIDTH-10.0f-checkWidth, 8, checkWidth, 44.0f);
        self.buyButton.tag = 17;
        [self.buyButton addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
        self.buyButton.status = 0;
        self.buyButton.enabled = YES;
        
        [self.bottomView addSubview:self.buyButton];
        /**
         *  买买买倒计时View
         */
        if (start!=0||end!=0) {
            self.countDownView = [[BBGGDCountDownView alloc]initWithFrame:CGRectMake(self.buyButton.frame.origin.x-10.0f-shopWidth, 8, shopWidth, 44.0f)];
            self.countDownView.startTime = start;
            self.countDownView.endTime = end;
            self.countDownView.isBegin = YES;
            self.countDownView.delegate = self;
            [self.bottomView addSubview:self.countDownView];
        }
    }
}

#pragma mark - 去商品秒杀页面
- (void)goGoodsSeckill {
    BBGGoodsSeckillViewController_iPhone *goodsSeckillVC = [[BBGGoodsSeckillViewController_iPhone alloc]init];
    goodsSeckillVC.productId = self.basicInfo.productId;
    goodsSeckillVC.activityId = self.basicInfo.actityId;
    [self.navigationController pushViewController:goodsSeckillVC animated:YES];
}

#pragma mark - BBGGDCountDownViewDelegate
- (void)countDownFinish {
    self.buyButton.status = 0;
    self.buyButton.enabled = YES;
}

#pragma mark - 获取显示的section数
- (void)getSectionNum {
    sectionArr = [NSMutableArray array];
    NSDictionary *dic0 = @{@"Cell": @"BBGGoodsDetailHeaderCell"};
    NSDictionary *dic1 = @{@"Cell": @"BBGGoodsShopCell"};
    NSDictionary *dic2 = @{@"Cell": @"BBGGoodsPlaceCell"};
    NSDictionary *dic3 = @{@"Cell": @"BBGTableBottomCell"};
    
    [sectionArr addObject:dic0];
    [sectionArr addObject:dic1];
    [sectionArr addObject:dic2];
    [sectionArr addObject:dic3];
    
    if (self.promotionActivitiesArr.count!=0) {
        NSDictionary *dic = @{@"Cell": @"BBGGoodsPreferentialCell"};
        [sectionArr ARRAY_INSERT_OBJ_AT(dic,1)];
    }
    if (self.basicInfo.goodsExplain.length!=0) {
        NSDictionary *dic = @{@"Cell": @"BBGGoodsTextCell"};
        if ([[[sectionArr  ARRAY_OBJ_AT(1)]DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsPreferentialCell"]) {
            [sectionArr ARRAY_INSERT_OBJ_AT(dic,2)];
        }else {
            [sectionArr ARRAY_INSERT_OBJ_AT(dic,1)];
        }
    }
    if (self.goodsSpecsListArr.count!=0) {
        NSDictionary *dic = @{@"Cell": @"BBGDetailSpecCell"};
        if ([[[sectionArr  ARRAY_OBJ_AT(1)]DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsPreferentialCell"]) {
            if ([[[sectionArr ARRAY_OBJ_AT(2)]DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsTextCell"]) {
                [sectionArr ARRAY_INSERT_OBJ_AT(dic,3)];
            }else {
                [sectionArr ARRAY_INSERT_OBJ_AT(dic,2)];
            }
        }else {
            if ([[[sectionArr ARRAY_OBJ_AT(1)]DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsTextCell"]) {
                [sectionArr ARRAY_INSERT_OBJ_AT(dic,2)];
            }else {
                [sectionArr ARRAY_INSERT_OBJ_AT(dic,1)];
            }
        }
    }
    
    if (self.goodsTipArr.count!=0) {
        NSDictionary *dic = @{@"Cell": @"BBGGoodsTimeCell"};
        [sectionArr ARRAY_INSERT_OBJ_AT(dic,sectionArr.count-1)];
    }
    
    if (self.praiseMembsArr.count!=0) {
        NSDictionary *dic = @{@"Cell": @"BBGGoodsCommentCell"};
        [sectionArr ARRAY_INSERT_OBJ_AT(dic,sectionArr.count-1)];
        self.isDisplay = YES;
    }else {
        self.isDisplay = NO;
    }
    
    if (self.commentListArr.count!=0) {
        NSDictionary *dic5 = @{@"Cell": @"BBGCommentHeadCell"};
        NSDictionary *dic6 = @{@"Cell": @"AllCommentTextCell"};
        NSDictionary *dic7 = @{@"Cell": @"BBGCommentFootCell"};
        [sectionArr ARRAY_INSERT_OBJ_AT(dic5,sectionArr.count-1)];
        [sectionArr ARRAY_INSERT_OBJ_AT(dic6,sectionArr.count-1)];
        [sectionArr ARRAY_INSERT_OBJ_AT(dic7,sectionArr.count-1)];
    }
}

#pragma mark - 返回顶部点击事件
- (void)returnTop {
    [_webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - 点赞按钮点击事件
- (void)praise {
    _userDetail = [BBGSession sharedInstance].userDetailInfo;
    _userInfo = [BBGSession sharedInstance].userInfo;
    
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    
    if ([BBGSession sharedInstance].isLogin) {
        if (self.basicInfo.isPraise == NO) {
            [self addPraiseRequest:^(BOOL sucessful, BBGResponse *response) {
                if (sucessful) {
                    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
                    
                    BBGPraiseMembs *bbgPraiseMembs = [[BBGPraiseMembs alloc]init];
                    bbgPraiseMembs.productId = weakSelf.basicInfo.productId;
                    bbgPraiseMembs.memberHeadUrl = weakSelf.userDetail.headImg;
                    bbgPraiseMembs.memberId = weakSelf.userInfo.memberId;
                    bbgPraiseMembs.memberName = weakSelf.userDetail.nickName;
                    [weakSelf.praiseMembsArr ARRAY_INSERT_OBJ_AT(bbgPraiseMembs, 0)];
                    NSNumber *num = [NSNumber numberWithBool:weakSelf.basicInfo.isPraise];
                    NSDictionary *dic = @{@"Praise": bbgPraiseMembs,@"isPraise":num};
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"praise" object:dic];
                    weakSelf.basicInfo.isPraise = YES;
                    weakSelf.basicInfo.praiseCount += 1;
                    if (weakSelf.praiseMembsArr.count<2) {
                        [weakSelf getSectionNum];
                        weakSelf.isDisplay = NO;
                        [weakSelf.BBGGoodsDetail reloadData];
                    }else {
                        [weakSelf.BBGGoodsDetail reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }];
            return;
        }
        if (self.basicInfo.isPraise == YES) {
            [self cancelPraiseRequest:^(BOOL sucessful, BBGResponse *response) {
                if (sucessful) {
                    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
                    
                    for (NSInteger i = 0; i < weakSelf.praiseMembsArr.count; i++) {
                        BBGPraiseMembs *bbgPraiseMembs = [[BBGPraiseMembs alloc]init];
                        bbgPraiseMembs = weakSelf.praiseMembsArr[i];
                        if ([bbgPraiseMembs.memberId integerValue]==[weakSelf.userInfo.memberId integerValue]) {
                            [weakSelf.praiseMembsArr ARRAY_REMOVEOBJ_AT(i)];
                            NSNumber *num = [NSNumber numberWithBool:weakSelf.basicInfo.isPraise];
                            NSDictionary *dic = @{@"Praise": bbgPraiseMembs,@"isPraise":num};
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"praise" object:dic];
                        }
                    }
                    weakSelf.basicInfo.isPraise = NO;
                    weakSelf.basicInfo.praiseCount -= 1;
                    if (weakSelf.praiseMembsArr.count==0) {
                        [weakSelf getSectionNum];
                        weakSelf.isDisplay = YES;
                        [weakSelf.BBGGoodsDetail reloadData];
                    }else {
                        [weakSelf.BBGGoodsDetail reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }];
            return;
        }
        
    }else {
        [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
            if (successful) {
                [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        if (weakSelf.basicInfo.isPraise == YES) {
                            [weakSelf.BBGGoodsDetail reloadData];
                        }
                    }
                }];
                
            }
        }];
    }
}

#pragma mark - 评论按钮点击事件
- (void)comment {
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    if ([BBGSession sharedInstance].isLogin) {
        BBGEvaluateViewController_iPhone *evaluateVC = [[BBGEvaluateViewController_iPhone alloc] init];
        evaluateVC.googsId = self.basicInfo.goodsId;
        evaluateVC.goodsImageUrl = self.basicInfo.goodsImageUrl;
        evaluateVC.goodsName = self.basicInfo.goodsName;
        
        evaluateVC.title = @"评论晒单";
        [self.navigationController pushViewController:evaluateVC animated:YES];
    }else {
        [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
            if (successful) {
                BBGEvaluateViewController_iPhone *evaluateVC = [[BBGEvaluateViewController_iPhone alloc] init];
                evaluateVC.googsId = self.basicInfo.goodsId;
                evaluateVC.goodsImageUrl = self.basicInfo.goodsImageUrl;
                evaluateVC.goodsName = self.basicInfo.goodsName;
                
                evaluateVC.title = @"评论晒单";
                [weakSelf.navigationController pushViewController:evaluateVC animated:YES];
            }
        }];
    }
}

#pragma mark - 分享按钮点击事件
- (void)share {
    NSURL *imageUrl = [NSURL URLWithString:self.basicInfo.goodsImageUrl];
    if(imageUrl){
        self.shareImageView = [[UIImageView alloc] init];
        __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
        [BBGShareManager sharedInstance].isBenifit = NO;
        [self.shareImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"Default.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [weakSelf shareToSNSWithImage:image];
            
        }];
    }else{
        [BBGShareManager sharedInstance].isBenifit = NO;
        [self shareToSNSWithImage:[UIImage imageNamed:@"Default.png"]];
    }
}

#pragma mark - 全部评论
- (void)allComment {
    BBGAllCommentViewController_iPhone *allComment = [[BBGAllCommentViewController_iPhone alloc]init];
    allComment.goodsId = self.basicInfo.goodsId;
    allComment.title = @"全部评论";
    [self.navigationController pushViewController:allComment animated:YES];
}

#pragma mark - 去结算按钮点击事件
- (void)goCheck {
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    if ([BBGSession sharedInstance].isLogin) {
        BBGShoppingCartViewController_iPhone *shopCartVC = [[BBGShoppingCartViewController_iPhone alloc]init];
        [self.navigationController pushViewController:shopCartVC animated:YES];
    }else {
        [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
            if (successful) {
                [weakSelf cartNumRequest:^(BOOL sucessful, BBGResponse *response) {
                    if (successful) {
                        weakSelf.checkButton.totalType = weakSelf.cartNum.totalType;
                        weakSelf.checkButton.isLogin = [BBGSession sharedInstance].isLogin;
                    }
                }];
            }
        }];
    }
}

#pragma mark - 货品规格弹出视图
- (void)pushView:(UIButton *)sender {
    
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    
    if (self.goodsSpecsListArr.count!=0) {
        /**
         规格弹窗黑色透明背景
         */
        _pushBgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, IPHONE_WIDTH,IPHONE_HEIGHT)];
        _pushBgView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4];
        
        [self.navigationController.view addSubview:_pushBgView];
        
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(press:)];
        [_pushBgView addGestureRecognizer:tap];
        
        /**
         规格弹窗主视图
         */
        _pushMainView = [[UIView alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH,0)];
        _pushMainView.backgroundColor = UICOLOR_BACKGROUND_GRAYWHITE;
        [_pushBgView addSubview:_pushMainView];
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_pushMainView cache:NO];
        _pushMainView.frame= CGRectMake(0, IPHONE_HEIGHT/3+20, IPHONE_WIDTH, IPHONE_HEIGHT-IPHONE_HEIGHT/3-20);
        [UIView commitAnimations];
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 94)];
        [_pushMainView addSubview:topView];
        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, topView.frame.size.height-0.5f, IPHONE_WIDTH, 0.5f);
        bottomBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xcccccc) CGColor];
        [topView.layer addSublayer:bottomBorder];
        
        /**
         商品视图
         */
        WS(weakSelf);
        _specImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 74, 74)];
        _specImage.contentMode = UIViewContentModeScaleAspectFit;
        [_specImage sd_setImageWithURL:[NSURL URLWithString:self.basicInfo.productImageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (cacheType ==SDImageCacheTypeNone) {
                [weakSelf.specImage setFadeInWithDefaultTime];
            }
        }];
        [topView addSubview:_specImage];
        
        /**
         商品标题
         */
        _pushTitleLabel = [[UILabel alloc]init];
        _pushTitleLabel.numberOfLines = 0;
        _pushTitleLabel.textColor = UICOLOR_FONT_IMPORTANT_BLACK;
        _pushTitleLabel.font = APP_FONT(14.0f);
        _pushTitleLabel.text = self.basicInfo.productName;
        CGSize size = [self.basicInfo.productName
                       sizeWithStringFont:APP_FONT(14.0f) constrainedToSize:CGSizeMake(IPHONE_WIDTH-30-74, 10000)];
        if (size.height > 42.0f) {
            size.height = 42.0f;
        }
        _pushTitleLabel.frame = CGRectMake(94, 10, IPHONE_WIDTH-30-74, size.height);
        [topView addSubview:_pushTitleLabel];
        
        /**
         价格
         */
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(94, topView.frame.size.height-20.0f, 0, 0)];
        _priceLabel.numberOfLines = 0;
        _priceLabel.textColor = UICOLOR_FONT_IMPORTANT_RED;
        _priceLabel.font = APP_FONT_DEMI_LIGHT(14.0f);
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.basicInfo.unCrossedPrice/100];
        [_priceLabel sizeToFit];
        [topView addSubview:_priceLabel];
        
        /**
         规格视图
         */
        flowLayout = [[PTFlowLayout alloc]initWithSectionNum:self.goodsSpecsListArr.count];
        flowLayout.delegate = self;
        _pushCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topView.frame.size.height, IPHONE_WIDTH, _pushMainView.frame.size.height-topView.frame.size.height-58) collectionViewLayout:flowLayout];
        _pushCollectionView.backgroundColor = UICOLOR_BACKGROUND_GRAYWHITE;
        _pushCollectionView.alpha = 0.8;
        _pushCollectionView.delegate = self;
        _pushCollectionView.dataSource = self;
        _pushCollectionView.bounces = NO;
        [_pushMainView addSubview:_pushCollectionView];
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _pushCollectionView.frame.size.height+_pushCollectionView.frame.origin.y, IPHONE_WIDTH, 58)];
        [_pushMainView addSubview:bottomView];
        
        CALayer *topBorder = [CALayer layer];
        topBorder.frame = CGRectMake(0.0f, 0.0f, IPHONE_WIDTH, 0.5f);
        topBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xcccccc) CGColor];
        [bottomView.layer addSublayer:topBorder];
        
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmBtn.frame = CGRectMake((IPHONE_WIDTH-113)/2, _pushCollectionView.frame.size.height+_pushCollectionView.frame.origin.y+7, 113, 44);
        self.confirmBtn.layer.cornerRadius = 4.0f;
        self.confirmBtn.layer.borderWidth = 1.0f;
        if (self.basicInfo.goodsStatus==0) {
            self.confirmBtn.enabled = YES;
            self.confirmBtn.backgroundColor = UICOLOR_FONT_IMPORTANT_RED;
            self.confirmBtn.layer.borderColor = [UICOLOR_FONT_IMPORTANT_RED CGColor];
            [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else {
            self.confirmBtn.layer.borderColor = [UIColorFromHexadecimalRGB(0xfaa9bf) CGColor];
            [self.confirmBtn setTitleColor:UIColorFromHexadecimalRGB(0xfaa9bf) forState:UIControlStateNormal];
            self.confirmBtn.enabled = NO;
            self.confirmBtn.backgroundColor = [UIColor whiteColor];
        }
        self.confirmBtn.clipsToBounds = YES;
        [self.confirmBtn setTitle:self.basicInfo.buyButtonTips forState:UIControlStateNormal];
        
        if (self.basicInfo.productType==0) {
            [_confirmBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        }else {
            [_confirmBtn setTitle:@"买买买" forState:UIControlStateNormal];
        }
        
        [_confirmBtn addTarget:self action:@selector(quitClick:) forControlEvents:UIControlEventTouchUpInside];
        if ((sender.tag == 17)||(sender.tag == 18)) {
            _confirmBtn.tag = 1002;
        }else {
            _confirmBtn.tag = 1000;
        }
        _confirmBtn.titleLabel.textColor = UICOLOR_BACKGROUND_GRAYWHITE;
        _confirmBtn.titleLabel.font = APP_FONT(16.0f);
        [_pushMainView addSubview:_confirmBtn];
    }else {
        if ((sender.tag == 17)||(sender.tag == 18)) {
            if ([BBGSession sharedInstance].isLogin) {
                [self cartDirectRequest:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        BBGSettlementViewController_iPhone *vc = [[BBGSettlementViewController_iPhone alloc]init];
                        vc.buyType = BBGBuyTypeDirect;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    }
                }];
            }else {
                [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                    if (successful) {
                        [weakSelf cartDirectRequest:^(BOOL sucessful, BBGResponse *response) {
                            if (sucessful) {
                                BBGSettlementViewController_iPhone *vc = [[BBGSettlementViewController_iPhone alloc]init];
                                vc.buyType = BBGBuyTypeDirect;
                                [weakSelf.navigationController pushViewController:vc animated:YES];
                            }
                        }];
                    }
                }];
            }
        }else {
            if ([BBGSession sharedInstance].isLogin) {
                [self addCartRequest:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        [[BBGLoadingTips sharedInstance]showTips:@"加入购物车成功"];
                        [weakSelf cartNumRequest:^(BOOL sucessful, BBGResponse *response) {
                            if (sucessful) {
                                if ([weakSelf.numLab.text integerValue] == weakSelf.cartNum.totalType) {
                                    [[BBGLoadingTips sharedInstance]showTips:weakSelf.tips];
                                }
                                weakSelf.checkButton.totalType = weakSelf.cartNum.totalType;
                                weakSelf.checkButton.isLogin = [BBGSession sharedInstance].isLogin;
                            }
                        }];
                    }
                }];
            }else {
                [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                    if (successful) {
                        [weakSelf addCartRequest:^(BOOL sucessful, BBGResponse *response) {
                            [[BBGLoadingTips sharedInstance]showTips:@"加入购物车成功"];
                            if (sucessful) {
                                [weakSelf cartNumRequest:^(BOOL sucessful, BBGResponse *response) {
                                    if (sucessful) {
                                        weakSelf.checkButton.totalType = weakSelf.cartNum.totalType;
                                        weakSelf.checkButton.isLogin = [BBGSession sharedInstance].isLogin;
                                    }
                                }];
                            }
                        }];
                    }
                }];
            }
        }
    }
}

#pragma mark - 多规格弹窗点击空白消失
- (void)press:(UITapGestureRecognizer *)sender {
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    CGPoint point = [sender locationInView:_pushBgView];
    if (point.y < _pushMainView.frame.origin.y && point.y > 0) {
        [_pushBgView removeGestureRecognizer:tap];
        [UIView animateWithDuration:.5 animations:^{
            weakSelf.pushBgView.alpha = 0.0;
            [UIView beginAnimations:@"animationID" context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:weakSelf.pushMainView cache:NO];
            weakSelf.pushMainView.frame= CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH, IPHONE_HEIGHT-IPHONE_HEIGHT/3-20);
            [UIView commitAnimations];
        } completion:^(BOOL finished) {
            [weakSelf.pushMainView removeFromSuperview];
        }];
        [_pushBgView performSelector:@selector(removeFromSuperview)
                          withObject:nil
                          afterDelay:2];
        [_BBGGoodsDetail reloadData];
    }
}

#pragma mark - 多规格弹出视图确定或加入购物车点击事件
- (void)quitClick:(UIButton *)sender {
    
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    
    if (weakSelf.pushBgView) {
        if (sender.tag == 1000) {
            if ([BBGSession sharedInstance].isLogin) {
                [self addCartRequest:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        [[BBGLoadingTips sharedInstance]showTips:@"加入购物车成功"];
                        [weakSelf cartNumRequest:^(BOOL sucessful, BBGResponse *response) {
                            if (sucessful) {
                                weakSelf.checkButton.totalType = weakSelf.cartNum.totalType;
                                weakSelf.checkButton.isLogin = [BBGSession sharedInstance].isLogin;
                            }
                        }] ;
                        [UIView animateWithDuration:.5
                                         animations:^{
                                             weakSelf.pushBgView.alpha = 0.0;
                                             [UIView beginAnimations:@"animationID" context:nil];
                                             [UIView setAnimationDuration:0.5];
                                             [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                                             [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:weakSelf.pushMainView cache:NO];
                                             weakSelf.pushMainView.frame= CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH, IPHONE_HEIGHT-IPHONE_HEIGHT/3-20);
                                             [UIView commitAnimations];
                                         }] ;
                        [weakSelf.pushBgView performSelector:@selector(removeFromSuperview)
                                                  withObject:nil
                                                  afterDelay:2];
                    }
                }];
            }else {
                [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                    if (successful) {
                        [weakSelf addCartRequest:^(BOOL sucessful, BBGResponse *response) {
                            [[BBGLoadingTips sharedInstance]showTips:@"加入购物车成功"];
                            if (sucessful) {
                                [weakSelf cartNumRequest:^(BOOL sucessful, BBGResponse *response) {
                                    if (sucessful) {
                                        weakSelf.checkButton.totalType = weakSelf.cartNum.totalType;
                                        weakSelf.checkButton.isLogin = [BBGSession sharedInstance].isLogin;
                                    }
                                }];
                            }
                        }];
                        [UIView animateWithDuration:.5
                                         animations:^{
                                             weakSelf.pushBgView.alpha = 0.0;
                                             [UIView beginAnimations:@"animationID" context:nil];
                                             [UIView setAnimationDuration:0.5];
                                             [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                                             [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:weakSelf.pushMainView cache:NO];
                                             weakSelf.pushMainView.frame= CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH, IPHONE_HEIGHT-IPHONE_HEIGHT/3-20);
                                             [UIView commitAnimations];
                                         }] ;
                        [weakSelf.pushBgView performSelector:@selector(removeFromSuperview)
                                                  withObject:nil
                                                  afterDelay:2];
                    }
                }];
            }
        }
        if (sender.tag == 1002) {
            if ([BBGSession sharedInstance].isLogin) {
                [self cartDirectRequest:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        BBGSettlementViewController_iPhone *vc = [[BBGSettlementViewController_iPhone alloc]init];
                        vc.buyType = BBGBuyTypeDirect;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    }
                }];
            }else {
                [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                    if (successful) {
                        [weakSelf cartDirectRequest:^(BOOL sucessful, BBGResponse *response) {
                            if (sucessful) {
                                BBGSettlementViewController_iPhone *vc = [[BBGSettlementViewController_iPhone alloc]init];
                                vc.buyType = BBGBuyTypeDirect;
                                [weakSelf.navigationController pushViewController:vc animated:YES];
                            }
                        }];
                    }
                }];
            }
            [UIView animateWithDuration:.5
                             animations:^{
                                 weakSelf.pushBgView.alpha = 0.0;
                                 [UIView beginAnimations:@"animationID" context:nil];
                                 [UIView setAnimationDuration:0.5];
                                 [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                                 [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:weakSelf.pushMainView cache:NO];
                                 weakSelf.pushMainView.frame= CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH, IPHONE_HEIGHT-IPHONE_HEIGHT/3-20);
                                 [UIView commitAnimations];
                             }] ;
            [weakSelf.pushBgView performSelector:@selector(removeFromSuperview)
                                      withObject:nil
                                      afterDelay:2];
        }
    }
    [weakSelf.BBGGoodsDetail reloadData];
}

#pragma mark - UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    BBGGoodsSpecQuery *goodSQ = self.goodsSpecsListArr[section];
    return goodSQ.values.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView registerNib:[UINib nibWithNibName:@"BBGGoodsSpecCell" bundle:nil] forCellWithReuseIdentifier:@"BBGGoodsSpec"];
    BBGGoodsSpecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BBGGoodsSpec" forIndexPath:indexPath];
    //    BBGGoodsSpecQuery *goodSQ = self.goodsSpecsListArr[indexPath.section];
    //    BBGGoodsSpecValue *goodSV = goodSQ.values[indexPath.item];
    BBGGoodsSpecQuery *goodSQ = [self.goodsSpecsListArr ARRAY_OBJ_AT(indexPath.section)];
    BBGGoodsSpecValue *goodSV = [goodSQ.values ARRAY_OBJ_AT(indexPath.item)];
    
    if (goodSV.disable == NO) {
        if (goodSV.checked == YES) {
            cell.bgImage.image = [[UIImage imageNamed:@"规格尺码选中按钮"]stretchImage];
            cell.goodBtn.enabled = YES;
            [cell.goodBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
        }else {
            cell.bgImage.image = [[UIImage imageNamed:@"规格尺码未选中按钮"]stretchImage];
            cell.goodBtn.enabled = YES;
            [cell.goodBtn setTitleColor:UICOLOR_FONT_GENERAL_GRAY forState:UIControlStateNormal];
        }
    }else {
        if (goodSV.checked == YES) {
            cell.bgImage.image = [[UIImage imageNamed:@"规格尺码默认选中按钮"]stretchImage];
            cell.goodBtn.enabled = NO;
            [cell.goodBtn setTitleColor:UIColorFromHexadecimalRGB(0xfaa9bf) forState:UIControlStateNormal];
        }else {
            cell.bgImage.image = [[UIImage imageNamed:@"规格尺码不可选按钮"]stretchImage];
            cell.goodBtn.enabled = NO;
            [cell.goodBtn setTitleColor:UIColorFromHexadecimalRGB(0xdfdfdf) forState:UIControlStateNormal];
        }
    }
    
    [cell.goodBtn setTitle:goodSV.name forState:UIControlStateNormal];
    [cell.goodBtn addTarget:self action:@selector(spec:) forControlEvents:UIControlEventTouchUpInside];
    cell.goodBtn.tag = [[NSString stringWithFormat:@"%ld%ld",(long)indexPath.item,(long)indexPath.section]integerValue];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.goodsSpecsListArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BBGGoodsSpecQuery *goodSQ = self.goodsSpecsListArr[indexPath.section];
    BBGGoodsSpecValue *goodSV = goodSQ.values[indexPath.item];
    CGSize size = [goodSV.name
                   sizeWithStringFont:APP_FONT(15.0f) constrainedToSize:CGSizeMake(IPHONE_WIDTH, 40.0f)];
    if (size.width>65.0f) {
        return CGSizeMake(size.width, 40.0f);
    }else {
        return CGSizeMake(65.0f, 40.0f);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    [_pushCollectionView registerClass:[BBGSpecHeader class] forSupplementaryViewOfKind:PTCollectionViewHeader withReuseIdentifier:@"HeaderView"];
    [_pushCollectionView registerClass:[BBGSpecFooter class] forSupplementaryViewOfKind:PTCollectionViewFooter withReuseIdentifier:@"FooterView"];
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == PTCollectionViewHeader) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        BBGGoodsSpecQuery *goodSQ = self.goodsSpecsListArr[indexPath.section];
        ((BBGSpecHeader *)reusableview).titleLab.text = goodSQ.name;
    }else if (kind == PTCollectionViewFooter) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    }
    
    return reusableview;
    
}

#pragma mark - PTFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(PTFlowLayout *)collectionViewLayout estimatedSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(_pushCollectionView.frame), 31);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(PTFlowLayout *)collectionViewLayout estimatedSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(_pushCollectionView.frame), 4);
}

#pragma mark - 规格点击事件
- (void)spec:(UIButton *)sender {
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    
    NSInteger section = sender.tag%10;
    NSInteger item = sender.tag/10;
    BBGGoodsSpecQuery *goodSQ = [self.goodsSpecsListArr ARRAY_OBJ_AT(section)];
    BBGGoodsSpecValue *goodSV = [goodSQ.values ARRAY_OBJ_AT(item)];
    NSString *specKey = [NSString stringWithFormat:@"%ld",(long)section];
    
    NSString *specStr = [NSString stringWithFormat:@"%@;",goodSV.text];
    [specIdDic setObject:specStr forKey:specKey];
    
    NSString *spec;
    if (section==0) {
        spec = [NSString stringWithFormat:@"%@",goodSV.name];
    }else {
        spec = [NSString stringWithFormat:@",%@",goodSV.name];
    }
    [specNameDic setObject:spec forKey:specKey];
    
    NSMutableString *specQueryStr;
    specQueryStr = [NSMutableString string];
    
    specString = [NSMutableString string];
    for (NSInteger i = 0; i < specIdDic.count; i++) {
        NSString *string = [NSString stringWithFormat:@"%ld",(long)i];
        [specQueryStr appendString:[specIdDic objectForKey:string]];
    }
    
    for (NSInteger i = 0; i < specNameDic.count; i++) {
        NSString *string = [NSString stringWithFormat:@"%ld",(long)i];
        [specString appendString:[specNameDic objectForKey:string]];
    }
    
    self.filterText = specQueryStr;
    
    [self reloadGoodsSpecRequest:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            [weakSelf.pushCollectionView reloadData];
            weakSelf.productId = weakSelf.specInfo.productId;
            [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
                if (sucessful) {
                    weakSelf.seckillView.seckillActity = weakSelf.basicInfo.seckillActity;
                    
                    if (weakSelf.basicInfo.goodsStatus==0) {
                        weakSelf.confirmBtn.enabled = YES;
                        weakSelf.confirmBtn.backgroundColor = UICOLOR_FONT_IMPORTANT_RED;
                        weakSelf.confirmBtn.layer.borderColor = [UICOLOR_FONT_IMPORTANT_RED CGColor];
                        [weakSelf.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    }else {
                        weakSelf.confirmBtn.layer.borderColor = [UIColorFromHexadecimalRGB(0xfaa9bf) CGColor];
                        [weakSelf.confirmBtn setTitleColor:UIColorFromHexadecimalRGB(0xfaa9bf) forState:UIControlStateNormal];
                        weakSelf.confirmBtn.enabled = NO;
                        weakSelf.confirmBtn.backgroundColor = [UIColor whiteColor];
                    }
                    
                    [weakSelf.specImage sd_setImageWithURL:[NSURL URLWithString:weakSelf.basicInfo.productImageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (cacheType ==SDImageCacheTypeNone) {
                            [weakSelf.specImage setFadeInWithDefaultTime];
                        }
                    }];
                    weakSelf.pushTitleLabel.text = weakSelf.basicInfo.productName;
                    CGSize size = [weakSelf.specInfo.goodsName
                                   sizeWithStringFont:APP_FONT(14.0f) constrainedToSize:CGSizeMake(IPHONE_WIDTH-30-74, 10000)];
                    if (size.height > 42.0f) {
                        size.height = 42.0f;
                    }
                    weakSelf.pushTitleLabel.frame = CGRectMake(94, 10, IPHONE_WIDTH-30-74, size.height);
                    
                    weakSelf.priceLabel.frame = CGRectMake(94.0f, 74.0f, 0, 0);
                    weakSelf.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",weakSelf.basicInfo.unCrossedPrice/100];
                    [weakSelf.priceLabel sizeToFit];
                    
                    if (weakSelf.basicInfo.productType==0) {
                        weakSelf.confirmBtn.tag = 1000;
                        [weakSelf.confirmBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
                    }else {
                        weakSelf.confirmBtn.tag = 1002;
                        [weakSelf.confirmBtn setTitle:@"买买买" forState:UIControlStateNormal];
                    }
                    [weakSelf.bottomView removeFromSuperview];
                    [weakSelf.pictureView reloadData];
                    [weakSelf addBottomView];
                    [weakSelf getSectionNum];
                    [weakSelf.BBGGoodsDetail reloadData];
                }
            }];
        }
    }];
}

#pragma mark - UITableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[[sectionArr ARRAY_OBJ_AT(section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"AllCommentTextCell"]) {
        return self.commentListArr.count;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsDetailHeaderCell"]) {
        CGFloat height = [BBGGoodsDetailHeaderCell cellHeignt:self.basicInfo];
        if (height > 55.0f) {
            return height;
        }else {
            return 55.0f;
        }
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsPreferentialCell"]) {
        BBGGoodsPreferentialCell *cell = (BBGGoodsPreferentialCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsTextCell"]) {
        return cellHeight;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGDetailSpecCell"]) {
        return 40.0f;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsShopCell"]) {
        return 120.0f;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsPlaceCell"]) {
        return 87.0f;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsTimeCell"]) {
        BBGGoodsTimeCell *cell = (BBGGoodsTimeCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsCommentCell"]) {
        return 99.0f;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGCommentHeadCell"]) {
        return 40.0f;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"AllCommentTextCell"]) {
        BBGComment *comment = [self.commentListArr ARRAY_OBJ_AT(indexPath.row)];
        BBGReply *reply = comment.replyFor;
        if (comment.replyFor.replyText.length == 0) {
            if ([comment.imgUrlListArray count] == 0) {
                ///无回复无图片
                return [AllCommentTextCell cellHeignt:comment];
            }else{
                ///无回复有图片
                return [AllCommentImageCell cellHeignt:comment];
            }
        }else{
            if ([comment.replyFor.imgUrlListArray count] == 0) {
                ///有回复无图片
                return [AllReplyTextCell cellHeignt:comment replyText:reply];
            }else{
                ///有回复有图片
                return [AllReplyImageCell cellHeignt:comment replyText:reply];
            }
        }
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGCommentFootCell"]) {
        return 37.0f;
    }else {
        return 36.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsDetailHeaderCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsDetailHeaderCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsDetailHeader"];
        BBGGoodsDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsDetailHeader"];
        [cell updateCellWith:self.basicInfo];
        [cell.headerView praiseButtonAction:^{
            [weakSelf praise];
        }];
        [cell.headerView commentButtonAction:^{
            [weakSelf comment];
        }];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsPreferentialCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsPreferentialCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsPreferential"];
        BBGGoodsPreferentialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsPreferential"];
        NSMutableArray *array = self.promotionActivitiesArr;
        cell.dataArr = array;
        CGRect cellFrame = cell.frame;
        cellFrame.size.height = [BBGGoodsPreferentialCell cellHeignt:array];
        cell.tableViewHeight.constant = cellFrame.size.height;
        cell.frame = cellFrame;
        [cell.tableView setNeedsDisplay];
        [cell setNeedsDisplay];
        [cell.tableView reloadData];
        [cell goGiftButtonAction:^(NSInteger num) {
            BBGPromotionActivities *model = weakSelf.promotionActivitiesArr[num];
            BBGDetailGiftViewController_iPhone *vc = [[BBGDetailGiftViewController_iPhone alloc]init];
            vc.dataArr = model.gifts;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsTextCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsTextCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsText"];
        BBGGoodsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsText"];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.basicInfo.goodsExplain];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:5.0f];
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.basicInfo.goodsExplain length])];
        cell.content.attributedText = attributedString;
        CGSize size = [cell.content.text sizeWithStringFont:cell.content.font constrainedToSize:CGSizeMake(IPHONE_WIDTH-20, 100000) lineSpacing:5.0f];
        CGFloat cellH = size.height;
        if (isExpand == YES) {
            cell.content.numberOfLines = 0;
        }else {
            cell.content.numberOfLines = 2;
            cell.content.lineBreakMode = NSLineBreakByTruncatingTail;
        }
        
        if (cellH <= 30.0f) {
            cell.fold.hidden = YES;
        }else{
            cell.fold.hidden = NO;
        }
        [cell.fold addTarget:self action:@selector(foldClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.allBtn addTarget:self action:@selector(foldClick) forControlEvents:UIControlEventTouchUpInside];
        cell.tag = 100;
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGDetailSpecCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGDetailSpecCell" bundle:nil] forCellReuseIdentifier:@"BBGDetailSpec"];
        BBGDetailSpecCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGDetailSpec"];
        cell.specContentLab.text = specString;
        if (self.basicInfo.productType==0) {
            cell.specBtn.tag = 1001;
        }else {
            cell.specBtn.tag = 18;
        }
        [cell.specBtn addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsShopCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsShopCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsShop"];
        BBGGoodsShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsShop"];
        [cell updateCellWith:self.basicInfo];
        [cell handlerButtonAction:^{
            [weakSelf getWeb];
        }];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsPlaceCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsPlaceCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsPlace"];
        BBGGoodsPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsPlace"];
        [cell updateCellWith:self.basicInfo];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsTimeCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsTimeCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsTime"];
        BBGGoodsTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsTime"];
        cell.dataArr = self.goodsTipArr;
        CGRect cellFrame = cell.frame;
        if (self.goodsTipArr.count>1) {
            cell.tableViewHeight.constant += (self.goodsTipArr.count-1)*27;
            cellFrame.size.height += (self.goodsTipArr.count-1)*27;
        }
        cell.frame = cellFrame;
        [cell.tableView setNeedsDisplay];
        [cell setNeedsDisplay];
        [cell.tableView reloadData];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGGoodsCommentCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsCommentCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsComment"];
        BBGGoodsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsComment"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < self.praiseMembsArr.count ; i++) {
            BBGPraiseMembs *bbgPraiseMembs = [[BBGPraiseMembs alloc]init];
            bbgPraiseMembs = [self.praiseMembsArr ARRAY_OBJ_AT(i)];
            if (bbgPraiseMembs.memberId!=nil) {
                [array addObject:[self.praiseMembsArr ARRAY_OBJ_AT(i)]];
            }
        }
        cell.dataArr = array;
        [cell updateCellWith:self.basicInfo];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGCommentHeadCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGCommentHeadCell" bundle:nil] forCellReuseIdentifier:@"BBGCommentHead"];
        BBGCommentHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGCommentHead"];
        return cell;
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"AllCommentTextCell"]) {
        BBGComment *comment = [self.commentListArr ARRAY_OBJ_AT(indexPath.row)];
        BBGReply *reply = comment.replyFor;
        ///是否有回复
        if (comment.replyFor.replyText.length == 0) {
            ///无回复且无图片
            if ([comment.imgUrlListArray count] == 0) {
                static NSString *identifier1 = @"AllCommentTextCell";
                AllCommentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier1 owner:nil options:nil] firstObject];
                }
                [cell updateCell:comment];
                return cell;
            }else{
                ///无回复但有图片
                static NSString *identifier2 = @"AllCommentImageCell";
                AllCommentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier2 owner:nil options:nil] firstObject];
                }
                cell.delegate = self;
                [cell updateCell:comment];
                return cell;
            }
        }else{
            ///有回复无图片
            if ([reply.imgUrlListArray count] == 0) {
                static NSString *identifier3 = @"AllReplyTextCell";
                AllReplyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier3 owner:nil options:nil] firstObject];
                }
                [cell updateCell:comment replyText:reply];
                return cell;
            }else{
                ///有回复有图片
                static NSString *identifier4 = @"AllReplyImageCell";
                AllReplyImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier4 owner:nil options:nil] firstObject];
                }
                cell.replyReferenceImageView.delegate = self;
                [cell updateCell:comment replyText:reply];
                return cell;
            }
        }
    }else if ([[[sectionArr ARRAY_OBJ_AT(indexPath.section)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGCommentFootCell"]) {
        [tableView registerNib:[UINib nibWithNibName:@"BBGCommentFootCell" bundle:nil] forCellReuseIdentifier:@"BBGCommentFoot"];
        BBGCommentFootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGCommentFoot"];
        [cell.allBtn addTarget:self action:@selector(allComment) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else {
        [tableView registerNib:[UINib nibWithNibName:@"BBGTableBottomCell" bundle:nil] forCellReuseIdentifier:@"BBGTableBottom"];
        BBGTableBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGTableBottom"];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[sectionArr[indexPath.section] objectForKey:@"Cell"]isEqualToString:@"BBGGoodsCommentCell"]&&self.isDisplay == NO) {
        self.isDisplay = YES;
        CGPoint originPoint = cell.center;
        cell.center = CGPointMake(cell.frame.size.width*indexPath.section, originPoint.y);
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             cell.center = CGPointMake(originPoint.x-indexPath.section*2, originPoint.y);
                             cell.hidden = NO;
                         }
                         completion:^(BOOL finish) {
                             [UIView animateWithDuration:0.1 delay:0
                                                 options:UIViewAnimationOptionCurveEaseIn
                                              animations:^{
                                                  cell.center = CGPointMake(originPoint.x+indexPath.section*2, originPoint.y);
                                              }
                                              completion:^(BOOL finish) {
                                                  [UIView animateWithDuration:0.1 delay:0
                                                                      options:UIViewAnimationOptionCurveEaseIn
                                                                   animations:^{
                                                                       cell.center= originPoint;
                                                                   }
                                                                   completion:nil];
                                              }];
                         }];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    if ([[sectionArr[indexPath.section] objectForKey:@"Cell"]isEqualToString:@"AllCommentTextCell"]) {
        //        if ([BBGSession sharedInstance].isLogin) {
        BBGAllCommentViewController_iPhone *allComment = [[BBGAllCommentViewController_iPhone alloc]init];
        allComment.goodsId = self.basicInfo.goodsId;
        allComment.title = @"全部评论";
        [self.navigationController pushViewController:allComment animated:YES];
        //        }else {
        //            [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
        //                if (successful) {
        //                    BBGAllCommentViewController_iPhone *allComment = [[BBGAllCommentViewController_iPhone alloc]init];
        //                    allComment.goodsId = self.basicInfo.goodsId;
        //                    allComment.title = @"全部评论";
        //                    [weakSelf.navigationController pushViewController:allComment animated:YES];
        //                }
        //            }];
        //        }
    }
}

#pragma mark - 展开收起文本
- (void)foldClick {
    BBGGoodsTextCell *cell = (BBGGoodsTextCell *)[_BBGGoodsDetail viewWithTag:100] ;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.basicInfo.goodsExplain];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5.0f];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.basicInfo.goodsExplain length])];
    CGSize size = [cell.content.text sizeWithStringFont:cell.content.font constrainedToSize:CGSizeMake(IPHONE_WIDTH-20, 100000) lineSpacing:5.0f];
    CGFloat cellH = size.height;
    
    if (cellH > 30.0f) {
        if (isExpand == NO) {
            isExpand = YES;
            CGRect cellFrame = cell.frame;
            [cell.fold setImage:[UIImage imageNamed:@"收起更多描述"] forState:UIControlStateNormal];
            cellFrame.size.height = 60.0f-30.0f+cellH;
            cell.frame = cellFrame;
            cellHeight = cellFrame.size.height;
            [cell.content setNeedsDisplay];
            [cell setNeedsDisplay];
            [_BBGGoodsDetail reloadData];
            return;
        }
        
        if (isExpand == YES) {
            isExpand = NO;
            CGRect cellFrame = cell.frame;
            [cell.fold setImage:[UIImage imageNamed:@"查看更多描述"] forState:UIControlStateNormal];
            cellFrame.size.height = 60.0f;
            cell.frame = cellFrame;
            cellHeight = cellFrame.size.height;
            [cell.content setNeedsDisplay];
            [cell setNeedsDisplay];
            [_BBGGoodsDetail reloadData];
            return;
        }
    }else {
        return;
    }
}

#pragma mark - 分页
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.BBGGoodsDetail) {
        if (_webView == nil) {
            _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, _BBGGoodsDetail.contentSize.height, IPHONE_WIDTH, IPHONE_HEIGHT-113)];
            _webView.scalesPageToFit = YES;
            _webView.scrollView.bounces = NO;
            _webView.scrollView.delegate = self;
            [_webView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:@"webviewY"];
            [_BBGGoodsDetail addSubview:_webView];
        }
        
        NSInteger yOffset = scrollView.contentOffset.y;
        NSInteger offsetH = scrollView.contentSize.height;
        NSInteger reduce = scrollView.contentSize.height - scrollView.frame.size.height;
        NSInteger offsetNum1 = offsetH - yOffset;
        NSInteger offsetNum2 = yOffset+scrollView.frame.size.height - offsetH;
        
        _webView.frame = CGRectMake(0, _BBGGoodsDetail.contentSize.height, IPHONE_WIDTH, IPHONE_HEIGHT-113);
        if ((isUp == YES)&&(yOffset > reduce)&&yOffset < offsetH&&offsetNum2>50) {
            [_webView loadHTMLString:self.basicInfo.intro baseURL:nil];
            [UIView animateWithDuration:0.01 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollTitle" object:@"0"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.4 animations:^{
                    scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentSize.height, 0, 0, 0);
                } completion:^(BOOL finished) {
                    isUp = NO;
                }];
            }];
        }
        if ((isUp == NO)&&(yOffset > reduce)&&yOffset < offsetH&&offsetNum1>50) {
            [UIView animateWithDuration:0.01 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollTitle" object:@"1"];
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.4 animations:^{
                    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                } completion:^(BOOL finished) {
                    isUp = YES;
                }];
            }];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.BBGGoodsDetail) {
        CGFloat yOffset = scrollView.contentOffset.y;
        CGRect frame = self.pictureView.frame;
        if (yOffset < 0) {
            self.pictureView.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH);
            headView.clipsToBounds = YES;
        }
        if (yOffset>0&&yOffset<IPHONE_WIDTH) {
            frame.origin.y = MAX(yOffset*0.5, 0);
            self.pictureView.frame = frame;
            headView.clipsToBounds = YES;
        }
    }
    if (scrollView == _webView.scrollView) {
        if (scrollView.contentOffset.y > 0.8*IPHONE_HEIGHT) {
            returnTop.hidden = NO;
        }else {
            returnTop.hidden = YES;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGFloat yWebView = _webView.scrollView.contentOffset.y;
    CGFloat yTableView = _BBGGoodsDetail.contentSize.height;
    if (context == @"webviewY") {
        if (yWebView==0) {
            _BBGGoodsDetail.scrollEnabled = YES;
        }else {
            _BBGGoodsDetail.scrollEnabled = NO;
        }
    }
    if ((context == @"tableviewY")&&(_webView.scrollView.contentSize.height>IPHONE_HEIGHT)) {
        if (yTableView<_BBGGoodsDetail.contentOffset.y) {
            _BBGGoodsDetail.scrollEnabled = NO;
        }else {
            _BBGGoodsDetail.scrollEnabled = YES;
        }
    }
}


#pragma mark - ImageCollectionViewCellDelegate
- (void)didClickedImageViewCell:(NSIndexPath *)indexPath imageArray:(NSMutableArray *)imageArray{
    BBGPhotoBrowserViewController *con = [[BBGPhotoBrowserViewController alloc] init];
    con.imgArray = imageArray;
    con.currentImgIndex = (int)indexPath.row;
    [self.navigationController presentViewController:con animated:YES completion:nil];
}

#pragma mark - 分享
-(void)shareToSNSWithImage:(UIImage *)shareImage{
    NSString *shareUrl;
    if (self.productId.length!=0) {
        shareUrl = [NSString stringWithFormat:@"http://m.yunhou.com/item/%@.html",self.productId];
    }else {
        shareUrl = [NSString stringWithFormat:@"http://m.yunhou.com/item/%@.html",self.basicInfo.productId];
    }
    NSString *shareText = [NSString stringWithFormat:@"今天在百分百正品保证的云猴网发现了一件不错滴东东，伙伴们快去抢购吧..."];
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    [[BBGShareManager sharedInstance] shareToSnsSheetView:self shareText:shareText shareImage:shareImage shareToSnsNames:nil shareUrl:shareUrl clickPlatformCallBack:^(NSString *snsName) {
        
        if ([snsName isEqual:@"sina"]) {
            [UMSocialData defaultData].shareText = [NSString stringWithFormat:@"%@,今天在百分百正品保证的云猴网发现了一件不错滴东东，伙伴们快去抢购吧...%@",weakSelf.basicInfo.productName,shareUrl];
        }
        // 朋友圈分享的标题会覆盖内容
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@,今天在100%%正品保证的云猴网发现了一件不错滴东东，伙伴们快去抢购吧...",weakSelf.basicInfo.productName];
        
        [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"%@",weakSelf.basicInfo.productName];
        [UMSocialData defaultData].extConfig.qqData.title = [NSString stringWithFormat:@"%@",weakSelf.basicInfo.productName];
        [UMSocialData defaultData].extConfig.qzoneData.title = [NSString stringWithFormat:@"%@",weakSelf.basicInfo.productName];
        
        /*
         if ([snsName isEqualToString:@"wxtimeline"]) {
         //朋友圈只分享图片
         [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
         }else {
         //微信好友分享标题、缩略图、和url链接
         [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeNone;
         }
         */
    }];
}

#pragma mark - BBGAdvViewDataSource
- (NSInteger)numberOfPagesInAdvView:(BBGAdvView *)advView{
    if (self.goodsImagesArr) {
        return self.goodsImagesArr.count;
    }
    return 0;
}

- (UIView *)advView:(BBGAdvView *)advView viewForAdvViewAtPage:(NSInteger)page{
    if (self.goodsImagesArr) {
        UIImageView *filmImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH)];
        filmImageView.contentMode = UIViewContentModeScaleAspectFit;
        BBGGoodsDetailImages *detailImages = [self.goodsImagesArr ARRAY_OBJ_AT(page)];
        [filmImageView sd_setImageWithURL:[NSURL URLWithString:detailImages.imageUrl] placeholderImage:[UIImage imageNamed:@"goodsDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (page == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"imageCompleted" object:nil];
            }
            if (cacheType ==SDImageCacheTypeNone) {
                [filmImageView setFadeInWithDefaultTime];
            }
        }];
        return filmImageView;
    }
    return nil;
}

- (CGFloat)advView:(BBGAdvView *)advView heightForViewAtPage:(NSInteger)page{
    return IPHONE_WIDTH;
}

- (void)advView:(BBGAdvView *)advView didSelectViewAtPage:(NSInteger)page {
    BBGGoodsDetailPushImage *goodsDetailPushImage = [[BBGGoodsDetailPushImage alloc]init];
    goodsDetailPushImage.dataArr = self.goodsImagesArr;
    goodsDetailPushImage.page = page;
    [self presentViewController:goodsDetailPushImage animated:YES completion:^{
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInfo:) name:@"Text" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn sizeToFit];
    shareBtn.titleLabel.font = APP_FONT_DEMI_LIGHT(15.0f);
    UIBarButtonItem *shareBarBtn = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = shareBarBtn;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)];
    label.text = @"商品详情";
    label.font = APP_FONT_DEMI_LIGHT(18.0f);
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    __weak BBGGoodsDetailViewController_iPhone *weakSelf = self;
    
    if ([BBGSession sharedInstance].isLogin) {
        [self cartNumRequest:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
                    if (sucessful) {
                        [weakSelf initUI];
                    }
                }];
            }
        }];
    }else {
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                [weakSelf initUI];
            }
        }];
    }
}

- (void)dismissViewController {
    [super dismissViewController];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Text" object:nil];
}

- (void)dealloc {
    [_webView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.BBGGoodsDetail removeObserver:self forKeyPath:@"contentOffset"];
    self.BBGGoodsDetail.delegate = nil;
    self.pictureView.delegate = nil;
    _webView.scrollView.delegate = nil;
    flowLayout.delegate = nil;
    self.pushCollectionView.delegate = nil;
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
