//
//  BBGBadgeView.h
//  Views
//
//  Created by 程伟 on 14-04-10.
//  Copyright (c) 2013年 程伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGBadgeView : UIView

@property(nonatomic, assign) NSInteger number;
@property(nonatomic, strong) UIImage *backgroundImage;
//显示数字颜色,默认白色
@property(nonatomic, strong) UIColor *textColor;

- (id)initWithBackgroundImage:(UIImage *)image;
- (void)setNumber:(NSInteger)number prefix:(NSString *)prefix;

@end
