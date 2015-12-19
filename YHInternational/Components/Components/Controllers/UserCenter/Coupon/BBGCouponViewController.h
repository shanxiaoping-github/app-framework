//
//  BBGCouponViewController.h
//  Components
//
//  Created by Damon on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGCouponViewController : BBGViewController
@property (nonatomic, assign) NSInteger pageNumber;
/*!
 *  优惠券状态，0未激活，1激活，2已使用，3失效
 */
@property (nonatomic, assign) NSInteger couponStatus;
@property (nonatomic, strong) NSMutableArray * couponListArray;

/*!
 *  使用优惠券
 */
@property (nonatomic, strong) NSString * shopId;
@property (nonatomic, strong) NSString * buyType;

- (void)checkUserCoupon:(NSString *)shopId buyType:(NSString *)buyType callback:(void (^)(BOOL successful,id response))callback;

- (void)useCouponCode:(NSString * )code shopId:(NSString *)shopId buyType:(NSString *)buyType couponType:(NSString *)couponType callback:(void (^)(BOOL successful,id response))callback;

- (void)cancelUserCoupon:(NSString *)shopId buyType:(NSString *)buyType callback:(void (^)(BOOL successful,id response))callback;

@end
