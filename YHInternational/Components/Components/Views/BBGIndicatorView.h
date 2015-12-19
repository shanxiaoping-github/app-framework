//
//  BBGIndicatorView.h
//  BubuGao
//
//  Created by calvin on 14-4-11.
//  Copyright (c) 2014年 bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGIndicatorView : UIView

//停止动画时自动隐藏,默认YES
@property(nonatomic, assign) BOOL hidesWhenStopped;

- (id)initWithCenterImage:(UIImage *)cImage levelImage:(UIImage *)lImage;

- (void)startAnimating;

- (void)stopAnimating;

@end
