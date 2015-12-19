//
//  BBGMyCommentTextCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/4/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGComment.h"

@interface BBGMyCommentTextCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

/**
 *  @author holyjoy, 15-05-04 16:05:12
 *
 *  评论label
 */
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;

@property (strong, nonatomic) IBOutlet UIImageView *commentImageView;
@property (strong, nonatomic) IBOutlet UILabel *commentNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *buyImageView;
@property (strong, nonatomic) IBOutlet UILabel *commentTimeLabel;
//是否客服
@property (assign, nonatomic) BOOL isESC;

+ (CGFloat)cellHeignt:(BBGComment *)comment;
- (void)updateCell:(BBGComment *)comment;
@end
