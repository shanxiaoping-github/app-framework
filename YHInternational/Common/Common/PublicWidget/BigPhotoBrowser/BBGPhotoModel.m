//
//  BBGPhotoModel.m
//  Common
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhotoModel.h"

@implementation BBGPhotoModel

+ (BBGPhotoModel *)photoWithImage:(UIImage *)image{
    return [[BBGPhotoModel alloc] initWithImage:image];
}

+ (BBGPhotoModel *)photoWithURL:(NSURL *)url{
    return [[BBGPhotoModel alloc] initWithURL:url];
}


- (id)initWithImage:(UIImage *)image{
    if ((self = [super init])) {
        _image = image;
    }
    return self;
}

- (id)initWithURL:(NSURL *)url{
    if ((self = [super init])) {
        _photoURL = [url copy];
    }
    return self;
}

@end
