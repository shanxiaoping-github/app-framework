//
//  BBGAlertView.m
//  BBGAlertView
//
//  Created by yangjie on 15/4/21.
//  Copyright (c) 2015年 yangjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGLineView.h"
#import "Common.h"


#define KAlertViewTage 99999
#define KAlertLeftMargin 24.0f
#define kAlertWidth MIN(IPHONE_WIDTH-KAlertLeftMargin*2, 400)
#define kAlertHeight 180.0f
#define kAlertButtonHeight 40.0f

@interface BBGAlertView : UIView

@property (nonatomic, strong) UIView *backColorView;
@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *messagelabel;

@property (nonatomic, copy) void (^didDismissBlock)(BBGAlertView *alertView, NSInteger buttonIndex);

@end

@implementation BBGAlertView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kAlertWidth, kAlertHeight);
        [self setCenter:CGPointMake(IPHONE_WIDTH/2.0, self.center.y)];
        self.clipsToBounds = YES;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
            message:(NSString *)message
            handler:(void (^)(BBGAlertView *alertView, NSInteger buttonIndex))block
       buttonTitles:(NSString *)buttonTitles ,...{
    
    NSMutableArray *buttonTitleArray = [[NSMutableArray alloc] init];
    
    va_list argList;
    id arg;
    if (buttonTitles) {
        [buttonTitleArray addObject:buttonTitles];
        va_start(argList, buttonTitles);
        while ((arg = va_arg(argList, id))) {
            [buttonTitleArray addObject:arg];
        }
        va_end(argList);
    }
    
    self =  [self initWithTitle:title message:message buttonTitles:buttonTitleArray handler:block];
    
    return self;
}

+ (instancetype)showWithTitle:(NSString *)title
            message:(NSString *)message
            handler:(void (^)(BBGAlertView *alertView, NSInteger buttonIndex))block
       buttonTitles:(NSString *)buttonTitles ,...{
    
    NSMutableArray *buttonTitleArray = [[NSMutableArray alloc] init];
    
    va_list argList;
    id arg;
    if (buttonTitles) {
        [buttonTitleArray addObject:buttonTitles];
        va_start(argList, buttonTitles);
        while ((arg = va_arg(argList, id))) {
            [buttonTitleArray addObject:arg];
        }
        va_end(argList);
    }
    
    BBGAlertView *alertView = [[BBGAlertView alloc] initWithTitle:title message:message buttonTitles:buttonTitleArray handler:block];
    alertView.tag = KAlertViewTage;
    [alertView show];
    return alertView;
}

- (instancetype)initWithTitle:(NSString *)title
            message:(NSString *)message     
       buttonTitles:(NSArray *)buttonTitles
            handler:(void (^)(BBGAlertView *alertView, NSInteger buttonIndex))block{
    self = [self init];
    
    if (!self.didDismissBlock){
        self.didDismissBlock = block;
    }
    
    _alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    [_alertTitleLabel setBackgroundColor:RGB_COLOR(243, 69, 104)];
    [_alertTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_alertTitleLabel setTextColor:[UIColor whiteColor]];
    self.alertTitleLabel.font = APP_FONT(17);
    [self addSubview:self.alertTitleLabel];
    
    UIButton *closeBtn = [UIButton buttonWithMyImage:@"Cancel_white" Frame:CGRectMake(-4, -4, 50, 50)];
    //[closeBtn setBackgroundColor:[UIColor redColor]];
    [closeBtn addTarget:self action:@selector(closeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    
    float messageLabelHight = FRAMEH(self)-YBOTTOM(_alertTitleLabel)-kAlertButtonHeight;
    if ([buttonTitles count] == 0) {
        messageLabelHight += kAlertButtonHeight;
    }
    _messagelabel = [[UILabel alloc] initWithFrame:CGRectMake(4, GETBOTTOMORIGIN_Y(_alertTitleLabel), FRAMEW(self)-4*2, messageLabelHight)];
    [_messagelabel setTextAlignment:NSTextAlignmentCenter];
    [_messagelabel setNumberOfLines:0];
    [_messagelabel setTextColor:UICOLOR_FONT_IMPORTANT_BLACK];
    [_messagelabel setFont:APP_FONT(15)];
    [self addSubview:_messagelabel];
    
    [_alertTitleLabel setText:title];
    [_messagelabel setText:message];
    
    
    if ([buttonTitles count] > 0) {
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, GETBOTTOMORIGIN_Y(_messagelabel), GETWIDTH(self), kAlertButtonHeight)];
        [self addSubview:buttonView];
        
        BBGLineView *lineview = [BBGLineView horizonlineWithStart:CGPointMake(0, 1) len:GETWIDTH(buttonView) width:0.5 color:UICOLOR_BACKGROUND_HILIGHT_GRAY];
        [buttonView addSubview:lineview];
        
        float buttonWidth = GETWIDTH(self)/[buttonTitles count];
        for (int i=0; i<[buttonTitles count]; i++) {
            NSString *titleStr = [buttonTitles objectAtIndex:i];
            
            UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, kAlertButtonHeight)];
            titleButton.tag = i+1000;
            [titleButton setTitle:titleStr forState:UIControlStateNormal];
            [titleButton.titleLabel setFont:APP_FONT(14)];
            [titleButton setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
            [titleButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
            [titleButton addTarget:self action:@selector(titleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [buttonView addSubview:titleButton];
            
            BBGLineView *gapLineView = [BBGLineView verticallineWithStart:CGPointMake(i*buttonWidth, 0) len:kAlertButtonHeight width:0.5 color:[UIColor lightGrayColor]];
            [buttonView addSubview:gapLineView];
        }
    }
    
    return self;
}

-(void)titleButtonPressed:(id)sender{
    NSInteger tag = ((UIButton*)sender).tag - 1000;
    self.didDismissBlock(self,tag);
    [self didDismiss];
}

- (void)closeBtnPressed:(id)sender{
    self.didDismissBlock(self,1000);
    [self didDismiss];
}

- (void)didDismiss{
    CGRect afterFrame = CGRectMake(GETORIGIN_X(self), IPHONE_HEIGHT+30, kAlertWidth, kAlertHeight);
    
    __weak BBGAlertView *weakSelf = self;
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        weakSelf.backColorView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [weakSelf.backColorView removeFromSuperview];
        weakSelf.backColorView = nil;
        [weakSelf removeFromSuperview];
    }];
}

- (void)show{
    BBGAlertView *alertView = (BBGAlertView*)[[UIApplication sharedApplication].keyWindow viewWithTag:KAlertViewTage];
    if ([alertView isKindOfClass:[BBGAlertView class]] && alertView != nil) {
        [alertView didDismiss];
    }
    
    if (!_backColorView) {
        _backColorView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _backColorView.backgroundColor = [UIColor blackColor];
        _backColorView.alpha = 0.0f;
        _backColorView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:_backColorView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    __weak BBGAlertView *weakSelf = self;
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakSelf.backColorView.alpha = 0.6f;
        weakSelf.transform = CGAffineTransformMakeRotation(0);
        [weakSelf setCenter:CGPointMake(IPHONE_WIDTH/2.0, IPHONE_HEIGHT/2.0)];
    } completion:^(BOOL finished) {
    }];

}


-(void)dealloc{
    NSLog(@"%@ dealloc",self.class);
}

@end
