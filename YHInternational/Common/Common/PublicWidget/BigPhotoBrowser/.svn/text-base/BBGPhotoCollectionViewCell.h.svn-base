//
//  BBGPhotoCollectionViewCell.h
//  Common
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGTapImgView.h"
#import "BBGPhotoModel.h"

@interface BBGPhotoCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate,BBGTapImgViewDelegate>{
    CGRect frameRect;
}

@property(nonatomic,strong)BBGTapImgView *photoView;
@property(nonatomic,strong)UIScrollView *imgScrollView;
@property(nonatomic,strong)UIActivityIndicatorView *loadingIndicator;

-(void)reloadCellWith:(BBGPhotoModel*)photo;

@end
