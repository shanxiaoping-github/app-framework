//
//  BBGShareOrder.m
//  Common
//
//  Created by bbgds on 15/10/27.
//  Copyright © 2015年 Bubugao. All rights reserved.
//  晒单对象

#import "BBGShareOrder.h"

@implementation BBGShareOrder

-(id)init
{
    self = [super init];
    if(self)
    {
        _picDataArray = [[NSMutableArray alloc] init];
        _comment = @"";
        _topicArray = [[NSMutableArray alloc] init];
        _topicIsSelectArray = [[NSMutableArray alloc] init];
        
        _defaultTopicHeight = 24;
    }
    return self;
}

-(void)mathOpenTopicHeight:(CGFloat)iphoneWidth
{
    //前一个cell的最右边
    CGFloat origin = 0;
    //我们想设置的最大间距，可根据需要改
    CGFloat maximumSpacing = 5;
    CGFloat maxlineSpacing = 5;
    
    CGFloat height = 0;
    
    //从第二个循环到最后一个
    for(int i = 0; i < _topicArray.count; ++i)
    {
        CGFloat strWidth = [self stringWidth:[_topicIsSelectArray objectAtIndex:i]] + 8;
        CGFloat width = origin + maximumSpacing + strWidth;
        
        if(width < (iphoneWidth - 44))
        {
            origin = origin + width;
        }else
        {
            height = height + 24 + maxlineSpacing;
        }
    }
    _openTopicHeight = height - maxlineSpacing;
//    return height;
}

-(CGFloat)stringWidth:(NSString *)str
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

@end
