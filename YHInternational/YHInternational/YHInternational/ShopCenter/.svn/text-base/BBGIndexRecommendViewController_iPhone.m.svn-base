//
//  BBGIndexRecommendViewController_iPhone.m
//  YHInternational
//
//  Created by 黄 灿 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIndexRecommendViewController_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGGoodsSeckillViewController_iPhone.h"
#import "BBGSpecialWebViewController_iPhone.h"
#import "BBGGoodsListViewController_iPhone.h"
#import "BBGPhoneSeckillViewController_iPhone.h"
#import "BBGSettlementViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGLaternCell.h"
#import "AdvCell.h"
#import "BBGNextSecKillCell.h"
#import "BBGIndexProductCell.h"
#import "BBGBrandCell.h"
#import "BBGIndexTitleCell.h"
#import "BBGIndexCenterTitleTableViewCell.h"
#import "BBGSecKillTableViewCell.h"
#import "BBGLaunchManager.h"
#import "PTTimerAppear.h"
#import "BBGSpecialWebViewController_iPhone.h"
#define RequestTime 1
@interface BBGIndexRecommendViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,AdvDelegate,BrandCellDelegate,BBGSecKillDelegate,BBGRecommendCellDelegate>

@end

@implementation BBGIndexRecommendViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    _tableView = [[BBGPullTable alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollsToTop = NO;
    _tableView.notOpenSticky = YES;
    __weak BBGIndexRecommendViewController_iPhone * weakSelf = self;
    //进来加载一遍数据

    normalArray=[[NSMutableArray alloc]init];

    [self.view addSubview:_tableView];

    [[BBGLoadingTips sharedInstance]showLoadingOnView:self.view];
    
    [self getIndexBaseData:^(BOOL isFinished, id response) {
            [[BBGLoadingTips sharedInstance]hideTips];
            [weakSelf.tableView stopAnimationWithCompletion:^{
                if (isFinished) {
                    _isLoadMore=YES;
                    //            _tableView.tableFooterView=[self getFooterView];
                    [weakSelf.defaultView dismiss];
                    weakSelf.baseRecommendResponse=response;
                    [weakSelf.tableView reloadData];
                    [self loadSecondData];
                }
                else
                {
                    if (weakSelf.baseRecommendResponse == nil) {
                        [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf actionTitle:@"重新加载" action:@selector(refresh) WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
                        
                    }
                }
                
            }];
        
    }];

    _BackToTopView = [[BBGBackToTopView alloc]init];
    _BackToTopView.alpha=0;
    _BackToTopView.GoTopBlock=^{
        [weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    };
    [self.view addSubview:_BackToTopView];
    [_BackToTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.bottom.equalTo(self.view.mas_bottom).offset(-55);
        make.size.mas_equalTo(_BackToTopView.frame.size);
    }];
    
    

    [self.tableView loadMore:^(id data) {

        weakSelf.nowPage++;
       [weakSelf getindexMoreData:^(BOOL isFinished, id response) {
           [weakSelf.tableView stopAnimationWithCompletion:^{
               if (isFinished) {
                   self.moreRecommendResponse= response;
                   if ([self.moreRecommendResponse.normalPruductArray count]<20) {
                       _isLoadMore=NO;
                   }
                   else
                   {
                       _isLoadMore=YES;
                   }
                   [normalArray addObjectsFromArray:self.moreRecommendResponse.normalPruductArray];
                   [weakSelf.tableView reloadData];
                
                   weakSelf.tableView.showsInfiniteScrolling=_isLoadMore;
                   [[BBGLoadingTips sharedInstance]hideTips];
               }
           }];
           
       }];
        
    }];
    
    [self.tableView refreshData:^(id data) {
        
        /**
         *  若请求相隔时间在固定的时间内，则不去请求
         *  主要是防止秒杀cell同一时间诸多cell一起回调来请求接口
         */
        NSDate *date = [NSDate date];
        NSTimeInterval dis = [date timeIntervalSince1970];
        NSString * disStr = [NSString stringWithFormat:@"%i", (int)dis];
        long long a = [disStr longLongValue];
        NSLog(@"----------------%ld",self.lastRequestTime);
        if ((a-self.lastRequestTime)<=RequestTime) {
            self.lastRequestTime = a;
            [self.tableView stopAnimation];
            return;
        }
        self.lastRequestTime = a;

        
        weakSelf.nowPage=0;
        [weakSelf getIndexBaseData:^(BOOL isFinished, id response) {
            [weakSelf.tableView stopAnimation];
            if (isFinished) {
                [normalArray removeAllObjects];
                weakSelf.baseRecommendResponse=response;
                [weakSelf.tableView reloadData];
                [self loadSecondData];
                weakSelf.tableView.showsInfiniteScrolling=YES;
                _isLoadMore=YES;
//                _tableView.tableFooterView=[self getFooterView];
            }
            else
            {
                if (weakSelf.baseRecommendResponse == nil) {
                    [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf actionTitle:@"重新加载" action:@selector(refresh) WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
                    
                }
            }
        }];
        


    }];
    
//    [_tableView triggerPullToRefresh];
    // Do any additional setup after loading the view.

    //注册一个通知，避免定时器在后台被杀掉导致再次进来程序的时候秒杀时间误差
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(reloadData:) name:@"IndexReloadData" object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchEventWithEventId:(id)sender{
    
}

#pragma mark- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            if ([self.baseRecommendResponse.announcementArray count]>0||[self.baseRecommendResponse.advArray count]>0) {
                return 5.0f;
            }
            
        }
            break;
        
        case 2:
        {
            if ([self.baseRecommendResponse.SecKillArray count]>0&&[self.baseRecommendResponse.mainAdArray count]>0) {
                return 5.0f;
            }
            
        }
            break;
            
        case 3:
        {
            if ([self.baseRecommendResponse.mainAdArray count]>0&&[self.baseRecommendResponse.mainPruductArray count]>0) {
                return 5.0f;
            }
            
        }
            break;
            
            
        case 4:
        {
            if ([self.baseRecommendResponse.mainPruductArray count]>0&&[self.baseRecommendResponse.normalAd count]>0) {
                return 5.0f;
            }
            
        }
            break;
            
            
        case 5:
        {
            if ([self.baseRecommendResponse.normalAd count]>0&&[self.moreRecommendResponse.normalPruductArray count]>0) {
                return 5.0f;
            }
            
        }
            break;
            
            
        case 6:
        {
            return 5.0f;
            
        }
            break;
            
        case 1:
        {
            return 5.0f;
            
        }
            break;
            
        default:
            break;
    }
    
    return 0.1f;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
}

//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    NSArray *array=[NSArray arrayWithObjects:[UIColor redColor],[UIColor greenColor],[UIColor yellowColor],[UIColor blackColor],[UIColor blueColor],[UIColor brownColor],[UIColor darkGrayColor], nil];
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 5)];
//    view.backgroundColor=array[section];
//    return view;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     *  知会对应cell的比例
     **/
    switch (indexPath.section) {
        case 0:
        {
            NSInteger index=indexPath.row;
            if ([self.baseRecommendResponse.advArray count]==0) {
                index=1;
            }
            switch (index) {
                case 0:
                {
                    if (IPHONE_WIDTH == 320) {
                        return 133;
                    }else if (IPHONE_WIDTH == 375){
                        return 155;
                    }else{
                        return 171;
                    }
                }
                    break;
                case 1:
                    return 33;
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        case 1:
            return 85;
            break;
        case 2:
        {
            if (indexPath.row==[self.baseRecommendResponse.SecKillArray count]+1) {
                return 40;
            }
            switch (indexPath.row) {
                case 0:
                    return 40;
                    break;
                default:
                    return 135;
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                    return IPHONE_WIDTH*80/375;
                    break;
                case 1:
                {
                    int a=(IPHONE_WIDTH-5)/2/37*25+5;
                    return a;
                }
                    break;
                default:
                {
                    int a=IPHONE_WIDTH/375*160+5;
                    return a;
                    
                }
                    break;
            }
        }
            break;
        case 4:
        {
            switch (indexPath.row) {
                case 0:
                    return 40;
                    break;
                    
                default:
                {
                    int a=IPHONE_WIDTH/375*140;
                    return a;
                    
                }
                    break;
            }
            
        }
            break;
        case 5:
        {
            switch (indexPath.row) {
                case 0:
                    return 40;
                    break;
                    
                default:
                {
                    int a=IPHONE_WIDTH/375*160+5;
                    return a;
                    
                }
                    break;
            }
        }
            break;
        default:
        {
            switch (indexPath.row) {
                case 0:
                    return 40;
                    break;
                    
                default:
                {
               
                    int a=IPHONE_WIDTH/375*140;
                    return a;
                }
                    break;
            }
        }
            break;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.baseRecommendResponse) {
        return 0;
    }
    /**
     *  判断是否对应的模块有数据再对应返回相应的section中cell的数量
     **/
    switch (section) {
        case 0:
        {
            
            BOOL a=[self.baseRecommendResponse.announcementArray count]==0;
            BOOL b=[self.baseRecommendResponse.advArray count]==0;
            if (a&&b) {
                return 0;
            }else if (!a&&!b) {
                return 2;
            }else{
                return 1;
            }
            
        }
            break;
        case 6:
        {
            if ([normalArray count]!=0) {
                return  [normalArray count]+1;
            }
            else
            {
                return 0;
            }
        }
            break;
        case 1:
            return 1;
            break;
        case 2:
        {
            
            if([self.baseRecommendResponse.SecKillArray count]!=0){
                return 2+[self.baseRecommendResponse.SecKillArray count];
            }
            else
            {
                return 0;
            }
        }
            break;
        case 3:
            return 2+[self.baseRecommendResponse.mainAdArray count];
            break;
        case 4:
        {
            if ([self.baseRecommendResponse.mainPruductArray count]!=0) {
                return [self.baseRecommendResponse.mainPruductArray count]+1;
            }
            else
            {
                return 0;
            }
        }
            break;
            
        case 5:
        {
            if ([self.baseRecommendResponse.normalAd count]!=0) {
                return [self.baseRecommendResponse.normalAd count]+1;
            }
            else
            {
                return 0;
            }
        }
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
        {
            NSInteger index=indexPath.row;
            //换一下以便显示正确的cell(在没有轮播图的时候就去显示广播)
            if ([self.baseRecommendResponse.advArray count]==0) {
                index=1;
            }
            switch (index) {
                case 0:
                {
                    AdvCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AdvCell"];
                    if (cell == nil) {
                        cell = [[AdvCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AdvCell"];
                        cell.delegate = self;
                    }
                    if (self.baseRecommendResponse.advArray) {
                        [cell updateCell:self.baseRecommendResponse.advArray];
                    }
                    return cell;

                }
                    break;
                case 1:
                {
                    BBGLaternCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BBGLaternCell"];
                    if(cell == nil){
                        cell = [[BBGLaternCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBGLaternCell"];
                    }

                    if (self.baseRecommendResponse.announcementArray) {
                        [cell updateCell:self.baseRecommendResponse.announcementArray];
                    }
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
                default:
                    return [UITableViewCell new];
                    break;
            }
        }
            break;
        case 1:
        {
            BBGBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGBrand"];
            if (!cell) {
                cell = [[BBGBrandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBGBrand"];
            }
            cell.delegate=self;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell updateCell:self.baseRecommendResponse.brandInit isUp:_isUp];
            return cell;
        }
            break;
        case 2:
        {

            if (indexPath.row==[self.baseRecommendResponse.SecKillArray count]+1) {
                BBGNextSecKillCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BBGNextSecKillCell"];
                if (!cell) {
                    cell = [[BBGNextSecKillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBGNextSecKillCell"];
                }
                
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }
            
            if (indexPath.row==0) {
                BBGIndexCenterTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectitleCell"];
                if (!cell) {
                    cell = [[BBGIndexCenterTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SectitleCell"];
                    [cell setSeckillTitleCell];
                }
                
                return cell;
            }
            

            
            BBGSecKillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGSeckill"];
            if (!cell) {
                cell = [[BBGSecKillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBGSeckill"];
            }
            cell.indexpath = indexPath;
            cell.delegate = self;
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            [cell updateCell:self.baseRecommendResponse.SecKillArray[indexPath.row-1] isUp:_isUp];
            WS(weakSelf);
            cell.timerDone= ^ {
                [weakSelf refresh];
            };
            return cell;
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendAndPhone"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendAndPhone"];
                    
                        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH*80/375)];
                        imageView.image=[UIImage imageNamed:@"newRecommendAnd"];
                        imageView.tag=1001;
                        imageView.userInteractionEnabled=YES;
                        imageView.backgroundColor=[UIColor redColor];
                        [cell.contentView addSubview:imageView];
                        [imageView setFadeInWithDefaultTime];
//                        
//                        cell.layer.borderColor=[[UIColor redColor]CGColor];
//                        cell.layer.borderWidth=1;
                        
                        UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 0.5)];
                        lineView1.backgroundColor=UIColorFromHexadecimalRGB(0xe5e5e5);
                        [cell.contentView addSubview:lineView1];
                        
                        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(IPHONE_WIDTH/2-0.5, 20, 1, 40)];
                        lineView.backgroundColor=UIColorFromHexadecimalRGB(0xe5e5e5);
                        [cell.contentView addSubview:lineView];
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        
                        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(init:)];
                        [imageView addGestureRecognizer:gesture];
                        
                        
                    }
                        return cell;
                        
                    
                }
                    break;
                case 1:
                {
                    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"mother"];
                    if (!cell) {
                        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mother"];
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        cell.contentView.backgroundColor=[UIColor whiteColor];
                        UIImageView *leftimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH/2-2.5, (IPHONE_WIDTH-5)/2/37*25)];
                        
                        leftimageView.tag=1003;
                        [cell.contentView addSubview:leftimageView];
                        [leftimageView setFadeInWithDefaultTime];
                        UIImageView *rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(IPHONE_WIDTH/2+2.5, 0, IPHONE_WIDTH/2-2.5, (IPHONE_WIDTH-5)/2/37*25)];
                        rightImageView.tag=1004;
                        [cell.contentView addSubview:rightImageView];
                        [rightImageView setFadeInWithDefaultTime];
                        
                        
                        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(init:)];
                        UITapGestureRecognizer *_gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(init:)];
                        [leftimageView addGestureRecognizer:gesture];
                        [rightImageView addGestureRecognizer:_gesture];
                        leftimageView.userInteractionEnabled=YES;
                        rightImageView.userInteractionEnabled=YES;
                    }
                    NSString *leftUrl,*rightUrl;
                    for (int i=0; i<[self.baseRecommendResponse.brandInit count]; i++) {
                        BBGIndexRecomendInitInfo *info = self.baseRecommendResponse.brandInit[i];
                        if ([info.btnId isEqualToString:@"recommend_entry"]) {
                            if ([info.sort integerValue]==1) {
                                leftUrl=info.img;
                            }
                            if ([info.sort integerValue]==2) {
                                rightUrl=info.img;
                            }
                        }
                        
                    }
                    for (UIImageView *imageview in cell.contentView.subviews) {
                        if (imageview.tag==1003) {
                            [imageview sd_setImageWithURL:[NSURL URLWithString:leftUrl] placeholderImage:[UIImage imageNamed:@"matherDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                if (cacheType ==SDImageCacheTypeNone) {
                                    [imageview setFadeInWithDefaultTime];
                                }

                            }];
                        }
                        if (imageview.tag==1004) {
                            [imageview sd_setImageWithURL:[NSURL URLWithString:rightUrl] placeholderImage:[UIImage imageNamed:@"matherDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                if (cacheType ==SDImageCacheTypeNone) {
                                    [imageview setFadeInWithDefaultTime];
                                }

                            }];
                        }
                    }
                    return cell;
                }
                    break;
                default:
                {
                    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RecommendAd"];
                    
                    if (!cell) {
                        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendAd"];
                        cell.selectionStyle=UITableViewCellSelectionStyleNone;
                        cell.contentView.backgroundColor=[UIColor whiteColor];
                        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH/375*160)];
                        imageView.tag=1101;
                        [cell.contentView addSubview:imageView];
                    }
                    for (UIImageView *ImgView in cell.contentView.subviews) {
                        if (ImgView.tag==1101) {
                            ImgView.image=nil;
                            BBGAdvProduct *product = self.baseRecommendResponse.mainAdArray[indexPath.row-2];
                            [ImgView sd_setImageWithURL:[NSURL URLWithString:product.adImg] placeholderImage:[UIImage imageNamed:@"defaultImageCenter"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                [ImgView setFadeInWithDefaultTime];
                            }];
                        }
                    }
                    
                    return cell;
                }
                    break;
            }
        }
            break;
        case 4:
        {
            if (indexPath.row==0) {
                BBGIndexTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
                if (!cell) {
                    cell = [[BBGIndexTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [cell updateTitle:@"海外TOP榜"];
                [cell dismissBottomLine];
                return cell;
            }
            BBGIndexProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendGoods"];
            if (!cell) {
                
                cell = [[BBGIndexProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendGoods"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.delegate=self;
            cell.indexpath=indexPath;
            [cell updateCell:self.baseRecommendResponse.mainPruductArray[indexPath.row-1] isUp:_isUp];
            return cell;
        }
            break;
        case 5:
        {
            if (indexPath.row==0) {
                BBGIndexTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
                if (!cell) {
                    cell = [[BBGIndexTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [cell updateTitle:@"热门活动"];
                [cell dismissBottomLine];
                return cell;
            }
            //这里判断是不是普通广告,用前多少个来判断（或者用数据类型来判断）
            //以下做测试，随意判断,复用推荐广告

            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RecommendAd"];
            
            if (!cell) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendAd"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor=[UIColor whiteColor];
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH/375*160)];
                imageView.tag=1101;
                [cell.contentView addSubview:imageView];
                [imageView setFadeInWithDefaultTime];
            }
            for (UIImageView *ImgView in cell.contentView.subviews) {
                if (ImgView.tag==1101) {
                    ImgView.image=nil;
                    BBGAdvProduct *product = self.baseRecommendResponse.normalAd[indexPath.row-1];
                    [ImgView sd_setImageWithURL:[NSURL URLWithString:product.adImg] placeholderImage:[UIImage imageNamed:@"defaultImageCenter"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (cacheType ==SDImageCacheTypeNone) {
                            [ImgView setFadeInWithDefaultTime];
                        }

                    }];
                }
            }
            
          
            

            
            return cell;

     
        }
            break;
        case 6:
        {
            if (indexPath.row==0) {
                BBGIndexTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
                if (!cell) {
                    cell = [[BBGIndexTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [cell updateTitle:@"优选单品"];
                [cell dismissBottomLine];
                return cell;
            }
            BBGIndexProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendGoods"];
            if (!cell) {
                
                cell = [[BBGIndexProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendGoods"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.delegate=self;
            cell.indexpath=indexPath;
            [cell updateCell:normalArray[indexPath.row-1] isUp:_isUp];
            return cell;
            
            
        }
            break;
        default:
            return [UITableViewCell new];
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            if(indexPath.row==0)
            {
              return;
            }
            if (indexPath.row==[self.baseRecommendResponse.SecKillArray count]+1) {
                /**
                 *  去秒杀专区
                 */
                BBGPhoneSeckillViewController_iPhone *seckill = [[BBGPhoneSeckillViewController_iPhone alloc]init];
                BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:seckill];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];
                return;
            }
            /*!
             *  秒杀单品
             */
            BBGSecKillProduct * product = self.baseRecommendResponse.SecKillArray[indexPath.row-1];
            
            //判断是是否为秒杀商品
            if(product.isSecKill){
                NSLog(@"进秒杀详情");
                BBGGoodsSeckillViewController_iPhone *goodsSeckillVC = [[BBGGoodsSeckillViewController_iPhone alloc]init];
                goodsSeckillVC.productId = product.productId;
                goodsSeckillVC.activityId = product.activityId;
                BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsSeckillVC];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];

            }else{
                BBGGoodsDetailViewController_iPhone * goodsDetailViewController = [[BBGGoodsDetailViewController_iPhone alloc]init];
                goodsDetailViewController.productId = product.productId;
                BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsDetailViewController];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];
                
            }

            
        }
            break;
        case 3:
        {
            if (indexPath.row==0||indexPath.row==1) {
                return;
            }
            
            BBGAdvProduct * advProduct = self.baseRecommendResponse.mainAdArray[indexPath.row-2];
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
                    //判断是是否为秒杀商品
                    if(advProduct.isSecKill){
                        NSLog(@"进秒杀详情");
                        BBGGoodsSeckillViewController_iPhone *goodsSeckillVC = [[BBGGoodsSeckillViewController_iPhone alloc]init];
                        goodsSeckillVC.productId = advProduct.productId;
                        goodsSeckillVC.activityId = advProduct.activityId;
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsSeckillVC];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];

                    }else{
                        BBGGoodsDetailViewController_iPhone * goodsDetailViewController = [[BBGGoodsDetailViewController_iPhone alloc]init];
                        goodsDetailViewController.productId = advProduct.productID;
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsDetailViewController];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];
                    }

                    
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
            break;
        case 4:
        {
            if(indexPath.row==0)
            {
                return;
            }
            /*!
             *  推荐单品
             */
            BBGRecommendProduct * product = self.baseRecommendResponse.mainPruductArray[indexPath.row-1];
            
            //判断是是否为秒杀商品
            if(product.isSecKill){
                NSLog(@"进秒杀详情");
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
        case 5:
        {
            if (indexPath.row==0) {
                return;
            }
            
            BBGAdvProduct * advProduct = self.baseRecommendResponse.normalAd[indexPath.row-1];
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
                    //判断是是否为秒杀商品
                    if(advProduct.isSecKill){
                        NSLog(@"进秒杀详情");
                        BBGGoodsSeckillViewController_iPhone *goodsSeckillVC = [[BBGGoodsSeckillViewController_iPhone alloc]init];
                        goodsSeckillVC.productId = advProduct.productId;
                        goodsSeckillVC.activityId = advProduct.activityId;
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsSeckillVC];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];

                    }else{
                        BBGGoodsDetailViewController_iPhone * goodsDetailViewController = [[BBGGoodsDetailViewController_iPhone alloc]init];
                        goodsDetailViewController.productId = advProduct.productID;
                        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsDetailViewController];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                            
                        }];
                    }

                    
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
            break;
        case 6:
        {
            if (indexPath.row==0) {
                return;
            }
            /*!
             *  普通单品
             */
            BBGRecommendProduct * product = normalArray[indexPath.row-1];
            if(product.isSecKill){
                NSLog(@"进秒杀详情");
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
    return 7;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 50)];
//    if (section==6&&self.baseRecommendResponse) {
//        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shoppingOnYunhou"]];
//        imageView.contentMode=UIViewContentModeScaleAspectFit;
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(IPHONE_WIDTH, 50));
//            
//        }];
//        [view addSubview:imageView];
//        
//        view.layer.borderColor=[[UIColor redColor]CGColor];
//        view.layer.borderWidth=1;
//        return view;
//        
//    }
//    return view;
//}

- (UIView *)getHeaderView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 0.5)];
    return view;
}
- (UIView *)getFooterView{
    UIView *view;
    
    if (_isLoadMore) {
        view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 0.5)];
    }else{
        view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 55)];
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shoppingOnYunhou"]];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.frame=CGRectMake(0, 0, IPHONE_WIDTH, 50);
        [view addSubview:imageView];
    }
    return view;
  
}
#pragma mark- advDelegate
- (void)didSelected:(int)currentPage{
    /**
     *  判断具体类型来具体跳转
     *
     *  @return nil
     */

    
    BBGAdvProduct * advProduct = [self.baseRecommendResponse.advArray ARRAY_OBJ_AT(currentPage)];
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
            //判断是否为秒杀商品
            if (advProduct.isSecKill) {
                BBGGoodsSeckillViewController_iPhone *goodsSeckillVC = [[BBGGoodsSeckillViewController_iPhone alloc]init];
                goodsSeckillVC.productId = advProduct.productId;
                goodsSeckillVC.activityId = advProduct.activityId;
                BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsSeckillVC];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];
            }else{
                BBGGoodsDetailViewController_iPhone * goodsDetailViewController = [[BBGGoodsDetailViewController_iPhone alloc]init];
                goodsDetailViewController.productId = advProduct.productID;
                BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsDetailViewController];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];
            }

            
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
#pragma mark- brandcelldelegate
- (void)WhichPartSelect:(int)index{
    /**
     *  品牌的响应事件
     */
    NSString *URL,*Name;
    BBGIndexRecomendInitInfo *info;
    NSMutableArray *arrayOne = [NSMutableArray array];
    for (int i=0; i<[self.baseRecommendResponse.brandInit count]; i++) {
        info = self.baseRecommendResponse.brandInit[i];
        if ([info.btnId isEqualToString:@"brand_service"]) {
            [arrayOne addObject:info];
        }else{
            info=nil;
        }
    }

    switch (index) {
        case 0:
        {
            for (int i=0; i<[arrayOne count]; i++) {
                info=arrayOne[i];
                if ([info.sort integerValue]==1) {
                    break;
                }else{
                    info=nil;
                }
            }
            URL=info.url==nil?[BBGLaunchManager sharedInstance].globalDirectMiningURL:info.url;
            Name=info.Name;
        }
            break;
        case 1:
        {
            for (int i=0; i<[arrayOne count]; i++) {
                info=arrayOne[i];
                if ([info.sort integerValue]==2) {
                    break;
                }else{
                    info=nil;
                }
            }
            URL=info.url==nil?[BBGLaunchManager sharedInstance].genuineGuaranteeURL:info.url;
            Name=info.Name;
        }
            break;
        case 2:
        {
            for (int i=0; i<[arrayOne count]; i++) {
                info=arrayOne[i];
                if ([info.sort integerValue]==3) {
                    break;
                }else{
                    info=nil;
                }
            }
            URL=info.url==nil?[BBGLaunchManager sharedInstance].freeSaleURL:info.url;
            Name=info.Name;
        }
            break;
        case 3:
        {
            for (int i=0; i<[arrayOne count]; i++) {
                info=arrayOne[i];
                if ([info.sort integerValue]==4) {
                    break;
                }else{
                    info=nil;
                }
            }
            URL=info.url==nil?[BBGLaunchManager sharedInstance].domesticSalesURL:info.url;

            Name=info.Name;
        }
            break;
        default:
            break;
    }
    
    
    /**
     *  url
     */
    BBGSpecialWebViewController_iPhone * webViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:URL]];
    BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:webViewController];
    webViewController.title = Name;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        
    }];
}
#pragma mark- bbgSecKillDelegate
- (void)indexClicked:(NSIndexPath *)indexpath{
    /**
     *  秒杀购物车的点击
     *
     *  @return  nil
     */
    BBGSecKillProduct *seckill = self.baseRecommendResponse.SecKillArray[indexpath.row-1];
    //如果是秒杀商品 则点击购物车类图标直接跳秒杀详情
    if (seckill.isSecKill) {
        BBGGoodsSeckillViewController_iPhone *goodsSeckillVC = [[BBGGoodsSeckillViewController_iPhone alloc]init];
        goodsSeckillVC.productId = seckill.productId;
        goodsSeckillVC.activityId = seckill.activityId;
        BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:goodsSeckillVC];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
    }else{
        [self buyOrAddInCart:[seckill.productType integerValue] store:[seckill.store integerValue] productId:seckill.productId callback:^(BOOL sucessful) {
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


#pragma mark- bbgRecommendDelegate
- (void)recommendIndexClicked:(NSIndexPath *)indexpath{
    /**
     *  推荐商品的点击
     *
     *  @return  nil
     */
    BBGRecommendProduct *product;
    if (indexpath.section==6) {
        product = normalArray[indexpath.row-1];
    }
    else
    {
        product = self.baseRecommendResponse.mainPruductArray[indexpath.row-1];
    }
    
    
    //如果是秒杀商品 则点击购物车类图标直接跳秒杀详情
    if (product.isSecKill) {
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
#pragma mark - initCliced
- (void)init:(UITapGestureRecognizer *)sender{
    /**
     *  固定入口的点击
     *  1001-新品推荐
     *  1002-手机专享
     *  1003-奶粉
     *  1004-纸尿裤
     */
    BBGIndexRecomendInitInfo *info;
    
    switch (sender.view.tag) {
        case 1001:
        {
            CGPoint point = [sender locationInView:self.view];
            if (point.x>375/2) {
                /*!
                 *  手机专享
                 *
                 */
                BBGGoodsListViewController_iPhone *goodsList = [[BBGGoodsListViewController_iPhone alloc] init];
                goodsList.sourceViewController = BBGPhoneExtraController;
                goodsList.title = @"手机专享";
                BBGNavigationController * nav = [[BBGNavigationController alloc] initWithRootViewController:goodsList];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];
            }
            else
            {
                /*!
                 *  新品推荐
                 *
                 */
                BBGGoodsListViewController_iPhone *goodsList = [[BBGGoodsListViewController_iPhone alloc] init];
                goodsList.sourceViewController = BBGPhoneRecommendController;
                goodsList.title = @"新品推荐";
                BBGNavigationController * nav = [[BBGNavigationController alloc] initWithRootViewController:goodsList];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                    
                }];

            }
        }
            break;
//        case 1002:
//        {
//            NSLog(@"手机专享");
//        }
//            break;
        case 1003:
        {
            for (int i=0; i<[self.baseRecommendResponse.brandInit count]; i++) {
                info = self.baseRecommendResponse.brandInit[i];
                if ([info.btnId isEqualToString:@"recommend_entry"]&&[info.sort integerValue]==1) {
                    break;
                }else{
                    info=nil;
                }
            }
            
            BBGSpecialWebViewController_iPhone * webViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:info.url==nil?[BBGLaunchManager sharedInstance].milkPowderAreaURL:info.url]];
            BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:webViewController];
            webViewController.title = info.Name;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                
            }];
            
        }
            break;
        case 1004:
        {

            for (int i=0; i<[self.baseRecommendResponse.brandInit count]; i++) {
                info = self.baseRecommendResponse.brandInit[i];
                if ([info.btnId isEqualToString:@"recommend_entry"]&&[info.sort integerValue]==2) {
                    break;
                }else{
                    info=nil;
                }
            }
            
            BBGSpecialWebViewController_iPhone * webViewController = [[BBGSpecialWebViewController_iPhone alloc]initWithURL:[NSURL URLWithString:info.url==nil?[BBGLaunchManager sharedInstance].diaperAreaURL:info.url]];
            BBGNavigationController * nav = [[BBGNavigationController alloc]initWithRootViewController:webViewController];
            webViewController.title = info.Name;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - table scroller
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y>0.8*IPHONE_HEIGHT) {
        _BackToTopView.alpha=1;
    }
    else
    {
        _BackToTopView.alpha=0;
    }
    if (scrollView.contentOffset.y>_contentOffSet) {
        _isUp = YES;
    }else{
        _isUp = NO;
    }
    
    _contentOffSet = scrollView.contentOffset.y;
}





- (void)refresh{
    __weak BBGIndexRecommendViewController_iPhone * weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self getIndexBaseData:^(BOOL isfinished, id response) {
        [weakSelf dismissDefaultView];
        [[BBGLoadingTips sharedInstance]hideTips];
        if (isfinished) {
            weakSelf.baseRecommendResponse = response;
            [weakSelf.tableView reloadData];
            [self loadSecondData];
        }
        else
        {
            if (weakSelf.baseRecommendResponse == nil) {
                [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf actionTitle:@"重新加载" action:@selector(refresh) WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
                
            }
        }

    }];
}


#pragma mark -
-(void)loadDataWithMenu:(BBGMenuItem *)menu force:(BOOL)force{
    if ([menu.menuID integerValue]==1111) {
        _tableView.scrollsToTop = YES;
    }else{
        _tableView.scrollsToTop = NO;
    }
}
-(void)changeViewController{
    _tableView.scrollsToTop = NO;
}


- (void)contentViewController:(UINavigationController *)controller{
    self.contentViewController = controller;
}

- (void)loadSecondData{
    __weak BBGIndexRecommendViewController_iPhone * weakSelf = self;
    self.nowPage++;
    [self getindexMoreData:^(BOOL isFinished, id response) {
        if (isFinished) {
            self.moreRecommendResponse= response;
            if ([self.moreRecommendResponse.normalPruductArray count]<20) {
                _isLoadMore=NO;
            }
            else
            {
                _isLoadMore=YES;
            }
            [normalArray addObjectsFromArray:self.moreRecommendResponse.normalPruductArray];
             weakSelf.tableView.showsInfiniteScrolling=_isLoadMore;
            [weakSelf.tableView reloadData];
           
            if (_isFirstLoad) {
                [[BBGLoadingTips sharedInstance]hideTips];
            }

        }
        
    }];

}
- (void)reloadData:(NSNotification *)notifacation{
    NSIndexSet * SecSection=[[NSIndexSet alloc]initWithIndex:2];
    [self.tableView reloadSections:SecSection withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
