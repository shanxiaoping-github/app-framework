//
//  BBGReplyReferenceImageView.h
//  YHInternational
//
//  Created by Holyjoy on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCollectionViewCell.h"
#import "ImageCollectionViewCellDelegate.h"

@interface BBGReplyReferenceImageView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UIImageView *buyLabel;
@property (strong, nonatomic) IBOutlet UILabel *referenceNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *buyDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *referenceTextLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *referenceImageCelletionView;
@property (strong, nonatomic) NSMutableArray *imgListArr;
@property (strong, nonatomic) NSMutableArray *bigImageArr;
@property (weak, nonatomic) id<ImageCollectionViewCellDelegate>delegate;
//是否客服
@property (assign, nonatomic) BOOL isESC;
- (void)updateCell:(BBGReply *)reply;

@end
