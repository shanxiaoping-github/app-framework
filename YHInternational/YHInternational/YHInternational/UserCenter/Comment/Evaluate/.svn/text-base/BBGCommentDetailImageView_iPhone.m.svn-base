//
//  BBGCommentDetailImageView_iPhone.m
//  YHInternational
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCommentDetailImageView_iPhone.h"
#import "BBGCommentImgCollectionViewCell.h"

@implementation BBGCommentDetailImageView_iPhone

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}


- (void)createView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    CGSize size = [BBGCommentImgCollectionViewCell imageSize];
    self.photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, size.height) collectionViewLayout:layout];
    [self.photoCollectionView setBackgroundColor:[UIColor whiteColor]];
    self.photoCollectionView.dataSource = self;
    self.photoCollectionView.delegate = self;
    [self.photoCollectionView registerClass:[BBGCommentImgCollectionViewCell class] forCellWithReuseIdentifier:@"BBGCommentImgCollectionViewCell"];
    [self addSubview:self.photoCollectionView];
    
    [self.photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.width.mas_equalTo(IPHONE_WIDTH);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

- (void)reloadView{
    [self.photoCollectionView reloadData];
}


#pragma mark UICollectionViewDataSource

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    int row = 0;
    if ([self.picDataArray COUNT] == MAX_PHOTO_COUNT) {
        row = [self.picDataArray COUNT];
    }else{
        row = [self.picDataArray COUNT]+1;
    }
    return row;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(IPHONE_WIDTH/(MAX_PHOTO_COUNT*1.0), IPHONE_WIDTH/(MAX_PHOTO_COUNT*1.0));
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BBGCommentImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BBGCommentImgCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    if ([self.picDataArray COUNT] == 5) {
        BBGImgModel *model = [self.picDataArray ARRAY_OBJ_AT(indexPath.row)];
        [cell reloadCell:model];
    }else{
        if ([self.picDataArray COUNT] == indexPath.row) {
            BBGImgModel *model = [[BBGImgModel alloc] init];
            model.isAddBtn = YES;
            [cell reloadCell:model];
        }else{
            BBGImgModel *model = [self.picDataArray ARRAY_OBJ_AT(indexPath.row)];
            [cell reloadCell:model];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击查看大图
    if ([_picDataArray count] > 0) {
        _bigImgArray = [NSMutableArray new];
        for (int i = 0; i < _picDataArray.count; i++) {
            
            BBGImgModel *model = [self.picDataArray ARRAY_OBJ_AT(i)];
            [_bigImgArray addObject:[BBGPhotoModel photoWithURL:[NSURL URLWithString:model.url]]];
        }
        if (self.bigImageDelegate && [self.bigImageDelegate respondsToSelector:@selector(didClickedImageViewCell:imageArray:)]) {
            [self.bigImageDelegate didClickedImageViewCell:indexPath imageArray:_bigImgArray];
        }
    }
}


#pragma mark BBGCommentImgCollectionViewCellDelegate
- (void)commentImgCollectionViewAddPhoto:(BBGImgModel*)model{
    
    //    if ([self.delegate respondsToSelector:@selector(commentImgCollectionViewAddPhoto:)])
    //    {
    if(_indexPathInList)
    {
        [self.delegate commentImgCollectionViewAddPhoto:model indexPath:_indexPathInList];
    }else
    {
        [self.delegate commentImgCollectionViewAddPhoto:model];
    }
    //    }
    
}
- (void)commentImgCollectionViewDelPhoto:(BBGImgModel*)model{
    //    if ([self.delegate respondsToSelector:@selector(commentImgCollectionViewDelPhoto:)])
    //    {
    if(_indexPathInList)
    {
        [self.delegate commentImgCollectionViewDelPhoto:model indexPath:_indexPathInList];
    }else
    {
        [self.delegate commentImgCollectionViewDelPhoto:model];
    }
    //    }
}

@end
