//
//  BBGComment.h
//  Common
//
//  Created by Holyjoy on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"
#import "BBGReply.h"

@interface BBGComment : BBGResponseDataHandler

/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  评论内容
 */
@property (nonatomic,strong) NSString *commentText;
/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  评论ID(评论回复时使用)
 */
@property (nonatomic,strong) NSString *commentId;
/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  评论时间
 */
@property (nonatomic,strong) NSString *commentTime;
/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  是否购买
 */
@property (nonatomic,strong) NSString *hasOrder;

/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  会员ID
 */
@property (nonatomic,strong) NSString *memberId;
/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  会员名称
 */
@property (nonatomic,strong) NSString *memberName;
/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  会员昵称
 */
@property (nonatomic,strong) NSString *nickName;
/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  货品ID
 */
@property (nonatomic,assign) NSInteger productId;
/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  用户头像URL
 */
@property (nonatomic,strong) NSString *profileImgUrl;

/**
 *  @author holyjoy, 15-04-29 15:04:29
 *
 *  晒单图片URL列表
 */
@property (nonatomic,strong) NSMutableArray *imgUrlListArray;

/**
 *  @author holyjoy, 15-04-29 15:04:29
 *
 *  晒单图片大图URL列表
 */
@property (nonatomic,strong) NSMutableArray *imgHdUrlListArray;
/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  店铺ID
 */
@property (nonatomic,assign) NSString *shopId;
/**
 *  @author holyjoy, 15-04-23 17:04:31
 *
 *  评价人联系方式，如email或用户手机号
 */
@property (nonatomic,strong) NSString *contact;
/**
 *  @author holyjoy, 15-04-29 16:04:11
 *
 *  是否匿名 false、true
 */
@property (nonatomic,strong) NSString *isAnonymous;

/**
 *  @author holyjoy, 15-04-29 16:04:05
 *
 *  评论的回复信息
 */
@property (nonatomic,strong) BBGReply *replyFor;

/**
 *  @author holyjoy, 15-09-28 11:09:20
 *
 *  是否客服
 */
@property (nonatomic,assign) BOOL isESC;


@end
