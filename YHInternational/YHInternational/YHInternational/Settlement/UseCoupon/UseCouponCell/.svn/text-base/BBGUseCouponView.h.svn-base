//
//  BBGUseCouponView.h
//  YHInternational
//
//  Created by Damon on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)();
typedef void(^ReturnButton)();

@interface BBGUseCouponView : UIView
@property (nonatomic, strong) NSString * couponCode;
@property (nonatomic, copy) ActionBlock block;
@property (nonatomic, copy) ReturnButton button;
@property (strong, nonatomic) IBOutlet UIButton *nouse;
- (void)handlerButtonAction:(ReturnButton)block;
@end
