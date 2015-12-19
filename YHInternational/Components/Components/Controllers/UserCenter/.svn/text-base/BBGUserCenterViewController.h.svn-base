//
//  BBGUserCenterViewController.h
//  Components
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGUserCenterViewController : BBGViewController

@property (nonatomic,strong) BBGUserDetailInfo *userDetailInfo;

/**
 *  用户昵称
 */
@property (nonatomic,strong) NSString *nickName;

/**
 *  待付款订单数
 */
@property (nonatomic, assign) NSInteger unpaidOrderCount;
/**
 *  待收货订单数
 */
@property (nonatomic, assign) NSInteger logisticsCount;
/**
 *  待发货数量
 */
@property (nonatomic, assign) NSInteger waitSendGoodsCount;


/**
 *  评论晒单个数
 */
@property (nonatomic, assign) NSInteger countsForShareOrder;


/**
 *  获取用户资料：昵称、头像地址
 *
 *  @param callback 回调
 */
- (void)getUserInfo:(LoadDataCallback)callback;
/**
 *  获取订单数目信息
 *
 *  @param callback 回调
 */
- (void)getOrderCountInfo:(LoadDataCallback)callback;

/**
 *  用户头像
 */
@property (nonatomic,strong) NSString* headImg;


/**
 *  上传用户头像
 *
 *  @param img             <#img description#>
 *  @param callback        <#callback description#>
 *  @param uploadDataBlock <#uploadDataBlock description#>
 */
- (void)uploadUserHeadImg:(UIImage*)img callBack:(LoadDataCallback)callback data:(UploadDataBlock)uploadDataBlock;

/**
 *  设置用户头像
 *
 *  @param callback <#callback description#>
 */
- (void)setUserHeadImg:(LoadDataCallback)callback;



/**
 *  获取个人中心页面统计信息
 *
 *  @param callback <#callback description#>
 */
- (void)getUserCount:(LoadDataCallback)callback;


/**
 *  获取评论晒单个数
 *
 *  @param callback <#callback description#>
 */
- (void)getCommentDetailCount:(LoadDataCallback)callback;

@end
