//
//  PTFlowLayout.h
//  testDemo
//
//  Created by 彭腾 on 15/8/12.
//  Copyright (c) 2015年 彭腾. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const PTCollectionViewHeader;
FOUNDATION_EXPORT NSString *const PTCollectionViewFooter;
FOUNDATION_EXPORT NSString *const PTCollectionViewCell;

@class PTFlowLayout;

@protocol PTFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>
    @optional
    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(PTFlowLayout *)collectionViewLayout estimatedSizeForHeaderInSection:(NSInteger)section;
    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(PTFlowLayout *)collectionViewLayout estimatedSizeForFooterInSection:(NSInteger)section;
@end

@interface PTFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<PTFlowLayoutDelegate> delegate;

- (id)initWithSectionNum:(NSInteger)sectionNum;
@end
