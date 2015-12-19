//
//  BBGMenuHandleView.h
//  CellMenu
//
//  Created by Timmy OuYang on 15/11/3.
//  Copyright © 2015年 OuyangTimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBGCellPopupView;
@protocol BBGCellPopupViewDelegate;

@interface BBGMenuHandleView : UIView

/**
 *  @brief  判断是否响应点击事件
 */
@property (nonatomic, assign) BOOL isResponde;
/**
 *  @brief  回调代理（也可用block回调）
 */
@property (nonatomic, assign) id<BBGCellPopupViewDelegate> delegate;
/**
 *  @brief  正常显示title
 */
@property (nonatomic, strong) NSArray *normalTitles;
/**
 *  @brief  供cell传值，回调时会带回
 */
@property (nonatomic, strong) NSIndexPath *indexPath;


@end

typedef enum : NSUInteger {
    ShowLeft,
    ShowRight,
} MenuShowOritation;

typedef enum : NSUInteger {
    AnimationShrink,
    AnimationExpande,
} SelecteAnimationType;


@protocol BBGCellPopupViewDelegate;

@interface BBGCellPopupView : UIView

typedef void(^CellPopueViewTappedCallBack)(BBGCellPopupView *popupView,NSInteger index,NSInteger cellRow);

/**
 *  @brief  供cell传值，回调时会带回
 */
@property (nonatomic, assign) NSInteger cellRow;
/**
 *  @brief  供cell传值，回调时会带回
 */
@property (nonatomic, strong) NSIndexPath *indexPath;
/**
 *  @brief  回调代理（也可用block回调）
 */
@property (nonatomic, assign) id<BBGCellPopupViewDelegate> delegate;
/**
 *  @brief  显示方向（Left/Right）
 */
@property (nonatomic, assign) MenuShowOritation showOritation;
/**
 *  @brief  menu item选中状态时按钮
 */
@property (nonatomic, strong) NSArray *hilightedTitles;
/**
 *  @brief  正常显示title
 */
@property (nonatomic, strong) NSArray *normalTitles;

/**
 *  @brief  初始化工作
 *
 *  @param view     被点击的View（menuView会从这个视图边上弹出）
 *  @param callBack block回调
 *  @param titles   显示的title
 *
 *  @return self
 */
- (instancetype)initWithHandleView:(UIView *)view
                  selectedCallBack:(CellPopueViewTappedCallBack)callBack
                            titles:(NSString *)titles, ...NS_REQUIRES_NIL_TERMINATION;
- (void)selectedIndex:(NSInteger)index withAnimationType:(SelecteAnimationType)animationType;
- (void)show;

@end

@protocol BBGCellPopupViewDelegate <NSObject>

- (void)popupView:(BBGCellPopupView *)popupView didSeletedAtIndex:(NSInteger)index cellIndexPath:(NSIndexPath *)cellIndex;

@end
