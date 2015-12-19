//
//  BBGBackToTopView.m
//  YHInternational
//
//  Created by 黄 灿 on 15/7/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBackToTopView.h"

@implementation BBGBackToTopView
- (instancetype)init{
    self = [super init];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BackToTop"]];
        self.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
        [self addSubview:imageView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:gesture];
    }
    return self;

}
- (void)tap:(UITapGestureRecognizer *)sender{
    if (_GoTopBlock) {
        _GoTopBlock();
    }
}

- (void)dealloc{
    _GoTopBlock=nil;
}
@end
