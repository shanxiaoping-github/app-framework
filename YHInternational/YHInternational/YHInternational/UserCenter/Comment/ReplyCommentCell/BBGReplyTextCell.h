//
//  BBGReplyTextCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/4/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGReplyReferenceTextView.h"
#import "BBGComment.h"
#import "BBGReply.h"

@interface BBGReplyTextCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
/**
 *  @author holyjoy, 15-05-04 17:05:14
 *
 *  回复内容
 */
@property (strong, nonatomic) IBOutlet UILabel *replyLabel;
/**
 *  @author holyjoy, 15-05-04 17:05:18
 *
 *  回复引用的评论显示view
 */
@property (strong, nonatomic) IBOutlet BBGReplyReferenceTextView *replyReferenceTextView;
/**
 *  @author holyjoy, 15-05-04 17:05:02
 *
 *  回复人头像
 */
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
/**
 *  @author holyjoy, 15-05-04 17:05:55
 *
 *  谁回复了谁
 */
@property (strong, nonatomic) IBOutlet UILabel *replyNameToNameLabel;
/**
 *  @author holyjoy, 15-05-04 17:05:46
 *
 *   回复时间
 */
@property (strong, nonatomic) IBOutlet UILabel *replyTimeLabel;
/**
 *  @author holyjoy, 15-09-23 14:09:54
 *
 *  是否购买
 */
@property (strong, nonatomic) IBOutlet UIImageView *isBuyImageView;
//是否客服
@property (assign, nonatomic) BOOL isESC;
//引用视图高度约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *replyHeightContrains;

- (void)updateCell:(BBGComment *)comment replyText:(BBGReply *)reply;

+ (CGFloat)cellHeignt:(BBGComment *)comment replyText:(BBGReply *)reply;
@end
