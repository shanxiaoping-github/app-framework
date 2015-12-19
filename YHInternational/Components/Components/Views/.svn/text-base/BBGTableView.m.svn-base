//
//  BBGTableView.m
//  BBGCustomTableView
//
//  Created by 程伟 on 13-10-16.
//  Copyright (c) 2013年 程伟. All rights reserved.
//

#import "BBGTableView.h"

#define LINESPACE 4.0
#define HEIGHTGHREHOLD (self.myTableView.style == UITableViewStylePlain) ? 0.0 : 10.0
#define DEFAULTFOOTERHEIGHT (self.myTableView.style == UITableViewStylePlain) ? 0.0 : 0.01
#define IOS7 ([[UIDevice currentDevice].systemVersion compare:@"7.0"] != NSOrderedAscending)

typedef enum {
    BBGTableViewCellPositionTop = 1,    //该行位于分组最顶位置
    BBGTableViewCellPositionMiddle = 2, //该行位于分组中间位置
    BBGTableViewCellPositionBottom = 3, //该行位于分组底部位置
    BBGTableViewCellPositionNone = 4,   //整个section只有该行
} BBGTableViewCellPosition;

//TableSeparateLine
@interface TableSeparateLine : UIView

@property(nonatomic, assign) BBGTableViewCellSeparatorStyle separatorStyle;
@property(nonatomic, strong) UIColor *separatorColor;

@end

@implementation TableSeparateLine

- (id)initWithFrame:(CGRect)frame separatorStyle:(BBGTableViewCellSeparatorStyle)style color:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        //Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _separatorStyle = style;
        _separatorColor = color;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, _separatorColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    switch (_separatorStyle) {
        case BBGTableViewCellSeparatorStyleSolid: {
            CGContextMoveToPoint(context, 0, rect.size.height);
            CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        }
            break;
        case BBGTableViewCellSeparatorStyleDashed: {
            CGFloat length[] = {2, 2};
            CGContextMoveToPoint(context, LINESPACE * 2, rect.size.height);
            CGContextSetLineDash(context, 0.0, length, 2);
            CGContextAddLineToPoint(context, rect.size.width - 2 * LINESPACE, rect.size.height);
        }
            break;
        default:
            break;
    }
    CGContextStrokePath(context);
}


@end

//BBGTableViewCell
@interface BBGTableViewCell ()

@property(nonatomic, strong) TableSeparateLine *line;
@property(nonatomic, assign) BBGTableViewStyle style;

@end

@implementation BBGTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Initialized code
        self.needBackground = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect accessoryViewFrame = self.accessoryView.frame;
    accessoryViewFrame.origin.x = CGRectGetWidth(self.bounds) - CGRectGetWidth(accessoryViewFrame) - 10.0;
    self.accessoryView.frame = accessoryViewFrame;
}

- (void)setFrame:(CGRect)frame {
    [_line setNeedsDisplay];
    [super setFrame:frame];
}

- (void)setLine:(TableSeparateLine *)line {
    [_line removeFromSuperview];
    _line = line;
    if (_line) {
        [self.backgroundView addSubview:_line];
    }
}


@end

@interface BackgroundView : UIImageView

@end

@implementation BackgroundView

- (void)setFrame:(CGRect)frame {
//    UITableView *tableView = (UITableView *)(IOS7 ? self.superview.superview.superview.superview : self.superview.superview);
//    if ([tableView isKindOfClass:[UITableView class]]) {
//        
//        if (tableView.style == UITableViewStyleGrouped && !IOS7) {
//            frame.origin.x = 10.0;
//        }
//         
//        frame.size.width = tableView.frame.size.width - 20.0;
//    }
    [super setFrame:frame];
}

@end

@interface BBGTableView ()

@property(nonatomic, strong) UIImage *topCellImage;
@property(nonatomic, strong) UIImage *midCellImage;
@property(nonatomic, strong) UIImage *bottomCellImage;
@property(nonatomic, strong) UITableView *myTableView;
@property(nonatomic, strong) NSMutableDictionary *rowHeightDic;
//设置是否自动适应屏幕大小 yes 不自动 no 自动
@property(nonatomic, assign) BOOL notAutoSizeMask;
@end

@implementation BBGTableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(BBGTableViewStyle)style backgoundImage:(UIImage *)image notAutoSizeMask:(BOOL)notAuto{
    self.notAutoSizeMask = notAuto;
    self = [self initWithFrame:frame style:style backgoundImage:image];
    return self;
}


- (id)initWithFrame:(CGRect)frame style:(BBGTableViewStyle)style backgoundImage:(UIImage *)image {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (!self.notAutoSizeMask) {
            self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        }
        self.rowHeightDic = [NSMutableDictionary dictionary];
        _separatorStyle = BBGTableViewCellSeparatorStyleSolid;
        _separatorColor = [UIColor colorWithRed:224.0 / 255.0 green:224.0 / 255.0 blue:224.0 / 255.0 alpha:1.0];
        self.myTableView = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStyle)style];
        self.myTableView.backgroundColor = [UIColor clearColor];
        self.myTableView.backgroundView = nil;
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.myTableView.dataSource = (id <UITableViewDataSource>) self;
        self.myTableView.delegate = (id <UITableViewDelegate>) self;
       
        self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        
        [self addSubview:self.myTableView];
        self.backgoundImage = image;
        self.topCellImage = [self clipImage:image inRect:CGRectMake(0, 0, image.size.width, image.size.height / 3.0)];
        self.midCellImage = [self clipImage:image inRect:CGRectMake(0, image.size.height / 3.0, image.size.width, image.size.height / 3.0)];
        self.bottomCellImage = [self clipImage:image inRect:CGRectMake(0, image.size.height * 2 / 3.0, image.size.width, image.size.height / 3.0)];
    }
    return self;
}

- (UIImage *)clipImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:image.imageOrientation].CGImage, CGRectMake(rect.origin.x * image.scale, rect.origin.y * image.scale, rect.size.width * image.scale, rect.size.height * image.scale));
    UIImage *cropImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    return cropImage;
}

- (void)setTableHeaderView:(UIView *)tableHeaderView {
    _tableHeaderView = tableHeaderView;
    self.myTableView.tableHeaderView = _tableHeaderView;
}

- (void)setTableFooterView:(UIView *)tableFooterView {
    _tableFooterView = tableFooterView;
    self.myTableView.tableFooterView = _tableFooterView;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    [self.myTableView reloadData];
}

- (void)setSeparatorStyle:(BBGTableViewCellSeparatorStyle)separatorStyle {
    _separatorStyle = separatorStyle;
    //[self.myTableView reloadData];
}
- (void)setScrollEnabled:(BOOL)scrollEnabled {
    self.myTableView.scrollEnabled = scrollEnabled;
}

- (void)setBounces:(BOOL)bounces {
    self.myTableView.bounces = bounces;
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset{
    self.myTableView.scrollIndicatorInsets = edgeInset;
}

-(void)setContentOffSet:(CGPoint)contentOffSet {
    self.myTableView.contentOffset = contentOffSet;
}

- (CGPoint)contentOffSet {
    return self.myTableView.contentOffset;
}

- (CGSize)contentSize {
    return self.myTableView.contentSize;
}

- (CGFloat)rowHeight {
    return self.myTableView.rowHeight;
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    return [self.myTableView dequeueReusableCellWithIdentifier:identifier];
}

- (void)reloadData {
    [self.myTableView reloadData];
}

- (NSInteger)numberOfSections {
    return [self.myTableView numberOfSections];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self.myTableView numberOfRowsInSection:section];
}

- (CGRect)rectForSection:(NSInteger)section {
    return [self.myTableView rectForSection:section];
}

- (CGRect)rectForHeaderInSection:(NSInteger)section {
    return [self.myTableView rectForHeaderInSection:section];
}

- (CGRect)rectForFooterInSection:(NSInteger)section {
    return [self.myTableView rectForFooterInSection:section];
}

- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.myTableView rectForRowAtIndexPath:indexPath];
}

- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point {
    return [self.myTableView indexPathForRowAtPoint:point];
}

- (NSIndexPath *)indexPathForCell:(BBGTableViewCell *)cell {
    return [self.myTableView indexPathForCell:cell];
}

- (NSArray *)indexPathsForRowsInRect:(CGRect)rect {
    return [self.myTableView indexPathsForRowsInRect:rect];
}

- (BBGTableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (BBGTableViewCell *) [self.myTableView cellForRowAtIndexPath:indexPath];
}

- (NSArray *)visibleCells {
    return [self.myTableView visibleCells];
}

- (NSArray *)indexPathsForVisibleRows {
    return [self.myTableView indexPathsForVisibleRows];
}

- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(BBGTableViewRowAnimation)animation {
    [self.myTableView insertSections:sections withRowAnimation:(UITableViewRowAnimation) animation];
}

- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(BBGTableViewRowAnimation)animation {
    [self.myTableView deleteSections:sections withRowAnimation:(UITableViewRowAnimation) animation];
    
}

- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
    [self.myTableView deselectRowAtIndexPath:indexPath animated:animated];
}

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(BBGTableViewRowAnimation)animation {
    [self.myTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimation) animation];
    for (NSIndexPath *indexPath in indexPaths) {
        if (indexPath.row - 1 >= 0) {
            NSIndexPath *beforeIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
            BBGTableViewCell *cell = (BBGTableViewCell *)[self.myTableView cellForRowAtIndexPath:beforeIndexPath];
            [self createCellBackroundViewForCell:cell atIndexPath:beforeIndexPath];
        }
    }
}

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(BBGTableViewRowAnimation)animation {
    [self.myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimation) animation];
    [self performSelector:@selector(updateDeleteCellAtIndexPaths:) withObject:indexPaths afterDelay:0.2];
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(BBGTableViewRowAnimation)animation {
    [self.myTableView reloadSections:sections withRowAnimation:(UITableViewRowAnimation) animation];
}

- (void)updateDeleteCellAtIndexPaths:(NSArray *)indexPaths {
    for (NSIndexPath *indexPath in indexPaths) {
        if (indexPath.row - 1 >= 0) {
            NSIndexPath *beforeIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
            BBGTableViewCell *cell = (BBGTableViewCell *)[self.myTableView cellForRowAtIndexPath:beforeIndexPath];
            [self createCellBackroundViewForCell:cell atIndexPath:beforeIndexPath];
        }
    }
}

- (void)createCellBackroundViewForCell:(BBGTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (!cell.needBackground) {
        UIView *bgView = [[UIView alloc] initWithFrame:cell.bounds];
        bgView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = bgView;
        return;
    }
    CGRect bgFrame = CGRectMake(IOS7 ? 0 : 10, 0, cell.frame.size.width - 20, cell.frame.size.height);
    NSInteger rows = [self.myTableView numberOfRowsInSection:indexPath.section];
    CGRect headerRect = [self.myTableView rectForHeaderInSection:indexPath.section];
    CGRect footerRect = [self.myTableView rectForFooterInSection:indexPath.section];
    BBGTableViewCellPosition cellPosition = BBGTableViewCellPositionNone;
    if (headerRect.size.height <= 10.0) {
        //没有header
        if (rows > 1) {
            if (indexPath.row == 0) {
                cellPosition = BBGTableViewCellPositionTop;
            } else if (indexPath.row == rows - 1) {
                if (footerRect.size.height <= 10.0) {
                    //没有footer
                    cellPosition = BBGTableViewCellPositionBottom;
                } else {
                    cellPosition = BBGTableViewCellPositionMiddle;
                }
            } else {
                cellPosition = BBGTableViewCellPositionMiddle;
            }
        } else {
            cellPosition = BBGTableViewCellPositionNone;
        }
    } else {
        //有header
        if (rows > 1) {
            if (indexPath.row == rows - 1) {
                if (footerRect.size.height <= 10.0) {
                    //没有footer
                    cellPosition = BBGTableViewCellPositionBottom;
                } else {
                    cellPosition = BBGTableViewCellPositionMiddle;
                }
            } else {
                cellPosition = BBGTableViewCellPositionMiddle;
            }
        } else {
            if (footerRect.size.height <= 10.0) {
                //没有footer
                cellPosition = BBGTableViewCellPositionBottom;
            } else {
                cellPosition = BBGTableViewCellPositionMiddle;
            }
        }
    }
    BackgroundView *bgView = (BackgroundView *) cell.backgroundView;
    switch (cellPosition) {
        case BBGTableViewCellPositionTop: {
            //顶部
            if (bgView && [bgView respondsToSelector:@selector(setImage:)]) {
                bgView.image = [self.topCellImage stretchableImageWithLeftCapWidth:self.topCellImage.size.width / 3.0 topCapHeight:self.topCellImage.size.height / 3];
            } else {
                bgView = [[BackgroundView alloc] initWithFrame:bgFrame];
                bgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                bgView.image = [self.topCellImage stretchableImageWithLeftCapWidth:self.topCellImage.size.width / 3.0 topCapHeight:self.topCellImage.size.height / 3];
                cell.backgroundView = bgView;
            }
        }
            break;
        case BBGTableViewCellPositionMiddle: {
            //中间
            if (bgView && [bgView respondsToSelector:@selector(setImage:)]) {
                bgView.image = [self.midCellImage stretchableImageWithLeftCapWidth:self.midCellImage.size.width / 3.0 topCapHeight:self.midCellImage.size.height / 3];
            } else {
                bgView = [[BackgroundView alloc] initWithFrame:bgFrame];
                bgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                bgView.image = [self.midCellImage stretchableImageWithLeftCapWidth:self.midCellImage.size.width / 3.0 topCapHeight:self.midCellImage.size.height / 3];
                cell.backgroundView = bgView;
            }
        }
            break;
        case BBGTableViewCellPositionBottom: {
            //底部
            if (bgView && [bgView respondsToSelector:@selector(setImage:)]) {
                bgView.image = [self.bottomCellImage stretchableImageWithLeftCapWidth:self.bottomCellImage.size.width / 3.0 topCapHeight:self.bottomCellImage.size.height / 3];
            } else {
                bgView = [[BackgroundView alloc] initWithFrame:bgFrame];
                bgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                bgView.image = [self.bottomCellImage stretchableImageWithLeftCapWidth:self.bottomCellImage.size.width / 3.0 topCapHeight:self.bottomCellImage.size.height / 3];
                cell.backgroundView = bgView;
            }
        }
            break;
        default: {
            //整个section只有一行
            if (bgView && [bgView respondsToSelector:@selector(setImage:)]) {
                bgView.image = [self.backgoundImage stretchableImageWithLeftCapWidth:self.backgoundImage.size.width / 3.0 topCapHeight:self.backgoundImage.size.height / 3];
            } else {
                bgView = [[BackgroundView alloc] initWithFrame:bgFrame];
                bgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                bgView.image = [self.backgoundImage stretchableImageWithLeftCapWidth:self.backgoundImage.size.width / 3.0 topCapHeight:self.backgoundImage.size.height / 3];
                cell.backgroundView = bgView;
            }
        }
            break;
    }
    
    if (cellPosition != BBGTableViewCellPositionBottom && cellPosition != BBGTableViewCellPositionNone && self.separatorStyle != BBGTableViewCellSeparatorStyleNone) {
        bgFrame = cell.backgroundView ? cell.backgroundView.frame : bgFrame;
        TableSeparateLine *line = [[TableSeparateLine alloc] initWithFrame:CGRectMake(2 + _separatorInset.left + _separatorInset.right, _separatorInset.top + _separatorInset.bottom, bgFrame.size.width - 3 - (_separatorInset.left + _separatorInset.right), bgFrame.size.height - (_separatorInset.top + _separatorInset.bottom)) separatorStyle:_separatorStyle color:_separatorColor];
        cell.line = line;
    } else {
        cell.line = nil;
    }
}

#pragma mark - UITableViewDataSource And UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.dataSource numberOfSectionsInTableView:self];
    }
    return 1;
}

- (NSString *)tableView:(BBGTableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [self.dataSource tableView:self titleForHeaderInSection:section];
    }
    return nil;
}

- (NSString *)tableView:(BBGTableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [self.dataSource tableView:self titleForFooterInSection:section];
    }
    return nil;
}

- (CGFloat)tableView:(BBGTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        height = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
    }
    [_rowHeightDic setObject:[NSNumber numberWithFloat:height] forKey:[NSString stringWithFormat:@"%ld+%ld", (long)indexPath.section, (long)indexPath.row]];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.delegate tableView:self heightForHeaderInSection:section];
    }
    return 10.0;
}

- (CGFloat)tableView:(BBGTableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.delegate tableView:self heightForFooterInSection:section];
    }
    return DEFAULTFOOTERHEIGHT;
}

- (UIView *)tableView:(BBGTableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:self viewForHeaderInSection:section];
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10.0)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UIView *)tableView:(BBGTableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.delegate tableView:self viewForFooterInSection:section];
    }
    return nil;
}

- (void)tableView:(BBGTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        [self.delegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.dataSource tableView:self numberOfRowsInSection:section];
    } else {
        if (self.dataSource) {
            @throw [NSException exceptionWithName:@"未实现必要的DataSource方法" reason:@"未实现DataSource方法:tableView:numberOfRowsInSection:" userInfo:nil];
        } else {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        BBGTableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
        if (![cell isKindOfClass:[BBGTableViewCell class]]) {
            @throw [NSException exceptionWithName:@"初始化cell错误" reason:@"没有使用BBGTableViewCell创建cell" userInfo:nil];
        }
        cell.style = (BBGTableViewStyle)tableView.style;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        [self createCellBackroundViewForCell:cell atIndexPath:indexPath];
        return cell;
    } else {
        @throw [NSException exceptionWithName:@"未实现必要的DataSource方法" reason:@"未实现DataSource方法:tableView:cellForRowAtIndexPath:" userInfo:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:self];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegate scrollViewWillBeginDragging:self];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollViewDidEndDragging:self willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.delegate scrollViewWillBeginDecelerating:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDecelerating:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.delegate scrollViewDidEndScrollingAnimation:self];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.delegate scrollViewShouldScrollToTop:self];
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.delegate scrollViewDidScrollToTop:self];
    }
}

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
    [self.myTableView scrollRectToVisible:rect animated:animated];
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{

    [self.myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];

}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc {
    _delegate = nil;
    _dataSource = nil;
}

@end
