//
//  BBGPhotosBrowserView.m
//  Common
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhotosBrowserView.h"
#import "BBGPhotoCollectionViewCell.h"
#import "Common.h"

@implementation BBGPhotosBrowserView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        frameRect = frame;
        totalItemsCount = 0;
        photoArray = [[NSMutableArray alloc] init];
        
        self.displayPageNumber = YES;
        self.isInfiniteLoop = NO;
        
        [self createView];
        
        self.autoScroll = NO;
        self.autoScrollTimeInterval = 3.0;
        
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Photos:(NSMutableArray*)array{
    self = [self initWithFrame:frame];
    if (self) {
        [self reloadPhotoBrowseWithPhotoArray:array];
    }
    return self;
}

- (void)reloadPhotoBrowseWithPhotoArray:(NSMutableArray *)array{
    [photoArray removeAllObjects];
    [photoArray ARRAY_ADD_OBJS_FROM_ARRAY(array)];
    if (self.isInfiniteLoop) {
        totalItemsCount = [photoArray COUNT]*100;
    }else{
        totalItemsCount = [photoArray COUNT];
    }
    
    [self reloadPageNumberLabel];
    [photoCollectionView reloadData];
}

- (void)setPadding:(CGFloat)padding{
    _padding = padding;
    frameRect.size.width = frameRect.size.width+self.padding;
    [self setFrame:frameRect];
}

- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    if (_autoScroll) {
        [autoScrollTimer invalidate];
        autoScrollTimer = nil;
        [self setupTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}

- (void)setupTimer{
    autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:autoScrollTimer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll{
    if ([photoArray COUNT] > 1) {
        int currentIndex = photoCollectionView.contentOffset.x / frameRect.size.width;
        int targetIndex = currentIndex + 1;
        if (targetIndex == totalItemsCount) {
            if (self.isInfiniteLoop) {
                targetIndex = totalItemsCount * 0.5;
            }else{
                targetIndex = 0;
            }
            [photoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        [photoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
    
}


- (void)createView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frameRect.size.width, frameRect.size.height) collectionViewLayout:layout];
    [photoCollectionView setPagingEnabled:YES];
    [photoCollectionView setDelegate:self];
    [photoCollectionView setDataSource:self];
    [photoCollectionView setShowsHorizontalScrollIndicator:NO];
    [photoCollectionView setBackgroundColor:[UIColor clearColor]];
    [photoCollectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [photoCollectionView registerClass:[BBGPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCollectionViewCellIndex"];
    [self addSubview:photoCollectionView];
    
    pageNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameRect.size.width-88, frameRect.size.height-30, 80, 20)];
    [pageNumberLabel setTextColor:[UIColor whiteColor]];
    [pageNumberLabel setTextAlignment:NSTextAlignmentRight];
    [pageNumberLabel setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [pageNumberLabel setFont:[UIFont systemFontOfSize:14]];
    int currentPage = 1;
    int sumPage = [photoArray COUNT];
    [pageNumberLabel setText:[NSString stringWithFormat:@"%d/%d",currentPage,sumPage]];
    [self addSubview:pageNumberLabel];
}


- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (photoCollectionView.contentOffset.x == 0) {
        int targetIndex = 0;
        if (self.isInfiniteLoop) {
            targetIndex = totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        targetIndex += self.currentImgIndex;
        if (totalItemsCount != 0) {
            if (targetIndex < totalItemsCount) {
                [photoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            }
        }
        
    }
}


- (void)setDisplayPageNumber:(BOOL)displayPageNumber{
    _displayPageNumber = displayPageNumber;
    [pageNumberLabel setHidden:!displayPageNumber];
}

- (void)reloadPageNumberLabel{
    int currentPage = 1;
    int sumPage = [photoArray COUNT];
    if (sumPage <= 1) {
        self.displayPageNumber = NO;
    }
    [pageNumberLabel setText:[NSString stringWithFormat:@"%d/%d",currentPage,sumPage]];
}



#pragma mark scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.autoScroll) {
        [autoScrollTimer invalidate];
        autoScrollTimer = nil;
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (photoCollectionView == scrollView && self.displayPageNumber) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        int indexOnPageControl = (currentPage % [photoArray COUNT])+1;
        int sumPage = [photoArray COUNT];
        [pageNumberLabel setText:[NSString stringWithFormat:@"%d/%d",indexOnPageControl,sumPage]];
    }
}



#pragma mark collection delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    int row = 0;
    row = totalItemsCount;
    return row;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return frameRect.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int itemIndex = indexPath.item % [photoArray COUNT];
    
    BBGPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCollectionViewCellIndex" forIndexPath:indexPath];;
    
    BBGPhotoModel *photo = nil;
    photo = [photoArray ARRAY_OBJ_AT(itemIndex)];
    [cell reloadCellWith:photo];
    
    if (itemIndex < [photoArray COUNT]-1) {
        BBGPhotoCollectionViewCell *nextCell = [[BBGPhotoCollectionViewCell alloc] init];
        photo = [photoArray ARRAY_OBJ_AT(itemIndex+1)];
        [nextCell reloadCellWith:photo];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    int row = indexPath.item % [photoArray COUNT];
    if ([self.delegate respondsToSelector:@selector(photosBrowse:didSelectItemAtIndex:)]) {
        [self.delegate photosBrowse:self didSelectItemAtIndex:row];
    }
}


@end
