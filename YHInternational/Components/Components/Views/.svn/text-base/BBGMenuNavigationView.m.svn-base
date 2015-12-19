//
//  BBGMenuNavigationView.m
//  BBGMenuNavigationView
//
//  Created by 程伟 on 13-10-10.
//  Copyright (c) 2013年 程伟. All rights reserved.
//

#import "BBGMenuNavigationView.h"
#import "BBGMacro.h"
#define DEFAULTITEMSPACE 10

//顶部导航栏
@interface BBGMenuNavigationView ()

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView *centerImageView;
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UIImageView *rightImageView;
@property(nonatomic, strong) UIScrollView *navScrollView;
/**
 *  所有按钮
 */
@property(nonatomic, strong) NSArray *itemViews;
/**
 *  按钮间的间距
 */
@property(nonatomic, strong) NSDictionary *spaces;
/**
 *  总长度
 */
@property(nonatomic, assign) CGFloat totalWidth;
/**
 *  重新加载默认指向位置
 */
@property(nonatomic, assign) NSInteger reloadItemindex;

@property(nonatomic,strong) UIImageView *buttomLine;
@end

@implementation BBGMenuNavigationView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.autoresizingMask = UIViewAutoresizingNone;
        
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor clearColor];
        //center
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shopCenterNavFocus"]];
        _centerImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        _centerImageView.center = _bgView.center;
        [_bgView addSubview:_centerImageView];
        
        UIImage *image = [UIImage imageNamed:@"menuNavigation_side.png"];
        UIImage *newImage = [image stretchableImageWithLeftCapWidth:image.size.width / 3.0 topCapHeight:0];
        //left
        _leftImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _leftImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _leftImageView.image = newImage;
        [_bgView addSubview:_leftImageView];
        //right
        _rightImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _rightImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _rightImageView.image = newImage;
        [_bgView addSubview:_rightImageView];
        
        
        
        
        
        
        [self addSubview:_bgView];
        
        _navScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _navScrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _navScrollView.showsHorizontalScrollIndicator = NO;
        _navScrollView.showsVerticalScrollIndicator = NO;
        _navScrollView.delegate = self;
        _navScrollView.scrollsToTop = NO;
        [self addSubview:_navScrollView];
        
        _buttomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        _buttomLine.image = [UIImage imageNamed:@"深色line@2x-底部"];
        [self addSubview:_buttomLine];
        
        _currentSelectItemIndex = -1;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.autoresizingMask = UIViewAutoresizingNone;
        
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor clearColor];
        //center
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuNavigation_mid.png"]];
        _centerImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        _centerImageView.center = _bgView.center;
        [_bgView addSubview:_centerImageView];
        
        UIImage *image = [UIImage imageNamed:@"menuNavigation_side.png"];
        UIImage *newImage = [image stretchableImageWithLeftCapWidth:image.size.width / 3.0 topCapHeight:0];
        //left
        _leftImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _leftImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _leftImageView.image = newImage;
        [_bgView addSubview:_leftImageView];
        //right
        _rightImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _rightImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _rightImageView.image = newImage;
        [_bgView addSubview:_rightImageView];
        
        [self addSubview:_bgView];
        
        _navScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _navScrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _navScrollView.showsHorizontalScrollIndicator = NO;
        _navScrollView.showsVerticalScrollIndicator = NO;
        _navScrollView.delegate = self;
        [self addSubview:_navScrollView];
        _currentSelectItemIndex = -1;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    CGRect oldFrame = self.frame;
    [super setFrame:frame];
    if (oldFrame.size.width != frame.size.width) {
        //重新布局按钮
        [self setNeedsLayoutItems];
    }
}

- (IBAction)actionOfItemPressed:(id)sender {
    UIButton *button = (UIButton *) sender;
    [self selectItemAtIndex:button.tag animated:YES];
}

- (void)selectItemAtIndex:(NSInteger)index animated:(BOOL)animated {
    if (index < 0 || index >= _numberOfItems) {
        return;
    }
    if (_currentSelectItemIndex != index) {

        if (labs(_currentSelectItemIndex - index)>1 && isiPadClient) {
            animated = NO;
        }
        _currentSelectItemIndex = index;
        CGPoint arrowPoint = CGPointZero;
        for (int i = 0; i < [_itemViews count]; i++) {
            BBGMenuItemView *itemView = [_itemViews objectAtIndex:i];
            [itemView select:i == index Animated:animated];
            if (i == index) {
                arrowPoint = [self.navScrollView convertPoint:itemView.center toView:self];
                NSInteger nextIndex = (arrowPoint.x > self.center.x) ? index + 1 : index - 1;
                CGRect itemRect = [self.navScrollView convertRect:itemView.frame toView:self];
                CGPoint orignPoint = itemRect.origin;
                CGPoint endPoint = CGPointMake(itemRect.origin.x + itemRect.size.width, itemRect.origin.y);
                CGFloat scrollDistance = 0;
                if (orignPoint.x < 0) {
                    nextIndex = _currentSelectItemIndex - 1;
                    scrollDistance = - fabs(orignPoint.x);
                } else if (endPoint.x > self.frame.size.width) {
                    nextIndex = _currentSelectItemIndex + 1;
                    scrollDistance = fabs(endPoint.x - self.frame.size.width);
                }
                
                if (nextIndex >= 0 && nextIndex < _numberOfItems) {
                    BBGMenuItemView *nextItem = [_itemViews objectAtIndex:nextIndex];
                    CGRect nextItemRect = [self.navScrollView convertRect:nextItem.frame toView:self];
                    CGPoint nextOrignPoint = nextItemRect.origin;
                    CGPoint nextEndPoint = CGPointMake(nextOrignPoint.x + nextItemRect.size.width, nextOrignPoint.y);
                    if (nextOrignPoint.x < 0) {
                        scrollDistance = -fabs(nextOrignPoint.x);
                    }else if (nextEndPoint.x > self.frame.size.width){
                        scrollDistance = fabs(nextEndPoint.x - self.frame.size.width);
                    }
                }
                arrowPoint.x -= scrollDistance;
                [self.navScrollView setContentOffset:CGPointMake(self.navScrollView.contentOffset.x + scrollDistance, 0) animated:animated];
            }
        }
        
        if (animated) {
            [UIView animateWithDuration:0.2 animations:^{
                if (self.bgView.center.x > arrowPoint.x) {
                    self.bgView.center = CGPointMake(arrowPoint.x - 10, arrowPoint.y);
                } else {
                    self.bgView.center = CGPointMake(arrowPoint.x + 10, arrowPoint.y);
                }
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    self.bgView.center = arrowPoint;
                }];
            }];
        } else {
            self.bgView.center = arrowPoint;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(menuNavigationView:didSelectItemAtIndex:animated:)]) {
            [self.delegate menuNavigationView:self didSelectItemAtIndex:_currentSelectItemIndex animated:animated];
        }
    }
}

- (void)selectItemAtIndex:(NSInteger)index {
    if (index < 0 || index >= _numberOfItems) {
        return;
    }
    if (_currentSelectItemIndex != index) {
        
        _currentSelectItemIndex = index;
        CGPoint arrowPoint = CGPointZero;
        for (int i = 0; i < [_itemViews count]; i++) {
            BBGMenuItemView *itemView = [_itemViews objectAtIndex:i];
            [itemView select:i == index Animated:YES];
            if (i == index) {
                arrowPoint = [self.navScrollView convertPoint:itemView.center toView:self];
                NSInteger nextIndex = (arrowPoint.x > self.center.x) ? index + 1 : index - 1;
                CGRect itemRect = [self.navScrollView convertRect:itemView.frame toView:self];
                CGPoint orignPoint = itemRect.origin;
                CGPoint endPoint = CGPointMake(itemRect.origin.x + itemRect.size.width, itemRect.origin.y);
                CGFloat scrollDistance = 0;
                if (orignPoint.x < 0) {
                    nextIndex = _currentSelectItemIndex - 1;
                    scrollDistance = - fabs(orignPoint.x);
                } else if (endPoint.x > self.frame.size.width) {
                    nextIndex = _currentSelectItemIndex + 1;
                    scrollDistance = fabs(endPoint.x - self.frame.size.width);
                }
                
                if (nextIndex >= 0 && nextIndex < _numberOfItems) {
                    BBGMenuItemView *nextItem = [_itemViews objectAtIndex:nextIndex];
                    CGRect nextItemRect = [self.navScrollView convertRect:nextItem.frame toView:self];
                    CGPoint nextOrignPoint = nextItemRect.origin;
                    CGPoint nextEndPoint = CGPointMake(nextOrignPoint.x + nextItemRect.size.width, nextOrignPoint.y);
                    if (nextOrignPoint.x < 0) {
                        scrollDistance = -fabs(nextOrignPoint.x);
                    }else if (nextEndPoint.x > self.frame.size.width){
                        scrollDistance = fabs(nextEndPoint.x - self.frame.size.width);
                    }
                }
                arrowPoint.x -= scrollDistance;
                [self.navScrollView setContentOffset:CGPointMake(self.navScrollView.contentOffset.x + scrollDistance, 0) animated:YES];
            }
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            if (self.bgView.center.x > arrowPoint.x) {
                self.bgView.center = CGPointMake(arrowPoint.x - 10, arrowPoint.y);
            } else {
                self.bgView.center = CGPointMake(arrowPoint.x + 10, arrowPoint.y);
            }
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                self.bgView.center = arrowPoint;
            }];
        }];
    }
}

- (void)setDataSource:(id <BBGMenuNavigationViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self initMenuNavigationView];
}

- (void)initMenuNavigationView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInMenuNavigationView:)]) {
        _numberOfItems = [self.dataSource numberOfItemsInMenuNavigationView:self];
    } else {
        @throw [NSException exceptionWithName:@"必须实现dataSource方法" reason:@"没有实现方法:numberOfItemsInMenuNavigationView:" userInfo:nil];
    }
    NSMutableArray *allItems = [NSMutableArray arrayWithCapacity:_numberOfItems];
    NSMutableDictionary *allSpaces = [NSMutableDictionary dictionary];
    CGFloat space = 0;
    CGFloat position = _itemBeginSpace;
    for (int i = 0; i < _numberOfItems; i++) {
        if (i > 0) {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(menuNavigationView:spaceForItemAtIndex:)]) {
                space = [self.dataSource menuNavigationView:self spaceForItemAtIndex:i - 1];
            } else {
                space = DEFAULTITEMSPACE;
            }
            [allSpaces setObject:[NSNumber numberWithFloat:space] forKey:[NSString stringWithFormat:@"%d",i]];
        }
        position += space;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(menuNavigationView:itemForMenuNavigationViewAtIndex:)]) {
            BBGMenuItemView *itemView = [self.dataSource menuNavigationView:self itemForMenuNavigationViewAtIndex:i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = itemView.bounds;
            [button addTarget:self action:@selector(actionOfItemPressed:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [itemView addSubview:button];
            [allItems addObject:itemView];
            CGRect itemFrame = itemView.frame;
            itemFrame.origin.x = position;
            itemFrame.origin.y = (self.frame.size.height - itemFrame.size.height) / 2.0;
            itemView.frame = itemFrame;
            [self.navScrollView addSubview:itemView];
            position += itemView.frame.size.width;
        } else {
            @throw [NSException exceptionWithName:@"必须实现dataSource方法" reason:@"没有实现方法:menuNavigationView:itemForMenuNavigationViewAtIndex:" userInfo:nil];
        }
    }
    position += _itemBeginSpace;
    self.totalWidth = position;
    self.itemViews = allItems;
    self.spaces = allSpaces;
    //计算所有按钮全加上去后的总宽度,当总宽度<导航控件宽度时将所有按钮居中显示
    if (position < self.frame.size.width) {
        [self.navScrollView setContentSize:CGSizeMake(self.frame.size.width, self.navScrollView.frame.size.height)];
        CGFloat space = 0;
        position = (self.frame.size.width - position) / 2.0;
        for (int i = 0; i < _numberOfItems; i ++) {
            if (i > 0) {
                space = [[self.spaces objectForKey:[NSString stringWithFormat:@"%d",i]] floatValue];
            }
            position += space;
            BBGMenuItemView *itemView = [self.itemViews objectAtIndex:i];
            CGRect itemFrame = itemView.frame;
            itemFrame.origin.x = position;
            itemFrame.origin.y = (self.frame.size.height - itemFrame.size.height) / 2.0;
            itemView.frame = itemFrame;
            position += itemView.frame.size.width;
        }
        
    }else{
        [self.navScrollView setContentSize:CGSizeMake(position, self.navScrollView.frame.size.height)];
    }
    CGRect bgFrame = _bgView.frame;
    bgFrame.size.width = 4 * position + _centerImageView.frame.size.width;
    _bgView.frame = bgFrame;
    _leftImageView.frame = CGRectMake(0, 0, 2 * position, _bgView.frame.size.height);
    _centerImageView.frame = CGRectMake(_leftImageView.frame.origin.x + _leftImageView.frame.size.width, _leftImageView.frame.origin.y, _centerImageView.frame.size.width, _bgView.frame.size.height);
    _rightImageView.frame = CGRectMake(_centerImageView.frame.origin.x + _centerImageView.frame.size.width, 0, 2 * position, _bgView.frame.size.height);
    if (_numberOfItems > _reloadItemindex) {
        [self selectItemAtIndex:_reloadItemindex animated:NO];
    }
}

- (void)setNeedsLayoutItems {
    if (_totalWidth < self.frame.size.width) {
        CGFloat space = 0;
        CGFloat position = (self.frame.size.width - _totalWidth) / 2.0 + _itemBeginSpace;
        for (int i = 0; i < _numberOfItems; i ++) {
            if (i > 0) {
                space = [[self.spaces objectForKey:[NSString stringWithFormat:@"%d",i]] floatValue];
            }
            position += space;
            BBGMenuItemView *itemView = [self.itemViews objectAtIndex:i];
            CGRect itemFrame = itemView.frame;
            itemFrame.origin.x = position;
            itemFrame.origin.y = (self.frame.size.height - itemFrame.size.height) / 2.0;
            itemView.frame = itemFrame;
            position += itemView.frame.size.width;
        }
        NSInteger selectIndex = _currentSelectItemIndex;
        _currentSelectItemIndex = -1;
        [self selectItemAtIndex:selectIndex animated:NO];
    }
}

- (void)reloadData {
    [self.navScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _totalWidth = 0.0;
    _reloadItemindex = 0;
    _currentSelectItemIndex = -1;
    [self initMenuNavigationView];
}

- (void)reloadDataWithItemIndex:(NSInteger)itemIndex {
    [self.navScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _reloadItemindex = itemIndex;
    _totalWidth = 0.0;
    _currentSelectItemIndex = -1;
    [self initMenuNavigationView];
}


- (BBGMenuItemView *)menuItemViewOfMenuNavigationViewAtIndex:(NSInteger)index {
    if (index < 0 || index >= [_itemViews count]) {
        return nil;
    }
    return [_itemViews objectAtIndex:index];
}

- (void)setBackgroundImageView:(UIImageView *)backgroundImageView {
    [_backgroundImageView removeFromSuperview];
    _backgroundImageView = backgroundImageView;
    _backgroundImageView.frame = self.bounds;
    [self insertSubview:_backgroundImageView belowSubview:_navScrollView];
}

#pragma mark - UIScrollViewDelegate Method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BBGMenuItemView *itemView = [_itemViews objectAtIndex:_currentSelectItemIndex];
    _bgView.center = [self.navScrollView convertPoint:itemView.center toView:self];
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
