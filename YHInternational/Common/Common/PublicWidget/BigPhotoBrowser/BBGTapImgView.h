//
//  BBGTapImgView.h
//  Common
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBGTapImgViewDelegate;

@interface BBGTapImgView : UIImageView

@property (nonatomic, weak) id <BBGTapImgViewDelegate> delegate;

@end

@protocol BBGTapImgViewDelegate <NSObject>

@optional

- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView tripleTapDetected:(UITouch *)touch;

@end