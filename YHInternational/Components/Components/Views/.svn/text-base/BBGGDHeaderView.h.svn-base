//
//  BBGGDHeaderView.h
//  Components
//
//  Created by 彭腾 on 15/10/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PraiseBlock)();
typedef void (^CommentBlock)();

@interface BBGGDHeaderView : UIView

@property (nonatomic, copy) PraiseBlock praiseButton;

@property (nonatomic, copy) CommentBlock commentButton;
/**
 *  点赞图片状态
 */
@property (nonatomic, assign) BOOL isPraise;

- (void)praiseButtonAction:(PraiseBlock)block;

- (void)commentButtonAction:(CommentBlock)block;

@end
