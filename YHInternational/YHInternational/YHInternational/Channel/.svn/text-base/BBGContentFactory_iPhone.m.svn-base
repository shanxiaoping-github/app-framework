//
//  BBGContentFactory_iPhone.m
//  BuBuGao
//
//  Created by calvin on 14-8-14.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGContentFactory_iPhone.h"
#import "BBGOrderListViewController_iPhone.h"
#import "BBGCouponViewController_iPhone.h"
#import "BBGCategoryViewController_iPhone.h"
#import "BBGCountryViewController_iPhone.h"
#import "BBGIndexRecommendViewController_iPhone.h"
#import "BBGMaternalAndBeautyViewController_iPhone.h"
#import "BBGBeautyEffectViewController_iPhone.h"
@implementation BBGContentFactory_iPhone

DECLARE_SINGLETON(BBGContentFactory_iPhone)

- (UIViewController<BBGContentProtocol> *)buildContentByMenuItem:(BBGMenuItem *)item{
    UIViewController<BBGContentProtocol> *viewController;
    switch ([item.menuID intValue]) {
        case 1://待付款
        case 2://待发货
        case 3://待收货
        case 4://已收货
        case 5://全部
        {
            viewController = [[BBGOrderListViewController_iPhone alloc] init];
        }
            break;
        case 11:
        case 12:
        case 13:
        {
            viewController = [[BBGCouponViewController_iPhone alloc]init];
        }
            break;
        case 111:
        {
            viewController = [[BBGCategoryViewController_iPhone alloc] init];

        }
            break;
        case 222:
        {
            viewController = [[BBGCountryViewController_iPhone alloc] init];
        }
            break;
        
        case 1111:
        {
            viewController = [[BBGIndexRecommendViewController_iPhone alloc] init];
        }
            break;
        case 2222:
        {
            viewController = [[BBGMaternalAndBeautyViewController_iPhone alloc] initWithTypeTag:1];
        }
            break;
        case 3333:
        {
            viewController = [[BBGMaternalAndBeautyViewController_iPhone alloc] initWithTypeTag:2];
        }
            break;
        case 4444:
        {
            viewController = [[BBGMaternalAndBeautyViewController_iPhone alloc] initWithTypeTag:3];
        }
            break;
        default:
            break;
    }
    return viewController;
}

@end
