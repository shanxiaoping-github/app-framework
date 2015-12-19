//
//  PTLabel.m
//  PTDemo
//
//  Created by 彭腾 on 15/6/1.
//  Copyright (c) 2015年 彭腾. All rights reserved.
//

#import "PTLabel.h"

@implementation PTLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self initObject];
    
    return self;
}

- (void)initObject {
    self.content = [UILabel new];
    self.prefixImage = [UIImageView new];
    
    [self addSubview:self.content];
    [self addSubview:self.prefixImage];
}

- (void)layoutSubviews {
    CGFloat imageWidth = 16;
    CGFloat imageHeight = 16;
    CGFloat imageY = (CGRectGetHeight(self.frame) - imageHeight) / 2.0;
    
    CGFloat labelMaxWidth = CGRectGetWidth(self.frame) - imageWidth;
    CGFloat labelMaxHeight = CGRectGetHeight(self.frame);
    
    labelMaxWidth -= 10.0;
    
    CGSize size = [self.content sizeThatFits:CGSizeMake(labelMaxWidth, labelMaxHeight)];
    CGFloat labelWidth = size.width;
    if(self.content.textAlignment == NSTextAlignmentLeft){
        self.prefixImage.frame = CGRectMake(0, imageY, imageWidth, imageHeight);
        self.content.frame = CGRectMake(CGRectGetMaxX(self.prefixImage.frame) + 10.0f, 0, labelMaxWidth, labelMaxHeight);
    }
    if (self.content.textAlignment == NSTextAlignmentCenter) {
        if(labelWidth > labelMaxWidth){
            self.prefixImage.frame = CGRectMake(0, imageY, 16, 16);
            self.content.frame = CGRectMake(CGRectGetMaxX(self.prefixImage.frame) + 10.0f, 0, labelMaxWidth, labelMaxHeight);
        }
        else{
            CGFloat imageX = (CGRectGetWidth(self.frame) - labelWidth - imageWidth) / 2.0;
            self.prefixImage.frame = CGRectMake(imageX, imageY, 16, 16);
            self.content.frame = CGRectMake(CGRectGetMaxX(self.prefixImage.frame) + 10.0f, 0, labelWidth, labelMaxHeight);
        }
    }

}

@end
