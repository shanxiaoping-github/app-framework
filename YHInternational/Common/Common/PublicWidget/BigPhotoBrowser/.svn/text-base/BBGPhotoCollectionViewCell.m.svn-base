//
//  BBGPhotoCollectionViewCell.m
//  Common
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhotoCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Common.h"
#import "BBGPhotoBrowserViewController.h"


@implementation BBGPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        frameRect = frame;
        [self createView];
    }
    return self;
}

- (void)createView{
    self.imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, frameRect.size.height)];
    self.imgScrollView.delegate = self;
    //设置最大伸缩比例
    self.imgScrollView.maximumZoomScale = 3.0;
    //设置最小伸缩比例
    self.imgScrollView.minimumZoomScale = 1;
    [self addSubview:self.imgScrollView];
    
    self.photoView = [[BBGTapImgView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    self.photoView.delegate = self;
    [self.imgScrollView addSubview:self.photoView];
    
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.loadingIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [self.loadingIndicator setCenter:CGPointMake(FRAMEW(self.imgScrollView)/2.0, FRAMEH(self.imgScrollView)/2.0)];
    [self.imgScrollView addSubview:self.loadingIndicator];
    
}

//告诉scrollview要缩放的是哪个子控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.photoView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    CGSize boundsSize = frameRect.size;
    CGRect frameToCenter = self.photoView.frame;
    
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    
    // Center
    if (!CGRectEqualToRect(self.photoView.frame, frameToCenter)){
        self.photoView.frame = frameToCenter;
    }
    
}

- (void)reloadCellWith:(BBGPhotoModel*)photo{
    [self.loadingIndicator stopAnimating];
    [self.imgScrollView setZoomScale:1];
    
    if (photo.image) {
        [self.photoView setImage:photo.image];
    }else if (photo.photoURL){
        if ([[[photo.photoURL scheme] lowercaseString] isEqualToString:@"assets-library"]) {
            
            ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
            [assetslibrary assetForURL:photo.photoURL
                           resultBlock:^(ALAsset *asset){
                               ALAssetRepresentation *rep = [asset defaultRepresentation];
                               CGImageRef iref = [rep fullScreenImage];
                               if (iref) {
                                   UIImage *img = [UIImage imageWithCGImage:iref];
                                   [self.photoView setImage:img];
                               }
                           }
                          failureBlock:^(NSError *error) {
                              
                          }];
            
        }else if ([photo.photoURL isFileURL]){
            UIImage *img = [UIImage imageWithContentsOfFile:photo.photoURL.path];
            [self.photoView setImage:img];
            
        }else{
            BOOL imgExists = [[SDWebImageManager sharedManager] diskImageExistsForURL:photo.photoURL];
            if (!imgExists) {
                [self.loadingIndicator startAnimating];
            }
            [self.photoView sd_setImageWithURL:photo.photoURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [self.loadingIndicator stopAnimating];
                
                CGSize newSize = image.size;
                if (newSize.width > frameRect.size.width) {
                    float ratio = frameRect.size.width/newSize.width;
                    newSize.width = frameRect.size.width;
                    newSize.height = floorf(newSize.height *ratio);
                }else if (newSize.height > frameRect.size.height){
                    float ratio = frameRect.size.height/newSize.height;
                    newSize.height = frameRect.size.height;
                    newSize.width = floorf(newSize.width *ratio);
                }
                [self.photoView setFrame:CGRectMake(0, 0, newSize.width, newSize.height)];
                [self.photoView setCenter:CGPointMake(FRAMEW(self.imgScrollView)/2.0, FRAMEH(self.imgScrollView)/2.0)];
            }];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = touch.tapCount;
    switch (tapCount) {
        case 1:
            [self handleSingleTap:touch];
            break;
        case 2:
            [self handleDoubleTap:touch];
            break;
        default:
            break;
    }
}

- (void)handleSingleTap:(UITouch *)touch {
    BBGPhotoBrowserViewController *con = (BBGPhotoBrowserViewController*)self.viewController;
    if ([con isKindOfClass:[BBGPhotoBrowserViewController class]]) {
        [con performSelector:@selector(singleTapDetected) withObject:nil afterDelay:0.2];
    }
}

- (void)handleDoubleTap:(UITouch *)touch {
    [NSObject cancelPreviousPerformRequestsWithTarget:self.viewController];
    [self photoViewZoomWithPoint:[touch locationInView:self.photoView]];
}

- (void)photoViewZoomWithPoint:(CGPoint)touchPoint {
    if (self.imgScrollView.zoomScale != self.imgScrollView.minimumZoomScale) {
        [self.imgScrollView setZoomScale:self.imgScrollView.minimumZoomScale animated:YES];
    } else {
        CGFloat newZoomScale = ((self.imgScrollView.maximumZoomScale + self.imgScrollView.minimumZoomScale) / 2);
        CGFloat xsize = self.bounds.size.width / newZoomScale;
        CGFloat ysize = self.bounds.size.height / newZoomScale;
        [self.imgScrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        
    }
}

@end
