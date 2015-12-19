//
//  BBGPopularProductCell_iPhone.h
//  YHInternational
//
//  Created by Timmy OuYang on 15/7/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGPopularProduct.h"

@interface BBGPopularProductCell_iPhone : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *normalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *crossPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uncrossPriceLabelLeadingSpaceConstraints;

- (void)updateCellWithPopularProduct:(BBGPopularProduct *)product;
@end
