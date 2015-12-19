//
//  BBGBrandCell.h
//  YHInternational
//
//  Created by 黄 灿 on 15/7/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LJC.h"

@protocol BrandCellDelegate <NSObject>

- (void)WhichPartSelect:(int)index;

@end
@interface BBGBrandCell : UITableViewCell
{
    UIImageView *imageview1,*imageview2,*imageview3,*imageview4;
    UILabel *label1,*label2,*label3,*label4;
}
@property (nonatomic,weak) id<BrandCellDelegate> delegate;
- (void)updateCell:(id)response isUp:(BOOL)isUp;
@end
