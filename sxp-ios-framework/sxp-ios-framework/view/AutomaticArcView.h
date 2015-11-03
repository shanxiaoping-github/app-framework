//
//  AutomaticArcView.h
//  gigold
//
//  Created by 单小萍 on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
//协议
@protocol AutomaticArcViewDeleget <NSObject>
//结束响应
-(void)automaticArcViewEndDraw;
@end

@interface AutomaticArcView : UIView
//起始弧度
@property(nonatomic,assign)CGFloat startRadian;
//结束弧度
@property(nonatomic,assign)CGFloat endRadian;
//圆弧颜色
@property(nonatomic,strong)UIColor* strokeColor;
//圆弧宽度
@property(nonatomic,assign)CGFloat strokeWidth;
//代理
@property(nonatomic,weak)id<AutomaticArcViewDeleget> deleget;
//绘制时间
@property(nonatomic,assign)CGFloat drawTime;
-(void)showAnimation;
@end
