//
//  CommentReferenceView.h
//  YHInternational
//
//  Created by Holyjoy on 15/10/21.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCollectionViewCell.h"
#import "ImageCollectionViewCellDelegate.h"

@interface CommentReferenceView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//引用是否有图片
//@property (nonatomic,assign) BOOL hasImage;
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
