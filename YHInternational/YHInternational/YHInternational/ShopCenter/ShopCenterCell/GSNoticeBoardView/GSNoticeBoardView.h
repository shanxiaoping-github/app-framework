//
//  GSNoticeBoardView.h
//  NoticeBoard
//
//  Created by 小怪兽 on 15/3/5.
//  Copyright (c) 2015年 小怪兽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+BD.h"

/*-------------------------点击的代理----------------------------*/
@protocol GSNoticeBoardViewDelegate <NSObject>

- (void) didSelectAtIndex:(int)index;

@end
/*-------------------------点击的代理----------------------------*/


@interface GSNoticeBoardView : UIView

@property (nonatomic ,strong) NSMutableArray                   *contentArray;
@property (nonatomic ,assign) id<GSNoticeBoardViewDelegate> delegate;


/**
 *  开始滚动方法
 */
- (void)startAnimation;

- (void)stopAnimation;
@end





