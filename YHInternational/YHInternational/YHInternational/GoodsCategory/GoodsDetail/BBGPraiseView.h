//
//  BBGPraiseView.h
//  YHInternational
//
//  Created by yangjie on 15/5/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGUserDetailInfo.h"

@protocol BBGPraiseDelegate;

@interface BBGPraiseView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<BBGPraiseDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          userArray:(NSMutableArray*)userArray
           isPraise:(bool)isPraise;

- (void)reloadPraiseViewWithUserArray:(NSMutableArray*)userArray isPraise:(bool)isPraise;


/**
 *  点击赞成功
 */
- (void)praiseSuccess:(BBGUserDetailInfo*)userModel;

/**
 *  取消赞成功
 */
- (void)canclePraiseSuccess:(BBGUserDetailInfo*)userModel;

@end


@protocol BBGPraiseDelegate <NSObject>

- (void)praiseViewBtnclick:(BBGPraiseView*)praiseView;

@end