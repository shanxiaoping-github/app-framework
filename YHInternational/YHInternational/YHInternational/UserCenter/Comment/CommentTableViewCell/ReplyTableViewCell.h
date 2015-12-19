//
//  ReplyTableViewCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/10/27.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentReferenceView.h"
#import "BBGComment.h"
#import "BBGReply.h"
#import "BBGMenuHandleView.h"

@interface ReplyTableViewCell : UITableViewCell

/**
 *  @author holyjoy, 15-10-21 17:10:03
 *
 *  顶部分割线
 */
@property (strong, nonatomic) IBOutlet UIImageView *separateLine;
/**
 *  @author holyjoy, 15-05-04 17:05:52
 *
 *  回复内容
 */
@property (strong, nonatomic) IBOutlet UILabel *replyTextLabel;
/**
 *  @author holyjoy, 15-05-04 17:05:00
 *
 *  回复引用的评论view
 */
@property (strong, nonatomic) IBOutlet CommentReferenceView *replyReferenceImageView;

@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *replyNameToNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyDateLabel;
/**
 *  @author holyjoy, 15-09-23 14:09:54
 *
 *  是否购买
 */
@property (strong, nonatomic) IBOutlet UIImageView *isBuyImageView;
//是否客服
@property (assign, nonatomic) BOOL isESC;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *replyHeightConstrains;
/**
 *  @author holyjoy, 15-10-21 15:10:56
 *
 *  精品评论imageview
 */
@property (strong, nonatomic) IBOutlet UIImageView *goodCommentImageView;
/**
 *  @author holyjoy, 15-10-21 15:10:28
 *
 *  点赞数量
 */
@property (strong, nonatomic) IBOutlet UILabel *praiseNumberLabel;
/**
 *  @author holyjoy, 15-10-21 15:10:03
 *
 *  点赞图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *praiseImageView;
//点击三个点 出现回复评论视图
@property (strong, nonatomic) IBOutlet BBGMenuHandleView *menuHandleView;

+ (CGFloat)cellHeignt:(BBGComment *)comment replyText:(BBGReply *)reply;
- (void)updateCell:(BBGComment *)comment replyText:(BBGReply *)reply;

@end
