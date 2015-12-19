//
//  BBGPhotoModel.h
//  Common
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGPhotoModel : NSObject

@property (nonatomic,strong) NSString *caption;
@property (nonatomic,readonly) UIImage *image;
@property (nonatomic,readonly) NSURL *photoURL;

+ (BBGPhotoModel *)photoWithImage:(UIImage *)image;
+ (BBGPhotoModel *)photoWithURL:(NSURL *)url;

- (id)initWithImage:(UIImage *)image;
- (id)initWithURL:(NSURL *)url;

@end
