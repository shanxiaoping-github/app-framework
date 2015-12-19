//
//  BBGCategoryViewController_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCategoryViewController.h"
#import "BBGContentProtocol.h"

@interface BBGCategoryViewController_iPhone : BBGCategoryViewController<BBGContentProtocol>

@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic,weak)UINavigationController *contentViewController;

@end
