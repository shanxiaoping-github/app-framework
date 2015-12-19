//
//  BBGMyCommentImageCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/4/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCollectionViewCell.h"
#import "BBGComment.h"
#import "ImageCollectionViewCellDelegate.h"

@interface BBGMyCommentImageCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *replyHeightConstrains;


@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
/**
 *  @author holyjoy, 15-05-04 17:05:16
 *
 *  评论内容
 */
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
/**
 *  @author holyjoy, 15-05-04 17:05:34
 *
 *  评论图片显示区
 */
@property (strong, nonatomic) IBOutlet UICollectionView *imageCollectionView;
/**
 *  @author holyjoy, 15-05-04 17:05:53
 *
 *  用户头像
 */
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
/**
 *  @author holyjoy, 15-05-04 17:05:04
 *
 *  评论者名字
 */
@property (strong, nonatomic) IBOutlet UILabel *commentNameLabel;
/**
 *  @author holyjoy, 15-05-04 17:05:17
 *
 *  是否购买商品
 */
@property (strong, nonatomic) IBOutlet UIImageView *isBuyImageView;
/**
 *  @author holyjoy, 15-05-04 17:05:32
 *
 *  评论时间
 */
@property (strong, nonatomic) IBOutlet UILabel *commentTimeLabel;

@property (nonatomic,strong) NSMutableArray *imgListArr;
@property (nonatomic,strong) NSMutableArray *bigImgArray;
//是否客服
@property (assign, nonatomic) BOOL isESC;

@property (weak, nonatomic)id<ImageCollectionViewCellDelegate>delegate;

+ (CGFloat)cellHeignt:(BBGComment *)comment;

- (void)updateCell:(BBGComment *)comment;

@end
