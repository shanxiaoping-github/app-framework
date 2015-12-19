//

// UIScrollView+SVInfiniteScrolling.m

//

// Created by Sam Vermette on 23.04.12.

// Copyright (c) 2012 samvermette.com. All rights reserved.

//

// https://github.com/samvermette/SVPullToRefresh

//



#import <QuartzCore/QuartzCore.h>

#import "UIScrollView+SVInfiniteScrolling.h"

#import "BBGMacro.h"

#import "BlocksKit.h"

static CGFloat const SVInfiniteScrollingViewHeight = 80;



@interface SVInfiniteScrollingDotView : UIView



@property (nonatomic, strong) UIColor *arrowColor;



@end







@interface SVInfiniteScrollingView ()



@property (nonatomic, copy) void (^infiniteScrollingHandler)(void);

@property (nonatomic, copy) void (^completionScrollingHandler)(void);


@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, readwrite) SVInfiniteScrollingState state;

@property (nonatomic, strong) NSMutableArray *viewForState;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, readwrite) CGFloat originalBottomInset;

@property (nonatomic, assign) BOOL wasTriggeredByUser;

@property (nonatomic, assign) BOOL isObserving;

@property (nonatomic, strong) BBGLoadingMoreView * moreView;



- (void)resetScrollViewContentInset;

- (void)setScrollViewContentInsetForInfiniteScrolling;

- (void)setScrollViewContentInset:(UIEdgeInsets)insets;



@end







#pragma mark - UIScrollView (SVInfiniteScrollingView)

#import <objc/runtime.h>



static char UIScrollViewInfiniteScrollingView;

UIEdgeInsets scrollViewOriginalContentInsets;



@implementation UIScrollView (SVInfiniteScrolling)



@dynamic infiniteScrollingView;



- (void)addInfiniteScrollingWithActionHandler:(void (^)(void))actionHandler {
    
    
    
    if(!self.infiniteScrollingView) {
        
        SVInfiniteScrollingView *view = [[SVInfiniteScrollingView alloc] initWithFrame:CGRectMake(0, self.contentSize.height, self.bounds.size.width, SVInfiniteScrollingViewHeight)];
        
        view.infiniteScrollingHandler = actionHandler;
        
        view.scrollView = self;
        view.tag = 6789;
        
        [self addSubview:view];
        
        /**
         摇摆动画
         */
        view.moreView = [[BBGLoadingMoreView alloc]initAnimationViewWithFrame:CGRectMake(self.bounds.size.width / 2 - 90, 10, 119, 42)];
        
        [view setCustomView:view.moreView.animationImageView forState:SVInfiniteScrollingStateAll];

        
        view.originalBottomInset = self.contentInset.bottom + 70;
        
        self.infiniteScrollingView = view;
        
        self.showsInfiniteScrolling = YES;
        
    }
    
}



- (void)triggerInfiniteScrolling {
    
    self.infiniteScrollingView.state = SVInfiniteScrollingStateTriggered;
    
    [self.infiniteScrollingView startAnimating];
    
}



- (void)setInfiniteScrollingView:(SVInfiniteScrollingView *)infiniteScrollingView {
    
    [self willChangeValueForKey:@"UIScrollViewInfiniteScrollingView"];
    
    objc_setAssociatedObject(self, &UIScrollViewInfiniteScrollingView,
                             
                             infiniteScrollingView,
                             
                             OBJC_ASSOCIATION_ASSIGN);
    
    [self didChangeValueForKey:@"UIScrollViewInfiniteScrollingView"];
    
}



- (SVInfiniteScrollingView *)infiniteScrollingView {
    
    return objc_getAssociatedObject(self, &UIScrollViewInfiniteScrollingView);
    
}



- (void)setShowsInfiniteScrolling:(BOOL)showsInfiniteScrolling {
    
    self.infiniteScrollingView.hidden = !showsInfiniteScrolling;
    
    
    
    if(!showsInfiniteScrolling) {
        if (self.infiniteScrollingView.isObserving) {
            
//            self.infiniteScrollingView.titlelabel.alpha = 0.0;
            
            [self removeObserver:self.infiniteScrollingView forKeyPath:@"contentOffset"];
            
            [self removeObserver:self.infiniteScrollingView forKeyPath:@"contentSize"];
            
            self.infiniteScrollingView.originalBottomInset = 0;
            
            [self.infiniteScrollingView resetScrollViewContentInset];
            
            self.infiniteScrollingView.isObserving = NO;
            
        }
        
    }
    
    else {
        
        self.infiniteScrollingView.originalBottomInset = 70;
        
        if (!self.infiniteScrollingView.isObserving) {
            
            [self addObserver:self.infiniteScrollingView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            
            [self addObserver:self.infiniteScrollingView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            
            [self.infiniteScrollingView setScrollViewContentInsetForInfiniteScrolling];
            
            self.infiniteScrollingView.isObserving = YES;
            
            
            
            [self.infiniteScrollingView setNeedsLayout];
            
            self.infiniteScrollingView.frame = CGRectMake(0, self.contentSize.height, self.infiniteScrollingView.bounds.size.width, SVInfiniteScrollingViewHeight);
            
        }
        
    }
    
}



- (BOOL)showsInfiniteScrolling {
    
    return !self.infiniteScrollingView.hidden;
    
}



@end





#pragma mark - SVInfiniteScrollingView

@implementation SVInfiniteScrollingView



// public properties

@synthesize infiniteScrollingHandler, activityIndicatorViewStyle;



@synthesize state = _state;

@synthesize scrollView = _scrollView;

@synthesize activityIndicatorView = _activityIndicatorView;

//@synthesize titlelabel = _titlelabel;



- (id)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
//        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width /2.0) - 30, 15, 100, 20)];
//        _titlelabel.font = APP_FONT(13.0);
//        _titlelabel.textColor = UIColorFromHexadecimalRGB(0xc0c0c0);
//        [self addSubview:_titlelabel];
//        self.titlelabel.backgroundColor = [UIColor clearColor];
//        self.titlelabel.text = @"上拉加载";
//        self.titlelabel.alpha = 0.0;
        // default styling values
        
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.state = SVInfiniteScrollingStateStopped;
        
        self.enabled = YES;
        
        
        
        self.viewForState = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", nil];
        
    }
    
    
    
    return self;
    
}



- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    if (self.superview && newSuperview == nil) {
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        
        if (scrollView.showsInfiniteScrolling) {
            
            if (self.isObserving) {
                
                [scrollView removeObserver:self forKeyPath:@"contentOffset"];
                
                [scrollView removeObserver:self forKeyPath:@"contentSize"];
                
                self.isObserving = NO;
                
            }
            
        }
        
    }
    
}



- (void)layoutSubviews {
    
    self.activityIndicatorView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
}



#pragma mark - Scroll View



- (void)resetScrollViewContentInset {
    
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    
    currentInsets.bottom = self.originalBottomInset;
    
    [self setScrollViewContentInset:currentInsets];
    
}



- (void)setScrollViewContentInsetForInfiniteScrolling {
    
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    
//    currentInsets.bottom = self.originalBottomInset + SVInfiniteScrollingViewHeight;
    currentInsets.bottom = self.originalBottomInset;
    [self setScrollViewContentInset:currentInsets];
    
}



- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
    
    [UIView animateWithDuration:0.3
     
                          delay:0
     
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
     
                     animations:^{
                         
                         self.scrollView.contentInset = contentInset;
                         
                     }
     
                     completion:NULL];
    
}



#pragma mark - Observing



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if([keyPath isEqualToString:@"contentOffset"])
        
        [self scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    
    else if([keyPath isEqualToString:@"contentSize"]) {
        [self layoutSubviews];
        
        self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.bounds.size.width, SVInfiniteScrollingViewHeight);
    }
    
}



- (void)scrollViewDidScroll:(CGPoint)contentOffset {
    
    if(self.state != SVInfiniteScrollingStateLoading && self.enabled) {
        
        CGFloat scrollViewContentHeight = self.scrollView.contentSize.height;
        
        CGFloat scrollOffsetThreshold = scrollViewContentHeight-self.scrollView.bounds.size.height + -30;
        
        
        
        if(!self.scrollView.isDragging && self.state == SVInfiniteScrollingStateTriggered){
            
            self.state = SVInfiniteScrollingStateLoading;
            
            
            
        }
        
        else if(contentOffset.y > scrollOffsetThreshold && self.state == SVInfiniteScrollingStateStopped && self.scrollView.isDragging && self.scrollView.contentOffset.y > 0)
            
            self.state = SVInfiniteScrollingStateTriggered;
        
        else if(contentOffset.y < scrollOffsetThreshold  && self.state != SVInfiniteScrollingStateStopped)
        {
            self.state = SVInfiniteScrollingStateStopped;
        }
    }
    
    if (contentOffset.y < self.scrollView.contentSize.height && self.scrollView.isDragging == YES) {
        [self resetScrollViewContentInset];
    }
}



#pragma mark - Getters



- (UIActivityIndicatorView *)activityIndicatorView {
    
    if(!_activityIndicatorView) {
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
        _activityIndicatorView.hidesWhenStopped = YES;
        
        [self addSubview:_activityIndicatorView];
        
    }
    
    return _activityIndicatorView;
    
}



- (UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    
    return self.activityIndicatorView.activityIndicatorViewStyle;
    
}



#pragma mark - Setters



- (void)setCustomView:(UIView *)view forState:(SVInfiniteScrollingState)state {
    
    id viewPlaceholder = view;
    
    
    
    if(!viewPlaceholder)
        
        viewPlaceholder = @"";
    
    
    
    if(state == SVInfiniteScrollingStateAll)
        
        [self.viewForState replaceObjectsInRange:NSMakeRange(0, 3) withObjectsFromArray:@[viewPlaceholder, viewPlaceholder, viewPlaceholder]];
    
    else
        
        [self.viewForState replaceObjectAtIndex:state withObject:viewPlaceholder];
    
    
    
    self.state = self.state;
    
}



- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)viewStyle {
    
    self.activityIndicatorView.activityIndicatorViewStyle = viewStyle;
    
}



#pragma mark -



- (void)triggerRefresh {
    
    self.state = SVInfiniteScrollingStateTriggered;
    
    self.state = SVInfiniteScrollingStateLoading;
    
}



- (void)startAnimating{
    
    self.state = SVInfiniteScrollingStateLoading;
    
}

- (void)stopAnimating:(FlyingAction)block{
    
    SVInfiniteScrollingState previousState = _state;
    if (previousState == SVInfiniteScrollingStateLoading && self.enabled == YES) {
        __weak SVInfiniteScrollingView * weakSelf = self;
        [self.moreView startFlyingAnimatingWithCompletion:^{

            if (block) {
                block();
            }

            weakSelf.state = SVInfiniteScrollingStateStopped;

        }];
    }

}

- (void)stopAnimating {
    
    self.state = SVInfiniteScrollingStateStopped;
    
}



- (void)setState:(SVInfiniteScrollingState)newState {
    
    
    if(_state == newState)
        
        return;
    
    
    
    SVInfiniteScrollingState previousState = _state;
    
    _state = newState;
    
    
    
    for(id otherView in self.viewForState) {
        
        if([otherView isKindOfClass:[UIView class]])
            
            [otherView removeFromSuperview];
        
    }
    
    
    
    id customView = [self.viewForState objectAtIndex:newState];
    
    BOOL hasCustomView = [customView isKindOfClass:[UIView class]];
    
    
    
    if(hasCustomView) {
        
        [self addSubview:customView];
        
        CGRect viewBounds = [customView bounds];
        
        CGPoint origin = CGPointMake(roundf((self.bounds.size.width-viewBounds.size.width)/2), roundf((self.bounds.size.height-viewBounds.size.height)/2));
        
        [customView setFrame:CGRectMake(origin.x + 12, origin.y - 10, viewBounds.size.width, viewBounds.size.height)];
        
        if (newState == SVInfiniteScrollingStateTriggered) {
//            self.scrollView.infiniteScrollingView.titlelabel.alpha = 0.0;
            [self.scrollView.infiniteScrollingView.moreView stopAnimating];
            [self.scrollView.infiniteScrollingView.moreView startSwingAnimating];
//            if (self.titlelabel.alpha == 1.0) {
//                self.titlelabel.alpha = 0.0;
//            }
        }
        if (newState == SVInfiniteScrollingStateStopped) {
//            WS(weakSelf)
            [self bk_performBlock:^(id obj) {
//                weakSelf.scrollView.infiniteScrollingView.titlelabel.alpha = 1.0;
                
            } afterDelay:0.7];

            [self.scrollView.infiniteScrollingView.moreView stopAnimating];
        }
        //        if (newState == SVInfiniteScrollingStateLoading) {
////            [self.scrollView.infiniteScrollingView.moreView startFlyingAnimating];
//            
//
//        }
//        
//        if (newState == SVInfiniteScrollingStateStopped) {
//
////            [self.scrollView.infiniteScrollingView.moreView startSwingAnimating];
//
////            [self.scrollView.infiniteScrollingView.moreView stopAnimating];
//
//        }
        
    }
    
    else {
        
        CGRect viewBounds = [self.activityIndicatorView bounds];
        
        CGPoint origin = CGPointMake(roundf((self.bounds.size.width-viewBounds.size.width)/2), roundf((self.bounds.size.height-viewBounds.size.height)/2));
        
        [self.activityIndicatorView setFrame:CGRectMake(origin.x, origin.y, viewBounds.size.width, viewBounds.size.height)];
        
        
        
        switch (newState) {
                
            case SVInfiniteScrollingStateStopped:
                
                [self.activityIndicatorView stopAnimating];
                
                break;
                
                
                
            case SVInfiniteScrollingStateTriggered:
                
                [self.activityIndicatorView startAnimating];
                
                break;
                
                
                
            case SVInfiniteScrollingStateLoading:
                
                [self.activityIndicatorView startAnimating];
                
                break;
                
        }
        
    }
    
    
    
    if(previousState == SVInfiniteScrollingStateTriggered && newState == SVInfiniteScrollingStateLoading && self.infiniteScrollingHandler && self.enabled){
        UIEdgeInsets currentInsets = self.scrollView.contentInset;
        
        currentInsets.bottom = self.originalBottomInset + SVInfiniteScrollingViewHeight;
        
        [self setScrollViewContentInset:currentInsets];
        
        self.infiniteScrollingHandler();

    }
    
    
    
}



@end

