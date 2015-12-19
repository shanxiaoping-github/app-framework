//
//  BBGCommentDetailImageCell_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCommentDetailImageCell_iPhone.h"
#import "ImageCollectionViewCell.h"

@interface BBGCommentDetailImageCell_iPhone ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@end

@implementation BBGCommentDetailImageCell_iPhone

- (void)awakeFromNib {
    _imageViewCollection.delegate = self;
    _imageViewCollection.dataSource = self;
    _imageViewCollection.scrollEnabled = NO;
    
    [_imageViewCollection registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    
    _imgListArr = [NSMutableArray array];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
    [_imgListArr addObject:@"http://img3.douban.com/view/photo/photo/public/p1273021881.jpg"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width/5-10, collectionView.bounds.size.width/5-10);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10,5,10,0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_imgListArr count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    [cell updateCell:[_imgListArr ARRAY_OBJ_AT(indexPath.row)]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了collection %ld",(long)indexPath.row);
}


@end
