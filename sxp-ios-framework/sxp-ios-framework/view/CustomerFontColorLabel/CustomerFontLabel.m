//
//  CustomerFontLabel.m
//  TestCustomerLabel
//
//  Created by 单小萍 on 15/12/3.
//  Copyright © 2015年 单小萍. All rights reserved.
//

#import "CustomerFontLabel.h"
@interface CustomerFontLabel(){
    CGFloat startX;
    CGFloat startY;
}
@end
@implementation CustomerFontLabel
@synthesize fontColorStringArray = _fontColorStringArray;
@synthesize textScrollView =_textScrollView;

- (instancetype)init{
    self = [super init];
    if (self) {
        startX = 0.f;
        startY = 0.f;
    }
    return self;
}

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect{
    [self creatTextScrollView:rect];
    [self drawText:rect];
}
/*
 *创建textScrollView
 */
-(void)creatTextScrollView:(CGRect)rect{
    if (!_textScrollView) {
        self.textScrollView = [[UIScrollView alloc]initWithFrame:rect];
        _textScrollView.scrollEnabled = NO;
        [self addSubview:_textScrollView];
    }
}

/*
 *绘制文字
 */
-(void)drawText:(CGRect)rect{
    if (_fontColorStringArray) {
        for (int i = 0; i < _fontColorStringArray.count; i++) {
            FontColorString* fontColorString = _fontColorStringArray[i];
            [self drawText:rect fontColorString:fontColorString index:i];
        }
    }
    _textScrollView.contentSize = CGSizeMake(rect.size.width,startY);
}
-(void)drawText:(CGRect)rect fontColorString:(FontColorString*)fontColorString index:(NSInteger)index{
    CGFloat stringWidth = [self getStringWidth:fontColorString.textStr font:fontColorString.font size:CGSizeMake(rect.size.width-startX,rect.size.height)];
    CGFloat stringHeight = [self getStringHeight:fontColorString.textStr font:fontColorString.font size:CGSizeMake(rect.size.width-startX,[UIScreen mainScreen].bounds.size.height)];
    UILabel* textLabel = [[UILabel alloc]initWithFrame:CGRectMake(startX,startY+fontColorString.offsetTop,stringWidth,stringHeight)];
    textLabel.numberOfLines = 0;
    textLabel.font = fontColorString.font;
    textLabel.textColor = fontColorString.color;
    textLabel.text = fontColorString.textStr;
    [_textScrollView addSubview:textLabel];
    
    CGFloat englishHeight = [self getStringHeight:@"w" font:fontColorString.font size:CGSizeMake(rect.size.width,[UIScreen mainScreen].bounds.size.height)];
    CGFloat chinaHeight = [self getStringHeight:@"字" font:fontColorString.font size:CGSizeMake(rect.size.width,[UIScreen mainScreen].bounds.size.height)];
    if (stringHeight > englishHeight||stringHeight > chinaHeight) {
        startX = 0.f;
        startY += stringHeight;
    }else{
        startX += stringWidth;
        if (index == _fontColorStringArray.count-1) {
            startY+= stringHeight;
        }
    }
}

-(void)addFontColorString:(FontColorString *)fontColorString{
    if (!_fontColorStringArray) {
        self.fontColorStringArray = [[NSMutableArray alloc]init];
    }
    [_fontColorStringArray addObject:fontColorString];
    [self setNeedsDisplay];
}
-(void)setFontColorStringArray:(NSMutableArray *)fontColorStringArray{
    _fontColorStringArray = fontColorStringArray;
    [self setNeedsDisplay];
}

/*计算字符串高度*/
-(CGFloat)getStringHeight:(NSString *)content font:(UIFont *)font size:(CGSize)size{
    CGSize resultSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeCharacterWrap];
    return resultSize.height;
}
/*计算字符串宽度*/
-(CGFloat)getStringWidth:(NSString *)content font:(UIFont *)font size:(CGSize)size{
    CGSize resultSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeCharacterWrap];
    return resultSize.width;
}
@end
