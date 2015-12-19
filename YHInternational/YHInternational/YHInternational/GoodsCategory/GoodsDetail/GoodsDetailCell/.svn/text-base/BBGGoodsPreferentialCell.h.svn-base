//
//  BBGGoodsPreferentialCell.h
//  YHInternational
//
//  Created by 彭腾 on 15-5-6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^goGiftBlock)(NSInteger num);

@interface BBGGoodsPreferentialCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *dataArr ;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (nonatomic, copy) goGiftBlock button;
- (void)goGiftButtonAction:(goGiftBlock)block;
+ (CGFloat)cellHeignt:(NSMutableArray *)array ;

@end
