//
//  BBGSectionTableView.m
//  Components
//
//  Created by calvin on 14-5-28.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSectionTableView.h"

#import "BBGIntercepter.h"
@interface BBGSectionTableView ()

@property (nonatomic, strong) BBGIntercepter *datasourceIntercepter;
@property (nonatomic, strong) BBGIntercepter *delegateIntercepter;

@end

@implementation BBGSectionTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        _datasourceIntercepter = [[BBGIntercepter alloc] init];
        _delegateIntercepter = [[BBGIntercepter alloc] init];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        _datasourceIntercepter = [[BBGIntercepter alloc] init];
        _delegateIntercepter = [[BBGIntercepter alloc] init];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)dealloc {
    _datasourceIntercepter.middleMan = nil;
    _datasourceIntercepter.receiver = nil;
    _delegateIntercepter.middleMan = nil;
    _delegateIntercepter.receiver = nil;
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    _datasourceIntercepter.middleMan = self;
    _datasourceIntercepter.receiver = dataSource;
    super.dataSource = (id)_datasourceIntercepter;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    if (delegate) {
        _delegateIntercepter.middleMan = self;
        _delegateIntercepter.receiver = delegate;
        super.delegate = (id)_delegateIntercepter;
    }else{
        super.delegate = nil;
    }
}

- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    return [super headerViewForSection:section * 3 + 1];
}

- (UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    return [super footerViewForSection:section * 3 + 1];
}

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray *newIndexPaths = [NSMutableArray arrayWithCapacity:[indexPaths count]];
    for (NSIndexPath *indexPath in indexPaths) {
        [newIndexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section * 3 + 1]];
    }
    [super deleteRowsAtIndexPaths:newIndexPaths withRowAnimation:animation];
}

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray *newIndexPaths = [NSMutableArray arrayWithCapacity:[indexPaths count]];
    for (NSIndexPath *indexPath in indexPaths) {
        [newIndexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section * 3 + 1]];
    }
    [super insertRowsAtIndexPaths:newIndexPaths withRowAnimation:animation];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section % 3 == 0) {
        return 0;
    }else if (section % 3 == 1){
        section = (section - 1) / 3;
        return [_datasourceIntercepter.receiver tableView:tableView numberOfRowsInSection:section];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    section = (section - 1) / 3;
    return [_datasourceIntercepter.receiver tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_datasourceIntercepter.receiver respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return 3 * [_datasourceIntercepter.receiver numberOfSectionsInTableView:tableView];
    }else{
        return 3;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section % 3 == 0) {
        if ([_datasourceIntercepter.receiver respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
            section = section / 3;
            return [_datasourceIntercepter.receiver tableView:tableView titleForHeaderInSection:section];
        }
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section % 3 == 2) {
        if ([_datasourceIntercepter.receiver respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
            section = (section - 2) / 3;
            return [_datasourceIntercepter.receiver tableView:tableView titleForFooterInSection:section];
        }
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_datasourceIntercepter.receiver respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        section = (section - 1) / 3;
        return [_datasourceIntercepter.receiver tableView:tableView canEditRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_datasourceIntercepter.receiver respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        section = (section - 1) / 3;
        return [_datasourceIntercepter.receiver tableView:tableView canMoveRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
    return NO;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([_datasourceIntercepter.receiver respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [_datasourceIntercepter.receiver sectionIndexTitlesForTableView:tableView];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if ([_datasourceIntercepter.receiver respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [_datasourceIntercepter.receiver tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_datasourceIntercepter.receiver respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        section = (section - 1) / 3;
        [_datasourceIntercepter.receiver tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([_datasourceIntercepter.receiver respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        NSInteger sRow = sourceIndexPath.row;
        NSInteger sSection = sourceIndexPath.section;
        sSection = (sSection - 1) / 3;
        NSInteger dRow = destinationIndexPath.row;
        NSInteger dSection = destinationIndexPath.section;
        dSection = (dSection - 1) / 3;
        [_datasourceIntercepter.receiver tableView:tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:sRow inSection:sSection] toIndexPath:[NSIndexPath indexPathForRow:dRow inSection:dSection]];
    }
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        section = (section - 1) / 3;
        [_delegateIntercepter.receiver tableView:tableView willDisplayCell:cell forRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if (section % 3 == 0) {
        if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
            section = section / 3;
            [_delegateIntercepter.receiver tableView:tableView willDisplayHeaderView:view forSection:section];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if (section % 3 == 2) {
        if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
            section = (section - 2) / 3;
            [_delegateIntercepter.receiver tableView:tableView willDisplayFooterView:view forSection:section];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0) {
    if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        section = (section - 1) / 3;
        [_delegateIntercepter.receiver tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if (section % 3 == 0) {
        if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
            section = section / 3;
            [_delegateIntercepter.receiver tableView:tableView didEndDisplayingHeaderView:view forSection:section];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if (section % 3 == 2) {
        if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
            section = (section - 2) / 3;
            [_delegateIntercepter.receiver tableView:tableView didEndDisplayingFooterView:view forSection:section];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        section = (section - 1) / 3;
        return [_delegateIntercepter.receiver tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section % 3 == 0) {
        if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            section = section / 3;
            return [_delegateIntercepter.receiver tableView:tableView heightForHeaderInSection:section];
        }
    }
    return 1e-10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section % 3 == 2) {
        if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
            section = (section - 2) / 3;
            return [_delegateIntercepter.receiver tableView:tableView heightForFooterInSection:section];
        }
    }
    return 0;
}

/*
 - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0) {
 if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
 NSInteger row = indexPath.row;
 NSInteger section = indexPath.section;
 section = (section - 1) / 2;
 return [_delegateIntercepter.receiver tableView:tableView estimatedHeightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
 }
 return 44;
 }
 
 - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0) {
 if (section % 2 == 0) {
 if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
 section = section / 2;
 return [_delegateIntercepter.receiver tableView:tableView estimatedHeightForHeaderInSection:section];
 }
 }
 return 0;
 }
 
 - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0) {
 if (section % 2 == 0) {
 if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
 section = section / 2;
 return [_delegateIntercepter.receiver tableView:tableView estimatedHeightForFooterInSection:section];
 }
 }
 return 0;
 }
 */

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section % 3 == 0) {
        if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
            section = section / 3;
            return [_delegateIntercepter.receiver tableView:tableView viewForHeaderInSection:section];
        }
    }
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1e-10)];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section % 3 == 2) {
        if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
            section = (section - 2) / 3;
            return [_delegateIntercepter.receiver tableView:tableView viewForFooterInSection:section];
        }
    }
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1e-10)];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        section = (section - 1) / 3;
        [_delegateIntercepter.receiver tableView:tableView accessoryButtonTappedForRowWithIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
}

/*
 - (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
 - (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
 - (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
 
 // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
 - (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
 - (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        section = (section - 1) / 3;
        [_delegateIntercepter.receiver tableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
    if ([_delegateIntercepter.receiver respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        section = (section - 1) / 3;
        [_delegateIntercepter.receiver tableView:tableView didDeselectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
}

/*
 // Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
 - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
 - (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
 
 // Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
 - (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
 
 // The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
 - (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
 - (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;
 
 // Moving/reordering
 
 // Allows customization of the target row for a particular row as it is being moved/reordered
 - (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
 
 // Indentation
 
 - (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies
 
 // Copy/Paste.  All three methods must be implemented by the delegate.
 
 - (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
 - (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0);
 - (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0);
 */

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
