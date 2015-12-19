//
//  BBGTopicExplain.h
//  Components
//
//  Created by 黄 灿 on 15/10/21.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface BBGTopicExplainView : UIView
{
    UIScrollView *scrollerView;
    
    
    //多少行
    NSInteger numberLines;
    
    //右边按钮图片
    UIImageView *rightButtonImageView;
    //右边点击区域
    UIView *rightView;
    
    //是否展开
    BOOL isUnfurl;
}
- (void)reloadSubViews;
//往上移动的距离  动画的时间
- (void)moveViewWithDistance:(float)distance animationTime:(float)animationTime;
//数据源
@property(nonatomic,strong)NSArray *dataArray;

//存储已选择的话题（用01数组存储 0表示未选中，1表示已选中）
@property(nonatomic,strong)NSMutableArray  *tempArray;
@end
