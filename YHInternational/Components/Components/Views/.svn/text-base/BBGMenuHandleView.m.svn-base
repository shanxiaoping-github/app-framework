//
//  BBGMenuHandleView.m
//  CellMenu
//
//  Created by Timmy OuYang on 15/11/3.
//  Copyright © 2015年 OuyangTimmy. All rights reserved.
//

#import "BBGMenuHandleView.h"

#define BUTTON_WIDTH 90
#define MENU_HEIGHT 38

@interface BBGCellPopupView ()

@property (nonatomic, copy) CellPopueViewTappedCallBack callBack;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) BBGMenuHandleView *handleView;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSMutableArray *allItemsButton;

@end


@implementation BBGMenuHandleView

- (void)awakeFromNib {

    self.isResponde = YES;
}

- (IBAction)buttonPressed:(id)sender {

    if (self.isResponde) {
        
        BBGCellPopupView *cellPopupView = [[BBGCellPopupView alloc] initWithHandleView:self selectedCallBack:^(BBGCellPopupView *popupView, NSInteger index, NSInteger cellRow) {
            
        } titles:@"点赞",@"回复", nil];
        cellPopupView.delegate = self.delegate;
        if (self.normalTitles) {
            cellPopupView.normalTitles = self.normalTitles;
        }
        cellPopupView.indexPath = self.indexPath;
        [cellPopupView show];
        NSArray *selectedTittleArray = [NSArray arrayWithObjects:@"取消赞",@"回复", nil];
        cellPopupView.hilightedTitles = selectedTittleArray;
    }else {
        self.isResponde = YES;
    }

}

@end

@implementation BBGCellPopupView

- (instancetype)initWithHandleView:(UIView *)view
                  selectedCallBack:(CellPopueViewTappedCallBack)callBack
                            titles:(NSString *)titles, ...NS_REQUIRES_NIL_TERMINATION {
    self = [super init];
    if (self) {
        
        //获取title内容及个数
        va_list varList;
        id arg;
        NSMutableArray *array = [NSMutableArray array];
        if(titles){
            va_start(varList,titles);
            [array addObject:titles];
            while((arg = va_arg(varList,id))){
                [array addObject:arg];
            }
            va_end(varList);
        }
        self.titleArray = array;
        self.callBack = callBack;
        self.handleView = (BBGMenuHandleView *)view;
        
        _allItemsButton = [NSMutableArray array];
        
        [self initMenuView];
    }
    return self;
}

- (void)initMenuView {
    
    
}

- (void)show {
    
    //背景气泡
    UIImage *image = [UIImage imageNamed:@"PraiseComment"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:image];
    backImageView.frame = CGRectMake(0, 0, BUTTON_WIDTH*self.titleArray.count, MENU_HEIGHT);
    [self addSubview:backImageView];
    
    if (self.normalTitles.count>0) {
        [self.titleArray removeAllObjects];
        [self.titleArray addObjectsFromArray:self.normalTitles];
    }
    for (int i = 0; i < self.titleArray.count; i++) {
        NSString *title = [self.titleArray objectAtIndex:i];
        NSString *seletedTitle = [self.hilightedTitles objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:seletedTitle forState:UIControlStateHighlighted];
        [btn setFrame:CGRectMake(BUTTON_WIDTH, 0, BUTTON_WIDTH, MENU_HEIGHT)];
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTag:i];
        btn.alpha = 0;
        [self.allItemsButton addObject:btn];
        [self addSubview:btn];
    }
    
    if (self.isShow) {
        [self hideMenuView];
    }else {
        switch (self.showOritation) {
            case ShowLeft:
            {
                [self setFrame:CGRectMake(self.handleView.frame.origin.x-90, 0, 0, MENU_HEIGHT)];
                [self setCenter:CGPointMake(0, self.handleView.center.y)];
                [self.handleView.superview addSubview:self];
            }
                break;
            case ShowRight:
                [self setFrame:CGRectMake(0, 0, BUTTON_WIDTH*self.titleArray.count, MENU_HEIGHT)];
                [self setCenter:CGPointMake(self.handleView.frame.origin.x+self.handleView.frame.size.width+BUTTON_WIDTH*self.titleArray.count/2, self.handleView.center.y)];
                break;
                
                
            default:
                break;
        }
        [self animation];
        self.isShow = YES;
        
    }
}

- (void)hideMenuView {
    
    [self removeFromSuperview];
}

- (void)selectedIndex:(NSInteger)index withAnimationType:(SelecteAnimationType)animationType {

}

- (void)animation {
    
    if (!self.isShow) {
        if (self.showOritation == ShowLeft) {
            
            [UIView animateWithDuration:0.1 animations:^{
                [self setFrame:CGRectMake(0, 0, BUTTON_WIDTH*self.titleArray.count, MENU_HEIGHT)];
                [self setCenter:CGPointMake(self.handleView.frame.origin.x-BUTTON_WIDTH*self.titleArray.count/2, self.handleView.center.y)];
            } completion:^(BOOL finished) {
                for (int i = 0; i<self.allItemsButton.count; i++) {
                    UIButton *btn = [self.allItemsButton objectAtIndex:i];
                    [UIView animateWithDuration:0.2 animations:^{
                        btn.alpha = 1;
                        [btn setFrame:CGRectMake(BUTTON_WIDTH*i, 0, BUTTON_WIDTH, MENU_HEIGHT)];
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                
            }];
            
        }else if (self.showOritation == ShowRight) {
            
        }
    }
}

- (void)buttonPressed:(UIButton *)sender {
    
    //block callBack
    if (self.callBack) {
        self.callBack(self,sender.tag,self.cellRow);
    }
    
    //delegate callBack
    if (self.delegate && [self.delegate respondsToSelector:@selector(popupView:didSeletedAtIndex:cellIndexPath:)]) {
        [self.delegate popupView:self didSeletedAtIndex:sender.tag cellIndexPath:self.indexPath];
    }
    
    [self removeFromSuperview];
}

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    
    BOOL hitView = [self pointInside:point withEvent:event];
    CGPoint  superPoint = [self.superview convertPoint:point fromView:self];
    BOOL  isHandlePoint = CGRectContainsPoint(self.handleView.frame, superPoint);
    if (!hitView) {
        
        //点击当前View之外的位置
        if (isHandlePoint) {
            
            //点击了handleView
            if (self.isShow) {
                [self removeFromSuperview];
                self.isShow = NO;
                self.handleView.isResponde = NO;
            }
        }else {
            [self removeFromSuperview];
            self.isShow = NO;
        }
    }
    return [super hitTest:point withEvent:event];
}

@end

