//
//  BBGPhotosBrowserView.h
//  Common
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBGPhotosBrowserView;
@protocol CustomPhotosBrowseDelegate <NSObject>
- (void)photosBrowse:(BBGPhotosBrowserView *)photosBrowse didSelectItemAtIndex:(NSInteger)index;

@end

@interface BBGPhotosBrowserView : UIView<UICollectionViewDataSource,UIScrollViewAccessibilityDelegate,UICollectionViewDelegateFlowLayout>{
    
    CGRect frameRect;
    
    UICollectionView *photoCollectionView;
    NSMutableArray *photoArray;
    int totalItemsCount;
    
    UILabel *pageNumberLabel;
    
    NSTimer *autoScrollTimer;
}


@property (nonatomic,assign) BOOL displayPageNumber; //是否显示页码
@property (nonatomic,assign) CGFloat padding; //间隔

@property (nonatomic,assign) BOOL isInfiniteLoop; //是否无限循环

@property (nonatomic,assign) BOOL autoScroll;    //是否自动滚动
@property (nonatomic,assign) CGFloat autoScrollTimeInterval;


@property (nonatomic,assign)int currentImgIndex;    //移动到第几个图片


@property (nonatomic, weak) id<CustomPhotosBrowseDelegate> delegate;


- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame Photos:(NSMutableArray*)array;

- (void)reloadPhotoBrowseWithPhotoArray:(NSMutableArray*)array;

@end
