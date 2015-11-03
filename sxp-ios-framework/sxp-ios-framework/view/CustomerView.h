//
//  CustomerView.h
//  gigold
//
//  Created by 单小萍 on 15/10/26.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"
#define default_background kColorWithRGB(0.f,0.f,0.f,0.4)

/*自定义view点击事件协议*/
@protocol CustomerViewClickDeleget <NSObject>
//点击事件 tag为事件标识
-(void)click:(NSString*)tag;
//点击事件，传递多个参数
-(void)clickParam:(NSDictionary*)param;
@end
/*自定义view弹出方式*/
typedef NS_ENUM(NSInteger,PullViewStyle){
    PullViewDown = 1 << 0,
    PullViewTop = 1 << 1,
    PullViewCenter = 1 << 2
};
@interface CustomerView : UIView
@property(nonatomic,assign)PullViewStyle pullStyle;
@property(nonatomic,strong)UIColor* backGroundColor;
@property(nonatomic,strong)UIView* showView;
@property(nonatomic,weak)id<CustomerViewClickDeleget> clickDeleget;
//动画时间
@property(nonatomic,assign)CGFloat animationTime;
//基线
@property(nonatomic,assign)CGFloat baseLineValue;
//是否是显示状态
-(BOOL)isShow;

//显示
-(void)showDialog:(UIView*)view;
-(void)showDialogByBaseLine:(CGFloat)baseLineValue view:(UIView*)view;
-(void)showDialogByViewBottom:(UIView*)view;
-(void)showDialogByVIewTop:(UIView*)view;
//关闭
-(void)stopDialog;

@end
