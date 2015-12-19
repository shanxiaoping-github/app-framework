//
//  CustomerView.h
//  gigold
//
//  Created by 单小萍 on 15/10/26.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"
#define UN_CONTENT_CLIP_STOP @"un_content_clip_stop"
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
    PullViewCenter = 1 << 2,
    PullViewLeft = 1 << 3,
    PullviewRight = 1 << 4
};
@interface CustomerView : UIView
//弹出动画方式
@property(nonatomic,assign)PullViewStyle pullStyle;
//显示底色
@property(nonatomic,strong)UIColor* backGroundColor;
//显示内容
@property(nonatomic,strong)UIView* showView;
//点击非内容区域是否消失
@property(nonatomic,assign)BOOL isClickOutsideCancel;
//事件代理器
@property(nonatomic,weak)id<CustomerViewClickDeleget> clickDeleget;
//动画时间
@property(nonatomic,assign)CGFloat animationTime;
//基线
@property(nonatomic,assign)CGFloat baseLineValue;
//当前tag
@property(nonatomic,assign)NSString* currentTag;
//是否是显示状态
-(BOOL)isShow;
//显示
-(void)showDialog:(UIView*)view;
-(void)showDialogByBaseLine:(CGFloat)baseLineValue view:(UIView*)view;
-(void)showDialogByViewBottom:(UIView*)view;
-(void)showDialogByViewTop:(UIView*)view;
-(void)showDialogByViewLeft:(UIView *)view;
-(void)showDialogByViewRight:(UIView *)view;
//关闭
-(void)stopDialog;

@end
