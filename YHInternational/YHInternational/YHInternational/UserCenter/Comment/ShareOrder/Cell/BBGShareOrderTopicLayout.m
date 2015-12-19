//
//  BBGShareOrderTopicLayout.m
//  YHInternational
//
//  Created by bbgds on 15/11/16.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGShareOrderTopicLayout.h"

#define ITEM_HEIGHT 24

@implementation BBGShareOrderTopicLayout

-(void)prepareLayout
{
    [super prepareLayout];
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
}

-(CGSize)collectionViewContentSize
{
    return [self collectionView].frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.frame = CGRectMake(0,0,[self stringWidth:path] + 8,ITEM_HEIGHT);
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    //从第二个循环到最后一个
    for(int i = 1; i < self.cellCount; ++i)
    {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = 5;
        NSInteger maxlineSpacing = 5;
        //前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        CGRect frame = currentLayoutAttributes.frame;
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width)
        {
            frame.origin.x = origin + maximumSpacing;
            frame.origin.y = prevLayoutAttributes.frame.origin.y;
        }else
        {
            frame.origin.y = prevLayoutAttributes.frame.origin.y + ITEM_HEIGHT + maxlineSpacing;
        }
        currentLayoutAttributes.frame = frame;
//        _collectionOpenTopicHeight = frame.origin.y + frame.size.height;
    }
    return attributes;
}

-(CGFloat)stringWidth:(NSIndexPath *)path
{
    NSString *str = [_strArray objectAtIndex:path.row];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

@end
