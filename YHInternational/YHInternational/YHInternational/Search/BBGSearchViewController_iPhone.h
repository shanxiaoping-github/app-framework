//
//  BBGSearchViewController_iPhone.h
//  BuBuGao
//
//  Created by Holyjoy on 15/3/19.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGSearchViewController.h"

@protocol BBGSearchViewDelegate;

@interface BBGSearchViewController_iPhone : BBGSearchViewController

@property (nonatomic,assign) BOOL isFormFindCenterCtrl;

@property (nonatomic,assign) BOOL isForm3DTouch;

@property (nonatomic, assign) id<BBGSearchViewDelegate> delegate;
@end

@protocol BBGSearchViewDelegate <NSObject>

- (void)searchView:(BBGSearchViewController_iPhone *)searchViewController didSelectedKeywords:(NSString *)keywords;

@end
