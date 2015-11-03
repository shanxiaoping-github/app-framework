//
//  CustomerProgressLableView.h
//  gigold
//
//  Created by 单小萍 on 15/10/31.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CustomerProgressLableView : UITableViewCell
//弧度
@property(nonatomic,assign)CGFloat radian;
//背景color
@property(nonatomic,strong)UIColor* backgoundCustomerColor;
//progressColor
@property(nonatomic,strong)UIColor* progressColor;
//进度值
@property(nonatomic,assign)CGFloat progressValue;
//最大值
@property(nonatomic,assign)CGFloat maxValue;
//左侧标签值
@property(nonatomic,copy)NSString* leftlabelStr;
//跟随标签
@property(nonatomic,copy)NSString* flowlabelStr;
//左边标签颜色
@property(nonatomic,strong)UIColor* leftlabelColor;
@property(nonatomic,strong)UIFont* leftlabelFont;
//跟随标签颜色
@property(nonatomic,strong)UIColor* flowlabelColor;
@property(nonatomic,strong)UIFont* flowlabelFont;
//绘制进度
-(void)drawProgress;
@end
