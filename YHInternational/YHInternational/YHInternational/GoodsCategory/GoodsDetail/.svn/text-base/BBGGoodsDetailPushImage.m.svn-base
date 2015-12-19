//
//  BBGGoodsDetailPushImage.m
//  YHInternational
//
//  Created by 彭腾 on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsDetailPushImage.h"
#import "BBGGoodsDetailImages.h"

@interface BBGGoodsDetailPushImage () {
    UIScrollView *_scrollView ;
    UITapGestureRecognizer *tap ;
}

@end

@implementation BBGGoodsDetailPushImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,IPHONE_WIDTH,IPHONE_HEIGHT)] ;
    _scrollView.contentSize = CGSizeMake(IPHONE_WIDTH * _dataArr.count, 0) ;
    _scrollView.contentOffset = CGPointMake(IPHONE_WIDTH * _page, 0) ;
    _scrollView.showsVerticalScrollIndicator = YES ;
    _scrollView.bounces = NO ;
    _scrollView.pagingEnabled = YES ;
    [self.view addSubview:_scrollView] ;
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Press)] ;
    [_scrollView addGestureRecognizer:tap] ;
    
    for (NSInteger i = 0; i < _dataArr.count; i++) {
        BBGGoodsDetailImages *detailImages = _dataArr[i] ;
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0 + IPHONE_WIDTH*i, 0, IPHONE_WIDTH, IPHONE_HEIGHT)] ;
        image.backgroundColor = [UIColor blackColor] ;
        image.contentMode = UIViewContentModeScaleAspectFit ;
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] ;
        activity.frame = CGRectMake(IPHONE_WIDTH/2-25 + IPHONE_WIDTH*i, IPHONE_HEIGHT/2-25, 50, 50) ;
        [_scrollView addSubview:image] ;
        [_scrollView addSubview:activity] ;
        [_scrollView bringSubviewToFront:activity] ;
        [activity startAnimating] ;
        [image sd_setImageWithURL:[NSURL URLWithString:detailImages.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [activity stopAnimating] ;
        }] ;
    }
}

- (void)Press {
    [self dismissViewControllerAnimated:YES completion:^{
    }] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
