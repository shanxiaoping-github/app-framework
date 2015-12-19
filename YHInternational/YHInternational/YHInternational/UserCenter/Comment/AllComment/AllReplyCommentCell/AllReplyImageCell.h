//
//  AllReplyImageCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGReplyReferenceImageView.h"
#import "BBGComment.h"
#import "BBGReply.h"

@interface AllReplyImageCell : UITableViewCell
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
@property (strong, nonatomic) IBOutlet BBGReplyReferenceImageView *replyReferenceImageView;

@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *replyNameToNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyDateLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *replyHeightConstraints;
/**
 *  @author holyjoy, 15-09-23 14:09:54
 *
 *  是否购买
 */
@property (strong, nonatomic) IBOutlet UIImageView *isBuyImageView;
//是否客服
@property (assign, nonatomic) BOOL isESC;


+ (CGFloat)cellHeignt:(BBGComment *)comment replyText:(BBGReply *)reply;
- (void)updateCell:(BBGComment *)comment replyText:(BBGReply *)reply;


@end
