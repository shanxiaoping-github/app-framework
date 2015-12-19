//
//  BBGCommentImgCollectionViewCell.h
//  YHInternational
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBGCommentImgCollectionViewCellDelegate;

@interface BBGCommentImgCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIButton *imgBtn;
@property (nonatomic,strong) UIButton *delBtn;

@property (nonatomic,strong) BBGImgModel *uploadImgModel;

@property (nonatomic,weak) id<BBGCommentImgCollectionViewCellDelegate> delegate;

- (void)reloadCell:(BBGImgModel*)model;

+ (CGSize)imageSize;

@end


@protocol BBGCommentImgCollectionViewCellDelegate <NSObject>

- (void)commentImgCollectionViewAddPhoto:(BBGImgModel*)model;

- (void)commentImgCollectionViewDelPhoto:(BBGImgModel*)model;

@end