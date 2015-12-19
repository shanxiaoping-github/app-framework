//
//  DetailTextCell.h
//  BubuGao
//
//  Created by Damon on 14-8-7.
//  Copyright (c) 2014年 bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBGCommentDetailTextCellDelegate <NSObject>

- (void)changeTable:(NSInteger)type str:(NSString *)str isAnonymous:(BOOL)isAnonymous;

@end

@interface BBGCommentDetailTextCell_iPhone : UITableViewCell
- (void)displayTextContent:(NSString *)text isAnonymous:(BOOL)isAnonymous;
@property (weak, nonatomic) id<BBGCommentDetailTextCellDelegate> delegate;
@end
