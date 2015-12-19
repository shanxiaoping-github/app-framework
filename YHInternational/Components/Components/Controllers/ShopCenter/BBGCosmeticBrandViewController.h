//
//  BBGCosmeticBrandViewController.h
//  Components
//
//  Created by Timmy OuYang on 15/7/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGCosmeticBrandViewController : BBGViewController

@property (strong, nonatomic) NSMutableArray *brandsArray;
/**
 *  typeTag 1为食品，2为保健品
 */
@property (assign, nonatomic) NSInteger  typeTag;
@end
