//
//  BBGPayTypeButtonCVCell_iPhone.m
//  YHInternational
//
//  Created by bbgds on 15/10/8.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGPayTypeButtonCVCell_iPhone.h"

@implementation BBGPayTypeButtonCVCell_iPhone

- (void)awakeFromNib
{
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"BBGPayTypeButtonCVCell_iPhone" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

@end
