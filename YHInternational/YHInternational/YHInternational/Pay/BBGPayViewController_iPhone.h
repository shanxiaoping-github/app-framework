//
//  BBGPayViewController_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayViewController.h"
#import "BBGPayCompleteViewController_iPhone.h"
@protocol BBGPayViewDelegate <NSObject>
-(void)paySuccess;
-(void)payFailed;
@end

@interface BBGPayViewController_iPhone : BBGPayViewController
/**
 *  页面来源
 */
@property (nonatomic,assign) BBGPaySource paySource;

@property (nonatomic,weak) id<BBGPayViewDelegate> delegate;
@end
