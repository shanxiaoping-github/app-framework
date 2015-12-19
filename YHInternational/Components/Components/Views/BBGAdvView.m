//
//  BBGAdvView.m
//  TestAdvertisement
//
//  Created by calvin on 14-4-9.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGAdvView.h"
#import <Common/Utilities/BBGWeakTimer.h>

#define PAGESPACE 6
//pageControl上下间隔
#define PAGECONTROLUPANDDOWN 10
//自动翻页间隔时间
#define AUTOPAGETIME 4

@interface BBGPageControl : UIControl

@property(nonatomic, strong) UIImage *focusImage;
@property(nonatomic, strong) UIImage *pageImage;
@property(nonatomic, assign) NSInteger numberOfPages;
@property(nonatomic, assign) NSInteger currentPage;
@property(nonatomic, strong) UIImageView *focusImageView;

@end

@implementation BBGPageControl

- (id)initWithFocusImage:(UIImage *)fImage
               pageImage:(UIImage *)pImage
                   pages:(NSInteger)pageNumber
               pageSpace:(CGFloat)space {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _focusImage = fImage;
        _pageImage = pImage;
        if (pageNumber > 0) {
            _numberOfPages = pageNumber;
            CGFloat width = _pageImage.size.width;
            CGFloat height = _pageImage.size.height + 2 * PAGECONTROLUPANDDOWN;
            CGFloat totalWidth = 0.0;
            for (int i = 0; i < _numberOfPages; i ++) {
                UIImageView *pageImageView = [[UIImageView alloc] initWithImage:_pageImage];
                CGRect pageFrame = pageImageView.frame;
                pageFrame.origin.x = i * _pageImage.size.width + i * PAGESPACE;
                pageFrame.origin.y = PAGECONTROLUPANDDOWN;
                pageImageView.frame = pageFrame;
                [self addSubview:pageImageView];
                totalWidth = (i == 0) ? width : (totalWidth + width + PAGESPACE);
            }
            CGRect frame = self.frame;
            frame.size.width = totalWidth;
            frame.size.height = height;
            self.frame = frame;
            _focusImageView = [[UIImageView alloc] initWithImage:_focusImage];
            [self addSubview:_focusImageView];
            self.currentPage = 0;
        }
    }
    return self;
}


- (NSInteger)convertPointToPage:(CGPoint)point {
    return 0;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (currentPage >= _numberOfPages || currentPage < 0) {
        return;
    }
    _currentPage = currentPage;
    CGSize pageSize = _pageImage.size;
    CGPoint center = CGPointMake(pageSize.width / 2.0 + (pageSize.width + PAGESPACE) * currentPage, self.frame.size.height / 2.0);
    _focusImageView.center = center;
}

@end

@interface BBGAdvView () <UIScrollViewDelegate>

@property (nonatomic, strong) BBGPageControl *pageControl;
@property (nonatomic, strong) UIView *preView;
//@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) UIView *nextView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) BOOL scrollBegin;
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGRect originalFrame;

@end

@implementation BBGAdvView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        _loopScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _loopScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _loopScrollView.pagingEnabled = YES;
        _loopScrollView.showsHorizontalScrollIndicator = NO;
        _loopScrollView.showsVerticalScrollIndicator = NO;
        _loopScrollView.delegate = self;
        _loopScrollView.scrollsToTop = NO;
        _hiddenPageControlWhenOnePage = YES;
        [self addSubview:_loopScrollView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionOfAdvViewTapped:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)dealloc {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:NULL object:nil];
    _loopScrollView.delegate = nil;
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.originalFrame = frame;
}

- (void)actionOfAdvViewTapped:(UIGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(advView:didSelectViewAtPage:)]) {
        [self.delegate advView:self didSelectViewAtPage:_currentPage];
    }
}

- (void)createPageControl {
    if (_numberOfPages > 0 && _pageImage && _focusImage) {
        [_pageControl removeFromSuperview];
        _pageControl = nil;
        _pageControl = [[BBGPageControl alloc] initWithFocusImage:_focusImage pageImage:_pageImage pages:_numberOfPages pageSpace:PAGESPACE];
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _pageControl.hidden = (_numberOfPages == 1) && _hiddenPageControlWhenOnePage;
        CGRect frame = _pageControl.frame;
        frame.origin.x = (self.frame.size.width - frame.size.width) / 2.0;
        frame.origin.y = self.frame.size.height - frame.size.height;
        frame.origin.x += _pageControlEdgeInsets.left;
        frame.origin.x += _pageControlEdgeInsets.right;
        frame.origin.y += _pageControlEdgeInsets.top;
        frame.origin.y += _pageControlEdgeInsets.bottom;
        _pageControl.frame = frame;
        [self addSubview:_pageControl];
        _pageControl.hidden = (_numberOfPages == 1) && _hiddenPageControlWhenOnePage;
    }
}

- (NSInteger)calculatePageWhenScrollRight {
    NSInteger page = (self.loopScrollView.contentOffset.x - self.loopScrollView.frame.size.width) / self.loopScrollView.frame.size.width + 1;
    if (page == 0) {
        page = self.numberOfPages - 1;
    }else if(page == self.numberOfPages + 1) {
        page = 0;
    }else{
        page -= 1;
    }
    
    return page;
}

- (NSInteger)calculatePage {
    NSInteger page = (int)((self.loopScrollView.contentOffset.x - self.loopScrollView.frame.size.width) / self.loopScrollView.frame.size.width) + 1;
    if (page == 0) {
        page = self.numberOfPages - 1;
    }else if(page == self.numberOfPages + 1) {
        page = 0;
    }else{
        page -= 1;
    }
    
    return page;
}

- (void)updateFrame {
    CGSize scrollSize = _loopScrollView.frame.size;
    CGRect pFrame = _preView.frame;
    pFrame.origin = CGPointMake(_loopScrollView.contentOffset.x - scrollSize.width, 0);
    _preView.frame = pFrame;
    
    CGRect cFrame = _currentView.frame;
    cFrame.origin = _loopScrollView.contentOffset;
    _currentView.frame = cFrame;
    
    CGRect nFrame = _nextView.frame;
    nFrame.origin = CGPointMake(_loopScrollView.contentOffset.x + scrollSize.width, 0);
    _nextView.frame = nFrame;
    
}

- (void)updateAdvView {
    CGSize scrollSize = _loopScrollView.frame.size;
    NSInteger prePage = _currentPage;
    NSInteger curPage = _loopScrollView.contentOffset.x / scrollSize.width;
    self.currentPage = [self calculatePage];
    if (prePage == _currentPage) {
        return;
    }
    if (CGPointEqualToPoint(_loopScrollView.contentOffset, CGPointZero)) {
        _loopScrollView.contentOffset = CGPointMake(scrollSize.width * _numberOfPages, _loopScrollView.contentOffset.y);
    }else if (CGPointEqualToPoint(_loopScrollView.contentOffset, CGPointMake(scrollSize.width * (_numberOfPages + 1), _loopScrollView.contentOffset.y))) {
        _loopScrollView.contentOffset = CGPointMake(scrollSize.width, _loopScrollView.contentOffset.y);
    }
    if ([self.dataSource respondsToSelector:@selector(advView:viewForAdvViewAtPage:)]) {
        if (prePage < curPage) {
            //向左翻
            NSInteger next = _currentPage + 1 == _numberOfPages ? 0 : _currentPage + 1;
            [self.preView removeFromSuperview];
            self.preView = _currentView;
            self.currentView = _nextView;
            self.nextView = [self.dataSource advView:self viewForAdvViewAtPage:next];
            [_loopScrollView addSubview:_nextView];
        }else{
            //向右翻
            NSInteger pre = _currentPage - 1 < 0 ? _numberOfPages - 1 : _currentPage - 1;
            [self.nextView removeFromSuperview];
            self.nextView = _currentView;
            self.currentView = _preView;
            self.preView = [self.dataSource advView:self viewForAdvViewAtPage:pre];
            [_loopScrollView addSubview:_preView];
        }
        
        [self updateFrame];
    }else{
//        @throw [NSException exceptionWithName:@"没有实现相应的DataSource方法" reason:@"没有实现方法:advView:viewForAdvViewAtPage:" userInfo:nil];
    }
}

- (void)setFocusImage:(UIImage *)focusImage {
    _focusImage = focusImage;
    [self createPageControl];
}

- (void)setPageImage:(UIImage *)pageImage {
    _pageImage = pageImage;
    [self createPageControl];
}

- (void)setPageControlEdgeInsets:(UIEdgeInsets)pageControlEdgeInsets {
    if (!_pageControl) {
        return;
    }
    CGRect frame = _pageControl.frame;
    frame.origin.x = (self.frame.size.width - frame.size.width) / 2.0;
    frame.origin.y = self.frame.size.height - frame.size.height;
    frame.origin.x += _pageControlEdgeInsets.left;
    frame.origin.x += _pageControlEdgeInsets.right;
    frame.origin.y += _pageControlEdgeInsets.top;
    frame.origin.y += _pageControlEdgeInsets.bottom;
    _pageControl.frame = frame;
}

- (void)setShowPageControlWhenOnePage:(BOOL)showPageControlWhenOnePage {
    _hiddenPageControlWhenOnePage = showPageControlWhenOnePage;
    _pageControl.hidden = showPageControlWhenOnePage;
}

//设置当前页码
- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    _pageControl.currentPage = currentPage;
}

//检查当前界面是否可见
- (BOOL)checkVisible {
    UIView *superView = self.superview;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect windowFrame = window.frame;
    CGFloat startOrignY = 0;
    //if had status bar
    startOrignY += [UIApplication sharedApplication].statusBarFrame.size.height;
    //if had navigation bar
    startOrignY += 44;
    CGRect relativeRect = [superView convertRect:self.frame toView:window];
    return CGRectIntersectsRect(CGRectMake(windowFrame.origin.x, startOrignY, windowFrame.size.width, windowFrame.size.height), relativeRect) && CGSizeEqualToSize(relativeRect.size, self.originalFrame.size);
}

//自动翻页
- (void)autoPage {
    if (![self checkVisible]) {
        return;
    }
    CGSize scrollSize = _loopScrollView.frame.size;
    
    __weak BBGAdvView * weakSelf = self;
    
    [UIView animateWithDuration:0.25 animations:^{
        [_loopScrollView setContentOffset:CGPointMake(_loopScrollView.contentOffset.x + scrollSize.width, _loopScrollView.contentOffset.y)];
    } completion:^(BOOL finished) {
        [weakSelf updateAdvView];
        _scrollBegin = NO;
        _loopScrollView.scrollEnabled = YES;
    }];
    
    //[_loopScrollView setContentOffset:CGPointMake(_loopScrollView.contentOffset.x + scrollSize.width, _loopScrollView.contentOffset.y) animated:YES];
}

- (void)setEnableAutoPage:(BOOL)enableAutoPage {
    _enableAutoPage = enableAutoPage;
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
    if (_enableAutoPage) {
        if (_numberOfPages > 1) {
            self.timer = [BBGWeakTimer scheduledTimerWithTimeInterval:AUTOPAGETIME target:self selector:@selector(autoPage) userInfo:nil repeats:YES];
        }
    }
}

//初始化广告视图
- (void)initLoopScrollView {
    if (self.dataSource) {
        if ([self.dataSource respondsToSelector:@selector(numberOfPagesInAdvView:)]) {
            _numberOfPages = [self.dataSource numberOfPagesInAdvView:self];
        }else{
            @throw [NSException exceptionWithName:@"没有实现相应的DataSource方法" reason:@"没有实现方法:numberOfPagesInAdvView:" userInfo:nil];
        }
        if (_numberOfPages <= 0) {
            return;
        }
        [self createPageControl];
        [_loopScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _currentPage = 0;
        CGSize scrollSize = _loopScrollView.frame.size;
        if (_numberOfPages == 1) {
            _loopScrollView.contentSize = CGSizeMake(scrollSize.width, scrollSize.height);
            _loopScrollView.contentOffset = CGPointZero;
        }else{
            _loopScrollView.contentSize = CGSizeMake(scrollSize.width * (_numberOfPages + 2), scrollSize.height);
            _loopScrollView.contentOffset = CGPointMake(scrollSize.width, _loopScrollView.contentOffset.y);
        }
        //初始化
        self.currentView = [self.dataSource advView:self viewForAdvViewAtPage:0];
        CGRect cFrame = _currentView.frame;
        cFrame.origin = _loopScrollView.contentOffset;
        _currentView.frame = cFrame;
        [_loopScrollView addSubview:_currentView];
        if (_numberOfPages > 1) {
            self.preView = [self.dataSource advView:self viewForAdvViewAtPage:_numberOfPages - 1];
            CGRect pFrame = _preView.frame;
            pFrame.origin = CGPointMake(_loopScrollView.contentOffset.x - scrollSize.width, 0);
            _preView.frame = pFrame;
            [_loopScrollView addSubview:_preView];
            self.nextView = [self.dataSource advView:self viewForAdvViewAtPage:1];
            CGRect nFrame = _nextView.frame;
            nFrame.origin = CGPointMake(_loopScrollView.contentOffset.x + scrollSize.width, 0);
            _nextView.frame = nFrame;
            [_loopScrollView addSubview:_nextView];
        }
        self.enableAutoPage = YES;
    }
}

- (void)setDataSource:(id<BBGAdvViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self initLoopScrollView];
}

//重新加载数据
- (void)reloadData {
    _scrollBegin = NO;
    _beginPoint = CGPointZero;
    _loopScrollView.scrollEnabled = YES;
    [self initLoopScrollView];
}

//返回对应页的视图
- (UIView *)viewForPage:(NSInteger)page {
    if (page == _currentPage - 1) {
        return self.preView;
    }else if (page == _currentPage){
        return self.currentView;
    }else if (page == _currentPage + 1){
        return self.nextView;
    }else{
        return nil;
    }
}

//翻页
- (void)turnToPage:(NSInteger)page animated:(BOOL)animated {
    
}

- (void)endScroll {
    [self updateAdvView];
//    self.enableAutoPage = YES;
    self.scrollBegin = NO;
    self.loopScrollView.scrollEnabled = YES;
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!_scrollBegin) {
        _scrollBegin = YES;
        _beginPoint = scrollView.contentOffset;
    }
//    self.enableAutoPage = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(advViewWillBeginDragging:)]) {
        [self.delegate advViewWillBeginDragging:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollBegin && fabs(scrollView.contentOffset.x - _beginPoint.x) >= scrollView.frame.size.width) {
        scrollView.scrollEnabled = NO;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(advViewDidScroll:)]) {
        [self.delegate advViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self performSelector:@selector(endScroll) withObject:nil afterDelay:0.5];
    if (self.delegate && [self.delegate respondsToSelector:@selector(advViewDidEndDragging:willDecelerate:)]) {
        [self.delegate advViewDidEndDragging:self willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(advViewWillBeginDecelerating:)]) {
        [self.delegate advViewWillBeginDecelerating:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:NULL object:nil];
    [self updateAdvView];
//    self.enableAutoPage = YES;
    _scrollBegin = NO;
    scrollView.scrollEnabled = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(advViewDidEndDecelerating:)]) {
        [self.delegate advViewDidEndDecelerating:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateAdvView];
    _scrollBegin = NO;
    scrollView.scrollEnabled = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(advViewDidEndScrollingAnimation:)]) {
        [self.delegate advViewDidEndScrollingAnimation:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
