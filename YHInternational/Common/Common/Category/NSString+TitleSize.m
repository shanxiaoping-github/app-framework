//
//  NSString+TitleSize.m
//  Common
//
//  Created by Damon on 15/4/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "NSString+TitleSize.h"

@implementation NSString (TitleSize)

- (CGSize)sizeWithStringFont:(UIFont *)font constrainedToSize:(CGSize)size {
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedDescending) {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:size];
#pragma clang diagnostic pop
    }
}

//带行间距的算字体高度方法
- (CGSize)sizeWithStringFont:(UIFont *)font constrainedToSize:(CGSize)size lineSpacing:(CGFloat)lineSpacing{
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedDescending) {
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:lineSpacing];
        NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle1};
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:size];
#pragma clang diagnostic pop
    }
}

- (CGSize)sizeWithStringFont:(UIFont *)font {
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedDescending) {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        return [self boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font];
#pragma clang diagnostic pop
    }
}

@end
