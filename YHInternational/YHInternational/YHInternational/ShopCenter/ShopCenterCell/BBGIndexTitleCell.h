//
//  BBGIndexTitleCell.h
//  YHInternational
//
//  Created by 黄 灿 on 15/7/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGIndexTitleCell : UITableViewCell
- (void)updateTitle:(NSString *)str;
- (void)dismissBottomLine;
- (void)showBottomLine;
/**
 *  section标题
 */
@property (nonatomic, strong) UILabel *title;

/**
 *  下面线
 */
@property (nonatomic, strong) UIView *linewView_1;
@end
