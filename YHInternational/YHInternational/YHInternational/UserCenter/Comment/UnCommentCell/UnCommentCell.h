//
//  UnCommentCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/4/28.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BBGUnCommentCellDelegate <NSObject>

- (void)didClickedShowGoodsBtn;

@end

@interface UnCommentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goCommentImageView;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UILabel *showUnCommentLabel;

@property (nonatomic,weak) id<BBGUnCommentCellDelegate> delegate;

@end
