//
//  BBGGoodsCommentCell.m
//  YHInternational
//
//  Created by 彭腾 on 15-5-6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsCommentCell.h"
#import "BBGGoodsDetailCommentCell.h"
#import "BBGPraiseMembs.h"

@interface BBGGoodsCommentCell () {
    NSInteger numberOfItems;
    NSInteger number;
}
@property (strong, nonatomic) IBOutlet UILabel *praiseCount;
@property (strong, nonatomic) BBGPraiseMembs *model;
@property (strong, nonatomic) BBGPraiseMembs *bbgPraiseMembs;
@end

@implementation BBGGoodsCommentCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT ;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(click:) name:@"praise" object:nil];
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, IPHONE_WIDTH, 0.5f);
    topBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xe5e5e5) CGColor];
    [self.firstBg.layer addSublayer:topBorder];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.firstBg.frame.size.height-0.5f, IPHONE_WIDTH, 0.5f);
    bottomBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xe5e5e5) CGColor];
    [self.firstBg.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWith:(BBGGoodsBasicInfo *)goods {
    if (goods.praiseCount>99) {
        self.praiseCount.text = [NSString stringWithFormat:@"99+"] ;
    }else {
        self.praiseCount.text = [NSString stringWithFormat:@"%ld",(long)goods.praiseCount] ;
    }
    number = goods.praiseCount;
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

//    NSInteger num = floor(self.collectionView.frame.size.width/34) ;
//    if (_dataArr.count>num) {
//        numberOfItems = num ;
//        return num ;
//    }else {
//        numberOfItems = _dataArr.count ;
//        return _dataArr.count ;
//    }
//    if (_dataArr.count>99) {
//        self.praiseCount.text = [NSString stringWithFormat:@"99+"] ;
//    }else {
//        self.praiseCount.text = [NSString stringWithFormat:@"%ld",(long)_dataArr.count] ;
//    }
    return _dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView registerNib:[UINib nibWithNibName:@"BBGGoodsDetailCommentCell" bundle:nil] forCellWithReuseIdentifier:@"BBGGoodsDetailComment"] ;
    BBGGoodsDetailCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BBGGoodsDetailComment" forIndexPath:indexPath] ;
    BBGPraiseMembs *bbgPm = _dataArr[indexPath.item] ;
    cell.numLab.hidden = YES ;
    cell.memberHeadUrl.layer.cornerRadius = cell.memberHeadUrl.frame.size.width/2 ;
    cell.memberHeadUrl.clipsToBounds = YES ;
    [cell.memberHeadUrl sd_setImageWithURL:[NSURL URLWithString:bbgPm.memberHeadUrl] placeholderImage:[UIImage imageNamed:@"点赞数字背景"]] ;
    return cell ;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(34, 34) ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 8.0 ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 8.0 ;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self.collectionView layoutAttributesForItemAtIndexPath:itemIndexPath];
    
    return attr;
}

- (void)click:(NSNotification *)notification {
    __weak BBGGoodsCommentCell *weakSelf = self;
    NSDictionary *dic = [notification object];
    NSNumber *bl = [dic objectForKey:@"isPraise"];
    self.model = [dic objectForKey:@"Praise"];
    BOOL isPraise = [bl boolValue];
    if (isPraise == NO) {
        [self.collectionView performBatchUpdates:^{
            [weakSelf.dataArr insertObject:weakSelf.model atIndex:0] ;

            
            [weakSelf.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
            number += 1;
            if (number>99) {
                weakSelf.praiseCount.text = [NSString stringWithFormat:@"99+"] ;
            }else {
                weakSelf.praiseCount.text = [NSString stringWithFormat:@"%ld",(long)number] ;
            }
            
        } completion:nil];
    }else {
        [self.collectionView performBatchUpdates:^{
            for (NSInteger i = 0; i < weakSelf.dataArr.count; i++) {
                weakSelf.bbgPraiseMembs = weakSelf.dataArr[i];
                if ([weakSelf.bbgPraiseMembs.memberId integerValue]==[weakSelf.model.memberId integerValue]) {
                    NSIndexPath *path1 = [NSIndexPath indexPathForItem:i inSection:0];
                    
                    [weakSelf.dataArr removeObjectAtIndex:i];
                    
                    NSArray *array = [NSArray arrayWithObjects:path1, nil];
                    [weakSelf.collectionView deleteItemsAtIndexPaths:array];
                    
                    number -= 1;
                    if (number>99) {
                        weakSelf.praiseCount.text = [NSString stringWithFormat:@"99+"] ;
                    }else {
                        weakSelf.praiseCount.text = [NSString stringWithFormat:@"%ld",(long)number] ;
                    }
                }
            }
            
        } completion:nil];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"praise" object:nil];
}

@end
