//
//  PTCountDown.h
//  PTDemo
//
//  Created by 彭腾 on 15/6/9.
//  Copyright (c) 2015年 彭腾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButton)();

@interface PTCountDown : UIView

@property (strong, nonatomic) UILabel *countDown;
@property (strong, nonatomic) UIImageView *bgImage;
@property (copy, nonatomic) NSString *overTime;
@property (copy, nonatomic) ClickButton button;
@property (strong, nonatomic) UIButton *clickBtn;
- (void)handlerButtonAction:(ClickButton)block;

@end
