//
//  BBGPhotoBrowserViewController.m
//  Common/snso/svn/YHInternational/Common/Common/PublicWidget/BigPhotoBrowser/BBGPhotoBrowserViewController.m
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhotoBrowserViewController.h"
#import "Common.h"
#import "BBGPhotosBrowserView.h"

@interface BBGPhotoBrowserViewController ()

@end

@implementation BBGPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    BBGPhotosBrowserView *photosBrowser = [[BBGPhotosBrowserView alloc] initWithFrame:CGRectMake(0, 0, FRAMEW(self.view), FRAMEH(self.view))];
    photosBrowser.currentImgIndex = self.currentImgIndex;
    [photosBrowser reloadPhotoBrowseWithPhotoArray:self.imgArray];
    [photosBrowser setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:photosBrowser];
}

- (void)viewDidAppear:(BOOL)animated{
    if ([self.imgArray COUNT] == 0) {
        [[BBGLoadingTips sharedInstance] showTips:@"请设置图片"];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}


- (void)singleTapDetected{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
