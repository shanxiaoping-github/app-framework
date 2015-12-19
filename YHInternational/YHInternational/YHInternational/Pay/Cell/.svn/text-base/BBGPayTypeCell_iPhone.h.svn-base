//
//  BBGPayTypeCell_iPhone.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBGPayTypeCellDelegate <NSObject>
- (void)payTypeDidChange:(BBGPayType *)payType;
@end
@interface BBGPayTypeCell_iPhone : UITableViewCell
@property (nonatomic,weak)id<BBGPayTypeCellDelegate> delegate;
-(void)updatePayTypeCellWithPayTypes:(NSMutableArray *)payTypes selectedPayType:(BBGPayType *)selectedPayType;
-(void)updateSubViewsFrameWithWidth:(CGFloat)width;
@end
