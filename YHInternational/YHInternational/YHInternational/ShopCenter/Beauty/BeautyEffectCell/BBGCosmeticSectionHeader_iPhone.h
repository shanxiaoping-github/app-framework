//
//  BBGCosmeticSectionHeader_iPhone.h
//  YHInternational
//
//  Created by Timmy OuYang on 15/7/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGBrand.h"

@protocol BBGCosmeticSectionHeaderDelegate;
@interface BBGCosmeticSectionHeader_iPhone : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *brandImageView;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *separateImageView;
@property (assign, nonatomic) id<BBGCosmeticSectionHeaderDelegate> delegate;
@property (assign, nonatomic) NSInteger index;

- (void)updateSectionHeaderWith:(BBGBrand *)brand;

@end

@protocol BBGCosmeticSectionHeaderDelegate <NSObject>

- (void)sectionHeader:(BBGCosmeticSectionHeader_iPhone *)sectionView didSelectedAtIndex:(NSInteger)index;

@end
