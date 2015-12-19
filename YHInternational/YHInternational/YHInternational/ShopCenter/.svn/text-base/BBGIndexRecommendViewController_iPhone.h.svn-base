//
//  BBGIndexRecommendViewController_iPhone.h
//  YHInternational
//
//  Created by 黄 灿 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIndexRecommendViewController.h"
#import "BBGBackToTopView.h"
#import "BBGChannelViewController_iPhone.h"
@interface BBGIndexRecommendViewController_iPhone : BBGIndexRecommendViewController<BBGContentProtocol>
{
    NSMutableArray *normalArray;
    
    /**
     *  控制回到顶部按钮的变量
     **/
    float goTopTemp;
    
}

@property (nonatomic, strong)BBGPullTable *tableView;

/**
 *  置顶View
 */
@property (nonatomic, strong)BBGBackToTopView *BackToTopView;

//@property (nonatomic, assign)BOOL isHaveSecKill;

/**
 *  基础数据
 */
@property (nonatomic, strong)BBGIndexRecomendResponse *baseRecommendResponse;

/**
 *  分页单品
 */
@property (nonatomic, strong)BBGIndexRecomendMoreResponse *moreRecommendResponse;

@property (nonatomic,weak)UINavigationController *contentViewController;

/**
 *  是否更多加载
 */
@property (nonatomic, assign)BOOL isLoadMore;


/**
 *  第一个接口是否返回
 */
@property (nonatomic ,assign)BOOL isFirstLoad;

/**
 *  先前的table contentoffSet
 */

@property (nonatomic, assign)float contentOffSet;

/**
 *  table在上滑还是下滑  /YES - 上   No  - 下
 */
@property (nonatomic,assign)BOOL  isUp;
@end
