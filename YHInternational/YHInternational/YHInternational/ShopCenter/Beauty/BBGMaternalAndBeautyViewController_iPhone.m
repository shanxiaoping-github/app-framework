//
//  MaternalAndBeautyViewController_iPhone.m
//  YHInternational
//
//  Created by 刘薇 on 15/7/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMaternalAndBeautyViewController_iPhone.h"
#import "BBGBackToTopView.h"
#import "AdvCell.h"
#import "BBGIndexTitleCell.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGSpecialWebViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGBeautyEffectViewController_iPhone.h"
#import "BBGSettlementViewController_iPhone.h"
#import "BBGCosmeticBrandViewController_iPhone.h"
#import "BBGLaunchManager.h"
#import "BBGGoodsListViewController_iPhone.h"
#import "BBGIndexProductCell.h"
#import "BBGGoodsSeckillViewController_iPhone.h"
@interface BBGMaternalAndBeautyViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,PullDelegate,AdvDelegate,BBGRecommendCellDelegate>
{
    BOOL isLoadMore;
    BOOL isFristHaveTwenty;
    BOOL isTopViewInCell;
    BOOL isScrollUp;
    CGFloat topHeight;
}
@property (nonatomic, strong)UIView *suspensionHeaderView;
@property (nonatomic, strong)BBGBackToTopView *BackToTopView;
@property (nonatomic, strong)BBGPullTable *tableView;
@property (assign, nonatomic) CGPoint contentOff;
@property (strong, nonatomic) UITableViewCell *topCell;

@end

@implementation BBGMaternalAndBeautyViewController_iPhone


- (id)initWithTypeTag:(NSInteger)tag {
    self = [super init];
    if (self) {
        self.tagType = tag ;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[BBGPullTable alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.notOpenSticky = YES;
    _tableView.pullDelegate = self ;
    [_tableView setScrollsToTop:NO];
    __weak BBGMaternalAndBeautyViewController_iPhone *weakSelf = self;
    [self.view addSubview:_tableView];
    
    [weakSelf suspensionBeautyOrMaternal];
   
    _BackToTopView = [[BBGBackToTopView alloc]init];
    _BackToTopView.alpha=0;
    _BackToTopView.center=CGPointMake(IPHONE_WIDTH-_BackToTopView.frame.size.width/2-9, (IPHONE_HEIGHT-70-44-39-45)-_BackToTopView.frame.size.height/2-5);
    _BackToTopView.GoTopBlock=^{
        weakSelf.suspensionHeaderView.alpha = 1;
        [weakSelf.topCell.contentView addSubview:weakSelf.suspensionHeaderView];
        [weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    };
    [self.view addSubview:_BackToTopView];
    
    
    
}
- (void)refresh{
    
    __weak BBGMaternalAndBeautyViewController_iPhone * weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:weakSelf.view];
    [self getMaternalOrBeautyData:^(BOOL isfinished, id response){
        [weakSelf.tableView stopAnimation];
        [weakSelf.defaultView dismiss];
        if (isfinished) {
                self.maternalOrBeautyResponse.secondsKillProductArray = nil;
                weakSelf.nowPage = 0;
                weakSelf.maternalOrBeautyResponse = response;
                if ([self.maternalOrBeautyResponse.secondsKillProductArray count] < 20) {
                    isFristHaveTwenty = NO;
                } else {
                    isFristHaveTwenty = YES;
                    
                }
                weakSelf.tableView.showsInfiniteScrolling = isFristHaveTwenty;
                [weakSelf.tableView reloadData];
                
            }else{
                if (weakSelf.maternalOrBeautyResponse == nil) {
                    [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf actionTitle:@"重新加载" action:@selector(refresh) WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
                    
                }
            }
       
    }];
}
#pragma mark－－－－－－悬浮美妆母婴模块
- (void)suspensionBeautyOrMaternal
{
    __weak BBGMaternalAndBeautyViewController_iPhone * weakSelf = self;
    weakSelf.suspensionHeaderView = [UIView new];
    weakSelf.suspensionHeaderView.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH*55/375);
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH*55/375)];
    imageView.tag=2001;

    if (self.tagType == 1) {
        imageView.image=[UIImage imageNamed:@"Maternal"];
    } else if(self.tagType == 2){
        imageView.image=[UIImage imageNamed:@"BeautyMakeUp"];
    }else if(self.tagType == 3){
        imageView.image=[UIImage imageNamed:@"foodSupplements"];
    }
    imageView.userInteractionEnabled = YES;
    [weakSelf.suspensionHeaderView addSubview:imageView];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(IPHONE_WIDTH/2-0.25, IPHONE_WIDTH*55/375*1/5, 0.5, IPHONE_WIDTH*55/375*3/5)];
    lineView.backgroundColor = UIColorFromHexadecimalRGB(0xe5e5e5);
    [weakSelf.suspensionHeaderView addSubview:lineView];
    
    
    UIView *bottomLine = [UIView new];
    bottomLine.frame = CGRectMake(0.0f, IPHONE_WIDTH*55/375-0.5f, IPHONE_WIDTH, 0.5f);
    bottomLine.backgroundColor = UIColorFromHexadecimalRGB(0xe5e5e5);
    [weakSelf.suspensionHeaderView addSubview:bottomLine];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureInView:)];
    [imageView addGestureRecognizer:gesture];
}

#pragma mark- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    switch (section) {
        case 1:
        {
            if ([self.maternalOrBeautyResponse.advArray count] > 0) {
                return 5.0f;
            }
        }
            break;

        case 2:
        {
            if (self.maternalOrBeautyResponse) {
                return 5.0f;
            }
        }
            break;
        case 3:
        {
            if ([self.maternalOrBeautyResponse.topicArray count] > 0) {
                return 5.0f;
            }
        }
            break;
        case 4:
        {
                return 5.0f;
        }
            break;
        default:
            break;
    }
    return 0.1f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     *  知会对应cell的比例
     **/
    switch (indexPath.section) {
        case 1://轮播图高度
        {
            if (IPHONE_WIDTH == 320) {
                topHeight = 133 + IPHONE_WIDTH*55/375+10;
                return 133;
                
            }else if (IPHONE_WIDTH == 375){
                topHeight = 155 + IPHONE_WIDTH*55/375+10;
                return 155;
            }else{
                topHeight = 171 + IPHONE_WIDTH*55/375+10;
                return 171;
            }

            
        }
            break;
        case 2:
        {
            return IPHONE_WIDTH*55/375;
        }
            break;
        case 3://专题页高度
        {
            float a;
            if (indexPath.row == self.maternalOrBeautyResponse.topicArray.count-1) {
                a=IPHONE_WIDTH/375*160+10;
            } else {
                a=IPHONE_WIDTH/375*160+5;
            }
            return a;
        }
            break;
        case 4://商品图高度
        {
            if (indexPath.row == 0) {
                return 40;
            } else {
                return IPHONE_WIDTH/375*140;
            }
        }
            break;
        default:
            return 0;
            break;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /**
     *  判断是否对应的模块有数据再对应返回相应的section数量
     **/
    switch (section) {
        case 1:
            if (self.maternalOrBeautyResponse.advArray.count >= 1) {
                return 1;
            }else {
                return 0;
            }
            break;
        case 2:
            if (self.maternalOrBeautyResponse) {
                return 1;
            }else {
                return 0;
            }
            break;
        case 3:
            if (self.maternalOrBeautyResponse.topicArray.count >= 1) {
            return self.maternalOrBeautyResponse.topicArray.count;
            }else {
            return 0;
            }
            break;
        case 4:
            if (self.maternalOrBeautyResponse.secondsKillProductArray.count >= 1) {
             return   self.maternalOrBeautyResponse.secondsKillProductArray.count+1;
            }else {
            return 0;
            }
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 1:
        {
            cell = [self tableView:tableView  advCellForRowAtIndexPath:indexPath];
            return cell;
          
        }
        break;
        case 2:
        {
            cell = [self tableView:tableView maternalOrBeautyCellForRowAtIndexPath:indexPath];
            return cell;
            
        }
        break;
        case 3:

        {
            cell = [self tableView:tableView  advertisingCellForRowAtIndexPath:indexPath];
            return cell;
        }

        break;
        case 4:
        {
            cell = [self tableView:tableView  itemCellForRowAtIndexPath:indexPath];
            return cell;
            
        }
            break;
        default:
            return [UITableViewCell new];
        break;
    }
}
#pragma mark- advDelegate
- (void)didSelected:(int)currentPage{
    BBGAdvProduct * advProduct = [self.maternalOrBeautyResponse.advArray ARRAY_OBJ_AT(currentPage)];
    [self gotoNewViewController:advProduct];
}
- (void)gotoNewViewController:(BBGAdvProduct *)advProduct
{
    switch ([advProduct.charsPointType integerValue]) {
        case 1:
        {
            /**
             *  url
             */
            BBGSpecialWebViewController_iPhone * webViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:advProduct.adURL]];
            
            if ([advProduct.isHaveNav isEqualToString:@"1"]) {
                webViewController.hasBottomView = YES;
            } else {
                webViewController.hasBottomView = NO;
            }
            BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:webViewController];
            webViewController.title = advProduct.adName;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                
            }];
        }
            break;
        case 2:
        {
            /**
             *  专题
             */
            
            BBGSpecialWebViewController_iPhone * webViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:advProduct.adURL]];
            webViewController.title = advProduct.adName;
            BBGNavigationController * nav = [[BBGNavigationController alloc] initWithRootViewController:webViewController];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                
            }];
            
        }
            break;
        case 3:
        {
            /**
             *  单品
             */
            BBGGoodsDetailViewController_iPhone * goodsDetailViewController = [[BBGGoodsDetailViewController_iPhone alloc]init];
            goodsDetailViewController.productId = advProduct.productID;
            BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsDetailViewController];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                
            }];
            
        }
            break;
        case 4:
        {
            /**
             *  商品列表
             */
            BBGGoodsListViewController_iPhone *goodsListCtrl = [[BBGGoodsListViewController_iPhone alloc] init];
            
            goodsListCtrl.keyword =advProduct.searchWord;
            goodsListCtrl.sourceViewController = BBGSearchController;
            BBGNavigationController * nav = [[BBGNavigationController alloc] initWithRootViewController:goodsListCtrl];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                
            }];
            
        }
            break;
        default:
            break;
    }

  
}
- (UITableViewCell*)tableView:(UITableView *)tableView maternalOrBeautyCellForRowAtIndexPath:(NSIndexPath *)indexPat{

    _topCell = [tableView dequeueReusableCellWithIdentifier:@"BeautyMakeUp"];
    if (!_topCell) {
        _topCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BeautyMakeUp"];
        __weak BBGMaternalAndBeautyViewController_iPhone * weakSelf = self;
        weakSelf.suspensionHeaderView.alpha = 1;
        if (!isTopViewInCell) {
            [_topCell.contentView addSubview:weakSelf.suspensionHeaderView];
            isTopViewInCell = YES;
        }
    }
    return _topCell;

}
- (UITableViewCell*)tableView:(UITableView *)tableView advCellForRowAtIndexPath:(NSIndexPath *)indexPat{
    AdvCell * cell = [tableView dequeueReusableCellWithIdentifier:@"maternalOrBeautyAdvCell"];
    if (cell == nil) {
        cell = [[AdvCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"maternalOrBeautyAdvCell"];
        cell.delegate = self;
    }
    if (self.maternalOrBeautyResponse.advArray) {
        [cell updateCell:self.maternalOrBeautyResponse.advArray];
    }
    return cell;
}
- (UITableViewCell*)tableView:(UITableView *)tableView advertisingCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RecommendAd"];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendAd"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor whiteColor];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, IPHONE_WIDTH, IPHONE_WIDTH/375*160)];
        imageView.tag=1101;
        [cell.contentView addSubview:imageView];
    }
    for (UIImageView *ImgView in cell.contentView.subviews) {
        if (ImgView.tag==1101) {
            ImgView.image=nil;
            BBGAdvProduct *product = [self.maternalOrBeautyResponse.topicArray ARRAY_OBJ_AT(indexPath.row)];

            [ImgView sd_setImageWithURL:[NSURL URLWithString:product.adImg] placeholderImage:[UIImage imageNamed:@"defaultImageCenter"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (cacheType ==SDImageCacheTypeNone) {
                    [ImgView setFadeInWithDefaultTime];
                }
            }];

        }
    }
    
    return cell;

}
- (UITableViewCell*)tableView:(UITableView *)tableView itemCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BBGIndexTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (!cell) {
            cell = [[BBGIndexTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell updateTitle:@"每日推荐"];
        [cell dismissBottomLine];
        return cell;
        
    } else {
        BBGIndexProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaternalORBeautyRecommendGoods"];
        if (!cell) {
            
            cell = [[BBGIndexProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MaternalORBeautyRecommendGoods"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.delegate=self;
        cell.indexpath=indexPath;
        [cell updateCell:[self.maternalOrBeautyResponse.secondsKillProductArray ARRAY_OBJ_AT(indexPath.row-1)] isUp:isScrollUp];
        return cell;
        
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        
        case 3:
        {
            /*!
             *  手机专题
             */
            BBGAdvProduct * advProduct =[self.maternalOrBeautyResponse.topicArray ARRAY_OBJ_AT(indexPath.row)];
            [self gotoNewViewController:advProduct];

        }
        break;
        case 4:
        {
            /*!
             *  推荐单品
             */
            BBGRecommendProduct * product = [self.maternalOrBeautyResponse.secondsKillProductArray ARRAY_OBJ_AT(indexPath.row-1)];
            
            //判断是是否为秒杀商品
            if(product.isSecKill){
                
                BBGGoodsSeckillViewController_iPhone *goodsSeckillVC = [[BBGGoodsSeckillViewController_iPhone alloc]init];
                goodsSeckillVC.productId = product.productID;
                goodsSeckillVC.activityId = product.activityId;
                BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsSeckillVC];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];
            }else{
                BBGGoodsDetailViewController_iPhone * goodsDetailViewController = [[BBGGoodsDetailViewController_iPhone alloc]init];
                goodsDetailViewController.productId = product.productID;
                BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsDetailViewController];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];
                
            }
        }
        break;
        default:
        break;
    }
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > self.contentOff.y) {
        isScrollUp = YES;
    }else{
        isScrollUp = NO;
    }

    
    if (scrollView.contentOffset.y>IPHONE_HEIGHT*0.8) {
        _BackToTopView.alpha=1;
    }else{
        _BackToTopView.alpha=0;
    }
    
    
    if (scrollView.contentOffset.y <= topHeight) {
        __weak BBGMaternalAndBeautyViewController_iPhone * weakSelf = self;
        weakSelf.suspensionHeaderView.alpha = 1;
        [_topCell.contentView addSubview:weakSelf.suspensionHeaderView];

    }
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.contentOff = scrollView.contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    __weak BBGMaternalAndBeautyViewController_iPhone *weakSelf = self;
    //向上滑动逻辑
    if (scrollView.contentOffset.y > weakSelf.contentOff.y) {
        //隐藏barView
        if (_tableView.contentOffset.y >topHeight) {
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.suspensionHeaderView.alpha = 0;
                [weakSelf.suspensionHeaderView removeFromSuperview];
            }];

        }
        
        
    }else {
        //显示barView
        if (_tableView.contentOffset.y > topHeight) {
            [UIView animateWithDuration:0.5 animations:^{
                   weakSelf.suspensionHeaderView.alpha = 1;
                    [self.view addSubview:weakSelf.suspensionHeaderView];
                    isTopViewInCell = NO;
            }];

        }
        
        
        
      
    }
    
}

#pragma mark -----gestureInView:
- (void)gestureInView:(UIGestureRecognizer *)tap
{
    
    NSString *URL;
    BBGIndexRecomendInitInfo *info;
    NSMutableArray *arrayOne = [NSMutableArray array];
    for (int i=0; i<[self.maternalOrBeautyResponse.brandInit count]; i++) {
        info = self.maternalOrBeautyResponse.brandInit[i];
        if ([info.btnId isEqualToString:@"recommend_entry"]) {
            [arrayOne addObject:info];
        }else{
            info=nil;
        }
    }
    
    if (tap.view.tag == 2001 ){
            CGPoint point = [tap locationInView:self.view];
            if (point.x>375/2) {
                
                for (int i=0; i<[arrayOne count]; i++) {
                    info=arrayOne[i];
                    if ([info.sort integerValue]==2&&[info.btnId isEqualToString:@"recommend_entry"]) {
                        break;
                    }else{
                        info=nil;
                    }
                }
                
                switch (self.tagType) {
                    case 1:
                    {
                        URL=info.url==nil?[BBGLaunchManager sharedInstance].diaperAreaURL:info.url;
                        BBGSpecialWebViewController_iPhone * webViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:URL]];
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:webViewController];
                        webViewController.title = @"纸尿裤";
                        
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];
                    }
                    break;
                    case 2:
                    {
                        //                美妆功效
                        BBGBeautyEffectViewController_iPhone *beautyEffectVC = [[BBGBeautyEffectViewController_iPhone alloc]init];
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:beautyEffectVC];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];
                    }
                        break;
                    case 3:
//                        此处保健品
                    {
                        BBGCosmeticBrandViewController_iPhone *beautyEffectVC = [[BBGCosmeticBrandViewController_iPhone alloc]initWithTypeTag:2];
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:beautyEffectVC];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];
                    }
                        break;
                    default:
                        break;
                }
            }else{
                
                for (int i=0; i<[arrayOne count]; i++) {
                    info=arrayOne[i];
                    if ([info.sort integerValue]==1&&[info.btnId isEqualToString:@"recommend_entry"]) {
                        break;
                    }else{
                        info=nil;
                    }
                }
                switch (self.tagType) {
                    case 1:
                    {
                        URL=info.url==nil?[BBGLaunchManager sharedInstance].milkPowderAreaURL:info.url;
                        BBGSpecialWebViewController_iPhone * webViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:URL]];
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:webViewController];
                        webViewController.title = @"奶粉";
                        
                        
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];
                    }
                        break;
                    case 2:
                    {
                        //美妆品牌
                        BBGCosmeticBrandViewController_iPhone *beautyEffectVC = [[BBGCosmeticBrandViewController_iPhone alloc]init];
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:beautyEffectVC];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];
                    }
                        break;
                    case 3:
                    //此处食品
                    {
                        BBGCosmeticBrandViewController_iPhone *beautyEffectVC = [[BBGCosmeticBrandViewController_iPhone alloc]initWithTypeTag:1];
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:beautyEffectVC];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];
                    }
                        break;
                    default:
                        break;
                }
                
            }
        }
}

#pragma mark -----BBGRecommendCellDelegate
- (void)recommendIndexClicked:(NSIndexPath *)indexpath
{
    BBGRecommendProduct *product = [self.maternalOrBeautyResponse.secondsKillProductArray ARRAY_OBJ_AT(indexpath.row-1)];
    
    if(product.isSecKill){
        
        BBGGoodsSeckillViewController_iPhone *goodsSeckillVC = [[BBGGoodsSeckillViewController_iPhone alloc]init];
        goodsSeckillVC.productId = product.productID;
        goodsSeckillVC.activityId = product.activityId;
        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsSeckillVC];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
    }else{
        
        [self buyOrAddInCart:[product.productType integerValue] store:product.store productId:product.productID callback:^(BOOL sucessful) {
            if (sucessful) {
                BBGSettlementViewController_iPhone *settlement = [[BBGSettlementViewController_iPhone alloc] init];
                settlement.buyType = BBGBuyTypeDirect;
                BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:settlement];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];
                
            }
        }];
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
-(void)changeViewController{
    self.tableView.scrollsToTop = NO;
}
#pragma mark -
-(void)loadDataWithMenu:(BBGMenuItem *)menu force:(BOOL)force{
 if ([menu.menuID isEqualToString:@"2222"]||[menu.menuID isEqualToString:@"3333"]||[menu.menuID isEqualToString:@"4444"]) {
    self.tableView.scrollsToTop = YES;
    if (self.maternalOrBeautyResponse == nil) {
    __weak BBGMaternalAndBeautyViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:weakSelf.tableView];

    [weakSelf getMaternalOrBeautyData:^(BOOL isfinished, id response) {
    [weakSelf.tableView stopAnimationWithCompletion:^{
        
      [weakSelf.defaultView dismiss];
        
      [[BBGLoadingTips sharedInstance] hideTips];
                    
      if (isfinished) {
                        weakSelf.maternalOrBeautyResponse = response;
          
                        if ([self.maternalOrBeautyResponse.secondsKillProductArray count] < 20) {
                            isFristHaveTwenty = NO;
                        } else {
                            isFristHaveTwenty = YES;
                            
                        }
                        weakSelf.tableView.showsInfiniteScrolling = isFristHaveTwenty;
          
                        [weakSelf.tableView reloadData];
                        
                    }else{
         if (weakSelf.maternalOrBeautyResponse == nil) {
                            
                            [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf actionTitle:@"重新加载" action:@selector(refresh) WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.tableView];
                            
                        }
      }

    }];
    }];
        
        [weakSelf.tableView refreshData:^(id data){
            
            [weakSelf getMaternalOrBeautyData:^(BOOL isfinished, id response) {
                [weakSelf.tableView stopAnimationWithCompletion:^{
                    [weakSelf.defaultView dismiss];
                    
                    if (isfinished) {
                        weakSelf.maternalOrBeautyResponse.secondsKillProductArray = nil;
                        weakSelf.nowPage = 0;
                        weakSelf.maternalOrBeautyResponse = response;
                        if ([self.maternalOrBeautyResponse.secondsKillProductArray count] < 20) {
                            isFristHaveTwenty = NO;
                        } else {
                            isFristHaveTwenty = YES;
                            
                        }
                        weakSelf.tableView.showsInfiniteScrolling = isFristHaveTwenty;
                        [weakSelf.tableView reloadData];
                        
                    }else{
                        if (weakSelf.maternalOrBeautyResponse == nil) {
                            
                            [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf actionTitle:@"重新加载" action:@selector(refresh) WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
                            
                        }
                    }
                }];
                
            }];
            
        }];
        
        [self.tableView loadMore:^(id data) {
            
            weakSelf.nowPage++;
            [weakSelf getMoreData:^(BOOL isFinished, id response) {
                [weakSelf.tableView stopAnimationWithCompletion:^{
                    if (isFinished) {
                        
                        self.moreRecommendResponse= response;
                        
                        if ([self.moreRecommendResponse.normalPruductArray count]< 20) {
                            isLoadMore = NO;
                        } else {
                            isLoadMore = YES;
                            
                        }
                        
                        
                        [self.maternalOrBeautyResponse.secondsKillProductArray addObjectsFromArray:self.moreRecommendResponse.normalPruductArray];
                        isScrollUp = NO;
                        weakSelf.tableView.showsInfiniteScrolling= isLoadMore;
                        [weakSelf.tableView reloadData];
                        
                        [[BBGLoadingTips sharedInstance]hideTips];
                        
                        
                    }
                }];
            }];
        }];

        
        
   } else {
            return;
   }
  }
}

- (void)contentViewController:(UINavigationController *)controller{
    self.contentViewController = controller;
}


@end
