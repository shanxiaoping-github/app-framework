//
//  BBGCommentDetailImageView_iPhone.h
//  YHInternational
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBGCommentImgCollectionViewCell.h"
#import "ImageCollectionViewCellDelegate.h"

@protocol BBGCommentDetailImageViewDelegate;

@interface BBGCommentDetailImageView_iPhone : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,BBGCommentImgCollectionViewCellDelegate>


@property (nonatomic, strong) UICollectionView* photoCollectionView;
@property (nonatomic,assign) BOOL uploadingPhoto;
@property (nonatomic,strong) NSMutableArray *willUploadImgArray;
@property (nonatomic, strong) NSMutableArray *picDataArray;
@property (nonatomic, strong) NSMutableArray *bigImgArray;

@property (nonatomic,weak) id<BBGCommentDetailImageViewDelegate> delegate;
@property (weak, nonatomic)id<ImageCollectionViewCellDelegate>bigImageDelegate;

//在列表中的位置
@property (nonatomic,strong) NSIndexPath* indexPathInList;

- (void)reloadView;

@end


@protocol BBGCommentDetailImageViewDelegate <NSObject>

@optional

- (void)commentImgCollectionViewAddPhoto:(BBGImgModel*)model;

- (void)commentImgCollectionViewAddPhoto:(BBGImgModel*)model indexPath:(NSIndexPath*)indexPath;

- (void)commentImgCollectionViewDelPhoto:(BBGImgModel*)model;

- (void)commentImgCollectionViewDelPhoto:(BBGImgModel*)model indexPath:(NSIndexPath*)indexPath;

@end
