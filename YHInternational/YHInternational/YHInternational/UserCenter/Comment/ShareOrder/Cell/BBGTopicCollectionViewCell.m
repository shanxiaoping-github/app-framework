//
//  BBGTopicCollectionViewCell.m
//  YHInternational
//
//  Created by bbgds on 15/11/17.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGTopicCollectionViewCell.h"

@implementation BBGTopicCollectionViewCell

- (void)awakeFromNib
{
    _borderView.layer.borderColor = [[UIColor grayColor] CGColor];
    _borderView.layer.borderWidth = 1.0;
    _borderView.layer.cornerRadius = 5.0;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"BBGTopicCollectionViewCell" owner:self options:nil];
        
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

//选中状态
-(void)clickSelect
{
    _borderView.layer.borderColor = [UICOLOR_FONT_IMPORTANT_RED CGColor];
    _topic.textColor = UICOLOR_FONT_IMPORTANT_RED;
}

//取消状态
-(void)clickCancle
{
    _borderView.layer.borderColor = [RGB_CELL_GRAY CGColor];
    _topic.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT;
}

@end
