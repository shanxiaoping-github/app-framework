//
//  BBGPullTable.m
//  Components
//
//  Created by Damon on 15/4/29.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPullTable.h"
#import "BBGIntercepter.h"
#import "BlocksKit.h"
@interface BBGPullTable ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BBGIntercepter * delegateIntercepter;
@property (nonatomic, strong) BBGIntercepter * dataresouceIntercepter;
@property (nonatomic, assign) CGFloat selectedSectionHeaderHeight;
@property (nonatomic, assign) CGFloat selectedSectionFooterHeight;
@end

@implementation BBGPullTable

- (void)dealloc{
    
    self.dataresouceIntercepter = nil;
    self.delegateIntercepter = nil;
}

- (void)stopAnimationWithCompletion:(void (^)(void))actionHandler{
    if (self.pullToRefreshView.refreshState == RefreshStateFirst) {
        [self.pullToRefreshView stopAnimating:actionHandler];
    }
    if (self.pullToRefreshView.isAnimating) {
        [self.pullToRefreshView stopAnimating:actionHandler];
    }
    if (self.infiniteScrollingView.state == SVInfiniteScrollingStateLoading) {
        [self.infiniteScrollingView stopAnimating:actionHandler];

    }

}

- (void)stopAnimation{
    [self.pullToRefreshView stopAnimating];
    [self.infiniteScrollingView stopAnimating];
    
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource{
    
    if (dataSource) {
        if (!_dataresouceIntercepter) {
            _dataresouceIntercepter = [[BBGIntercepter alloc]init];
        }
        _dataresouceIntercepter.middleMan = self;
        _dataresouceIntercepter.receiver = dataSource;
    }
    self.pullDelegate = _dataresouceIntercepter.receiver;
    super.dataSource = self;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    if (delegate) {
        if (!_delegateIntercepter) {
            _delegateIntercepter = [[BBGIntercepter alloc]init];
        }
        _delegateIntercepter.middleMan = self;
        _delegateIntercepter.receiver = delegate;
    }
    super.delegate = self;
    
}

- (void)loadMore:(RefreshBlock)block{
    [self addInfiniteScrollingWithActionHandler:^{
        if (block) {
            block(nil);
        }
    }];
    
}

- (void)refreshData:(RefreshBlock)block{
    [self addPullToRefreshWithActionHandler:^{
        if (block) {
            block(nil);
        }
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pullToRefreshView.refreshView spinWithGesture:scrollView.contentOffset.y];
//    CGFloat sectionHeaderHeight = self.selectedSectionHeaderHeight;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0)
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, scrollView.contentInset.right);
//
//    }
//    else if (scrollView.contentOffset.y >= sectionHeaderHeight)
//    {
//        
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, scrollView.contentInset.right);
//
//    }
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegateIntercepter.receiver scrollViewDidScroll:self];
    }
}

#pragma mark UITableViewDataresouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataresouceIntercepter.receiver tableView:tableView numberOfRowsInSection:section] > 0) {
        [self bk_performBlock:^(id obj) {
            self.infiniteScrollingView.titlelabel.alpha = 1.0;
        } afterDelay:0.7];
    }
    if (!self.notOpenSticky) {
        return [self.dataresouceIntercepter.receiver tableView:tableView numberOfRowsInSection:section];
    }else{
        
        return ([self.dataresouceIntercepter.receiver tableView:tableView numberOfRowsInSection:section] + 2);
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    if (!self.notOpenSticky) {
        cell = [self.dataresouceIntercepter.receiver tableView:tableView cellForRowAtIndexPath:indexPath];
    }else{
        NSInteger indexLength = [self.dataresouceIntercepter.receiver tableView:tableView numberOfRowsInSection:indexPath.section] + 2;

        NSIndexPath * index;
        if (indexPath.row != 0) {
           index = [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:indexPath.section];
            
        }

        if (indexPath.row == 0) {
            if ([self.pullDelegate respondsToSelector:@selector(tableView:headerView:)]) {
                cell = [self.pullDelegate tableView:tableView headerView:indexPath.section];
            }
            if (cell == nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"headerView"];
            }
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerView"];
            }
            if (cell) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
        }else if(indexPath.row == indexLength - 1){
            if ([self.pullDelegate respondsToSelector:@selector(tableView:footerView:)]) {
                cell = [self.pullDelegate tableView:tableView footerView:indexPath.section];
            }
            if (cell == nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"footerView"];
            }
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"footerView"];
            }
            
            if (cell) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
        }else{
            cell = [self.dataresouceIntercepter.receiver tableView:tableView cellForRowAtIndexPath:index];
        }
        cell.autoresizesSubviews = YES;
        cell.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.dataresouceIntercepter.receiver respondsToSelector:@selector(numberOfSectionsInTableView:)] && self.dataresouceIntercepter.receiver) {
        return [self.dataresouceIntercepter.receiver numberOfSectionsInTableView:tableView];
    }
    return 1;
}// Default is 1 if not implemented

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.dataresouceIntercepter.receiver && [self.dataresouceIntercepter.receiver respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [self.dataresouceIntercepter.receiver tableView:tableView titleForHeaderInSection:section];
    }
    return @"";
}// fixed font style. use custom view (UILabel) if you want something different

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (self.dataresouceIntercepter.receiver && [self.dataresouceIntercepter.receiver respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [self.dataresouceIntercepter.receiver tableView:tableView titleForFooterInSection:section];
    }
    return @"";
}

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataresouceIntercepter.receiver && [self.dataresouceIntercepter.receiver respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.dataresouceIntercepter.receiver tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return YES;
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataresouceIntercepter.receiver && [self.dataresouceIntercepter.receiver respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [self.dataresouceIntercepter.receiver tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return YES;
}

// Index

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.dataresouceIntercepter.receiver && [self.dataresouceIntercepter.receiver respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.dataresouceIntercepter.receiver sectionIndexTitlesForTableView:tableView];
    }
    return [NSArray array];
    
}// return list of section titles to display in section index view (e.g. "ABCD...Z#")
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (self.dataresouceIntercepter.receiver && [self.dataresouceIntercepter.receiver respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.dataresouceIntercepter.receiver tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return 0;
}// tell table which section corresponds to section title/index (e.g. "B",1))

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataresouceIntercepter.receiver && [self.dataresouceIntercepter.receiver respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.dataresouceIntercepter.receiver tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if (self.dataresouceIntercepter.receiver && [self.dataresouceIntercepter.receiver respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        return [self.dataresouceIntercepter.receiver tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0.0;
    
    if ([self.delegateIntercepter.receiver respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        height = [self.delegateIntercepter.receiver tableView:tableView heightForHeaderInSection:section];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = self.style == UITableViewStylePlain? 0.0:0.01;
    
    if ([self.delegateIntercepter.receiver respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        height = [self.delegateIntercepter.receiver tableView:tableView heightForFooterInSection:section];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.0;
    if ([self.delegateIntercepter.receiver respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        if (!self.notOpenSticky) {
            height = [self.delegateIntercepter.receiver tableView:tableView heightForRowAtIndexPath:indexPath];
        }else{
            NSInteger indexLength = [self.dataresouceIntercepter.receiver tableView:tableView numberOfRowsInSection:indexPath.section] + 2;
            
            NSIndexPath * index;
            if (indexPath.row != 0) {
                index = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
            }
            if (indexPath.row == 0) {
                height = 0;
                if ([self.pullDelegate respondsToSelector:@selector(tableView:heightOfHeaderView:)]) {
                    height = [self.pullDelegate tableView:tableView heightOfHeaderView:indexPath];
                }
            }else if(indexPath.row == indexLength - 1){
                height = 0;
                if ([self.pullDelegate respondsToSelector:@selector(tableView:heightOfFooterView:)]) {
                    height = [self.pullDelegate tableView:tableView heightOfFooterView:indexPath];
                }
            }else{
                height = [self.delegateIntercepter.receiver tableView:tableView heightForRowAtIndexPath:index];
            }
        }
        
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.delegateIntercepter.receiver respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegateIntercepter.receiver tableView:tableView viewForHeaderInSection:section];
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10.0)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.delegateIntercepter.receiver respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.delegateIntercepter.receiver tableView:tableView viewForFooterInSection:section];
    }
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        if(!self.notOpenSticky){
            [self.delegateIntercepter.receiver tableView:self didSelectRowAtIndexPath:indexPath];
        }else{
            [self deselectRowAtIndexPath:indexPath animated:YES];
            NSInteger indexLength = [self.dataresouceIntercepter.receiver tableView:tableView numberOfRowsInSection:indexPath.section] + 2;
            
            if(indexPath.row == 0 || indexPath.row + 1 == indexLength){
                if ([self.pullDelegate respondsToSelector:@selector(didSelectedHeaderFooterView:)]) {
                    [self.pullDelegate didSelectedHeaderFooterView:indexPath];
                }
            }else{
                [self.delegateIntercepter.receiver tableView:self didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section]];
            }
            
        }
        
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.openDeleteCell)
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleNone;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegateIntercepter.receiver scrollViewWillBeginDragging:self];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegateIntercepter.receiver scrollViewDidEndDragging:self willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.delegateIntercepter.receiver scrollViewWillBeginDecelerating:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegateIntercepter.receiver scrollViewDidEndDecelerating:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.delegateIntercepter.receiver scrollViewDidEndScrollingAnimation:self];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.delegateIntercepter.receiver scrollViewShouldScrollToTop:self];
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.delegateIntercepter.receiver scrollViewDidScrollToTop:self];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegateIntercepter.receiver tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollRectToVisible:animated:)]) {
        [self.delegateIntercepter.receiver scrollRectToVisible:rect animated:animated];
    }
}

//- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
////    if (self.delegateIntercepter.receiver && [self.delegateIntercepter.receiver respondsToSelector:@selector(scrollToRowAtIndexPath:atScrollPosition:animated:)]) {
//        [self.dataresouceIntercepter.receiver scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
////    }
//    
//}



@end
