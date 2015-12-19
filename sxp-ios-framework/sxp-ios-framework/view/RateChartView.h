//
//  RateChartView.h
//  TestChart
//  百分率曲线图
//  Created by 单小萍 on 15/12/4.
//  Copyright © 2015年 单小萍. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol RateChartDeleget <NSObject>
//x
-(NSArray*)rateChartXArray;
//y
-(NSArray*)rateChartYArray;
//最大值得
-(CGFloat)maxValue;
@end
@interface RateChartView : UIView
{
	UILabel* maxLabel;
	UIView* arcView;
}
//线的颜色
@property(nonatomic,strong)UIColor* lineColor;
//字体颜色
@property(nonatomic,strong)UIColor* fontColor;
//曲线颜色
@property(nonatomic,strong)UIColor* chartColor;
//填充颜色
@property(nonatomic,strong)UIColor* fillColor;
//文字字体
@property(nonatomic,strong)UIFont* textFont;
//标记字体
@property(nonatomic,strong)UIFont* markFont;
//是否显示最大值
@property(nonatomic,assign)BOOL isShowMaxValue;
//是否当前标记
@property(nonatomic,assign)BOOL isCurrentMark;
//deleget
@property(nonatomic,strong)id<RateChartDeleget>deleget;

@end
