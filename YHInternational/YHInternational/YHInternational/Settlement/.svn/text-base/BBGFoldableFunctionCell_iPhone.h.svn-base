//
//  BBGFoldableFunctionCell_iPhone.h
//  YHInternational
//
//  Created by OuyangTimmy on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettlementFoldableCellDelegate;

@interface BBGFoldableFunctionCell_iPhone : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (assign, nonatomic) id <SettlementFoldableCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;

+ (float)cellHeight;

@end

@protocol SettlementFoldableCellDelegate <NSObject>

- (void)foldableCell:(BBGFoldableFunctionCell_iPhone *)foldableCell didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end