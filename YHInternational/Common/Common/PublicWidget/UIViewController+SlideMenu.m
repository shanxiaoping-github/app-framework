//
//  UIViewController+SlideMenu.m
//  Common
//
//  Created by Timmy Ouyang on 15/4/25.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "UIViewController+SlideMenu.h"
#import "UIView+Animations.h"

#define ISOPENING @"ISOPENING"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation UIViewController (SlideMenu)

- (void)slideMenuViewController:(UIViewController *)menuViewController
              animationDuration:(NSTimeInterval)duration
                      slideTyep:(TMSlideType)slideType
                     completion:(void (^)(BOOL finished))completion {
    NSAssert(menuViewController, @"menuViewController can't nil");
    self.duration = [NSNumber numberWithDouble:duration];
    self.menuViewController = menuViewController;
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self move];
}

- (void)panDetected:(UIPanGestureRecognizer *)aPanRecognizer {

    if (aPanRecognizer.state == UIGestureRecognizerStateEnded) {
        if ([self.enableSwipeGesture integerValue] == 1) {
            [self move];
        }
    }
}

- (void)move {

    if ([self isMenuOpen]) {
        [UIView animateWithDuration:[self.duration doubleValue] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            float leftOffset = self.view.bounds.size.width - leftMargin;
            CGPoint center = self.navigationController.view.center;
            [self.navigationController.view setCenter:CGPointMake(center.x + leftOffset, center.y)];

            CGAffineTransform transformScale = CGAffineTransformMakeScale(0.8, 0.8);
            self.menuViewController.view.transform = transformScale;
            self.menuViewController.view.alpha = 0;

        } completion:^(BOOL finished) {
            
        }];
        
        //关闭menu，移除侧滑手势
        self.enableSwipeGesture = [NSNumber numberWithBool:NO];

    }else {

        //打开menu，添加侧滑手势
        self.enableSwipeGesture = [NSNumber numberWithBool:YES];

        [UIView animateWithDuration:[self.duration doubleValue] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            float leftOffset = self.view.bounds.size.width - leftMargin;
            CGPoint center = self.navigationController.view.center;
            [self.navigationController.view setCenter:CGPointMake(center.x-leftOffset, center.y)];
            self.navigationController.view.layer.shadowColor = [UIColor grayColor].CGColor;
            self.navigationController.view.layer.shadowRadius = 5;
            self.navigationController.view.layer.shadowOpacity = 0.5;
            self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
            self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
            [self.navigationController.view.superview insertSubview:self.menuViewController.view belowSubview:self.navigationController.view];
            
            self.menuViewController.view.transform = CGAffineTransformIdentity;
            self.menuViewController.view.alpha = 1;

        } completion:^(BOOL finished) {
            
        }];
    }
}

- (BOOL)isMenuOpen
{
    return (self.horizontalLocation == 0) ? NO : YES;
}

- (CGFloat)horizontalLocation
{
    CGRect rect = self.navigationController.view.frame;
    UIInterfaceOrientation orientation = self.interfaceOrientation;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        return rect.origin.x;
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return (orientation == UIInterfaceOrientationLandscapeRight)
            ? rect.origin.y
            : rect.origin.y*-1;
        }
        else
        {
            return (orientation == UIInterfaceOrientationPortrait)
            ? rect.origin.x
            : rect.origin.x*-1;
        }
    }
}

- (UIViewController *)menuViewController {
    return objc_getAssociatedObject(self, @selector(menuViewController));
}

- (void)setMenuViewController:(UIViewController *)menuViewController {
    objc_setAssociatedObject(self, @selector(menuViewController), menuViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)enableSwipeGesture {
    return objc_getAssociatedObject(self, @selector(enableSwipeGesture));
}

- (void)setEnableSwipeGesture:(NSNumber *)enableSwipeGesture {
    objc_setAssociatedObject(self, @selector(enableSwipeGesture), enableSwipeGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([enableSwipeGesture boolValue]) {
        [self.view addGestureRecognizer:self.panRecognizer];
    }else {
        [self.view removeGestureRecognizer:self.panRecognizer];
    }
}

- (NSNumber *)duration {
    return objc_getAssociatedObject(self, @selector(duration));
}

- (void)setDuration:(NSNumber *)duration {
    objc_setAssociatedObject(self, @selector(duration), duration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPanGestureRecognizer *)panRecognizer {
    return objc_getAssociatedObject(self, @selector(panRecognizer));
}

- (void)setPanRecognizer:(UIPanGestureRecognizer *)panRecognizer {
    objc_setAssociatedObject(self, @selector(panRecognizer), panRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
