//
//  CommentTableViewCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/10/21.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCollectionViewCell.h"
#import "ImageCollectionViewCellDelegate.h"
#import "BBGMenuHandleView.h"

@interface CommentTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/**
 *  @author holyjoy, 15-10-21 17:10:03
 *
 *  顶部分割线
 */
@property (strong, nonatomic) IBOutlet UIImageView *separateLine;

/**
 *  @author holyjoy, 15-10-21 15:10:16
 *
 *  是否客服
 */
@property (assign, nonatomic) BOOL isESC;
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

/**
 *  @author holyjoy, 15-05-04 17:05:16
 *
 *  评论内容
 */
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
/**
 *  @author holyjoy, 15-10-21 15:10:49
 *
 *  图片collectionview
 */
@property (strong, nonatomic) IBOutlet UICollectionView *imageCollectionView;

/**
 *  @author holyjoy, 15-10-21 15:10:16
 *
 *  图片数组
 */
@property (nonatomic,strong) NSMutableArray *imgListArr;
/**
 *  @author holyjoy, 15-10-21 15:10:26
 *
 *  大图片数组
 */
@property (nonatomic,strong) NSMutableArray *bigImgArray;
/**
 *  @author holyjoy, 15-10-21 15:10:19
 *
 *  评论的高度约束
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *replyHeightConstrains;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageCollectionVeiwHeightConstrains;

@property (weak, nonatomic) id<ImageCollectionViewCellDelegate>delegate;
//点击三个点 出现回复评论视图
@property (strong, nonatomic) IBOutlet BBGMenuHandleView *menuHandleView;

/**
 *  @author holyjoy, 15-10-21 15:10:44
 *
 *  更新cell
 *
 *  @param comment
 */
- (void)updateCell:(BBGComment *)comment;


/**
 *  @author holyjoy, 15-10-21 15:10:34
 *
 *  @param comment comment model
 *
 *  @return cell高度
 */
+ (CGFloat)cellHeignt:(BBGComment *)comment;

@end
