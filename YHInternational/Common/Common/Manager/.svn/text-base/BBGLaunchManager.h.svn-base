//
//  BBGLaunchManager.h
//  Common
//
//  Created by Damon on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGLaunchTask.h"
#import "BBGMacro.h"
#import <UIKit/UIKit.h>
#import "BBGConfigureResponse.h"
@interface BBGLaunchManager : NSObject<BBGLaunchTask>

+(BBGLaunchManager *)sharedInstance;

@property (nonatomic, strong) NSMutableArray *launchQueue;

@property (nonatomic, copy) BBGLaunchTaskFinished taskFinished;

@property (nonatomic, strong) NSDate * date;
/**
 *  启动图
 */
@property (nonatomic, strong) UIImageView * launchImageView;
/*!
 *  地址版本号
 */
@property (nonatomic, strong) NSString * areaVersion;

/*!
 *  是否打开更新开关
 */
@property (nonatomic, assign) BOOL openUpdateSwitch;

/*!
 *  是否打开首次安装红包开关
 */
@property (nonatomic, assign) BOOL firstBenifitSwitch;

/*!
 *  支付打开红包开关
 */
@property (nonatomic, assign) BOOL payBeniftSwitch;

/**
 *  融云Id
 */
@property (nonatomic, strong) NSString * rongCloudId;

/**
 *  融云token
 */
@property (nonatomic, strong) NSString * rongToken;

/**
 *  全球直采
 */
@property (nonatomic,strong) NSString *globalDirectMiningURL;

/**
 *  正品保证
 */
@property (nonatomic,strong) NSString *genuineGuaranteeURL;

/**
 *  免税特卖
 */
@property (nonatomic,strong) NSString *freeSaleURL;

/**
 *  国内售后
 */
@property (nonatomic,strong) NSString *domesticSalesURL;

/**
 *  纸尿裤专区
 */
@property (nonatomic,strong) NSString *diaperAreaURL;

/**
 *  奶粉专区
 */
@property (nonatomic,strong) NSString *milkPowderAreaURL;

/**
 *  联系客服
 */
@property (nonatomic,strong) NSString *contactURL;

/**
 *  联系客服是否打开
 */
@property (nonatomic,assign) BOOL isOpenContactURL;

/**
 *  电信免流量URL
 *  有值时就显示，没有就不显示
 */
@property (nonatomic,strong) NSString *telecomFlowURL;

/**
 *  主题资源目录
 */
@property (nonatomic,strong) NSString *themeName;

/**
 *  动画呈现View
 */
@property (nonatomic,weak) UIView * mainView;

/**
 *  任务是否失败
 */
@property (nonatomic,assign) BOOL taskError;

/**
 *  搜索框文字
 */
@property (nonatomic,strong) NSString *searchText;

/**
 *  支付完成抽奖活动开头
 */
@property (nonatomic,assign) BOOL payActivitySwitch;

/**
 *  支付完成抽奖活动H5标题
 */
@property (nonatomic,strong) NSString *payActivityTitle;

/**
 *  支付完成抽奖活动URL
 */
@property (nonatomic,strong) NSString *payActivityURL;

/**
 *  支付完成抽奖活动图片
 */
@property (nonatomic,strong) NSString *payActivityImage;

/**
 *  任意门
 */
@property (nonatomic,assign) BOOL urlDoorSwitch;

/**
 *  任意门H5标题
 */
@property (nonatomic,strong) NSString *urlDoorTitle;

/**
 *  任意门URL
 */
@property (nonatomic,strong) NSString *URL_DOOR;

/**
 *  任意门图片
 */
@property (nonatomic,strong) NSString *urlDoorImage;

- (void)addTask:(id<BBGLaunchTask>)task;
- (void)removeTask:(id<BBGLaunchTask>)task;

- (void)launch;


@end
