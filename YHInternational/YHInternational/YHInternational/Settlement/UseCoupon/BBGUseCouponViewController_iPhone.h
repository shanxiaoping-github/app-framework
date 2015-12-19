//
//  BBGUseCouponViewController_iPhone.h
//  YHInternational
//
//  Created by Damon on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCouponViewController.h"

#import "BBGCoupon.h"

typedef void (^UseCouponBlock)(BOOL successful,id response) ;

@interface BBGUseCouponViewController_iPhone : BBGCouponViewController
@property (nonatomic, strong) BBGCoupon * selectedCoupon;
- (id)initWithCallback:(void(^)(BOOL successful,id response))callback;
@end
