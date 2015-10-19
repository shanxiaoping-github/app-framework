//
//  StringUtil.m
//  WMF
//
//  Created by 单小萍 on 15/6/16.
//  Copyright (c) 2015年 beijingwomaifang. All rights reserved.
//

#import "StringUtil.h"
#import "Position.h"


@implementation StringUtil
+(BOOL)isEmpty:(NSString *)str{
    if (!str||str == [NSNull null]){
        return true;
    }
    if ([str isEqualToString:@""]) {
        return true;
    }
    if ([str isEqualToString:@" "]) {
        return true;
    }
    return false;
}
+(BOOL)isJsonEmpty:(NSString *)str{
    if ([StringUtil isEmpty:str]){
        return true;
    }
    if ([str isEqualToString:@"[]"]) {
        return true;
    }
    if ([str isEqualToString:@"[ ]"]) {
        return true;
    }
    return false;
}
+(NSMutableArray *)sqlite:(NSString *)str symbol:(NSString *)symbol excluding:(NSString *)excluding{
    
    NSMutableArray *array=[NSMutableArray new];
    if (!str) {
        return array;
    }
    NSArray* data=[str componentsSeparatedByString:symbol];
    if (!excluding) {
        [array addObjectsFromArray:data];
    }else{
        for (int i=0; i<[data count]; i++) {
            NSString* itemStr = [data objectAtIndex:i];
            itemStr=[itemStr stringByReplacingOccurrencesOfString:excluding withString:@""];
            [array addObject:itemStr];
        }
        
    }
    return array;
}
+(NSMutableArray *)sqlite:(NSString *)str symbol:(NSString *)symbol{
    return [StringUtil sqlite:str symbol:symbol excluding:@"\""];
}
+(NSString *)customReplaceString:(NSString *)str replaceStr:(NSString *)replaceStr start:(int)startIndex end:(int)endIndex{
    if (!str) {
        return str;
    }
    int minLeng = startIndex+endIndex;
    if ([str length]<=minLeng) {
        return str;
    }
    NSString* startSubStr = [str substringToIndex:startIndex];
    NSString* endSubStr = [str substringFromIndex:[str length]-endIndex];
    return [[NSString alloc] initWithFormat:@"%@%@%@",startSubStr,replaceStr,endSubStr];
    
    
}


+(BOOL)isAllNumberOfString:(NSString *)myString
{
    BOOL flag =YES;
    NSArray *allowChar = [NSArray         arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".", nil];
    for (int i = 0; i<myString.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *aString =[myString substringWithRange:range];
        BOOL isNum = NO;
        for (int j=0; j<allowChar.count; j++) {
            if([aString isEqualToString:[allowChar objectAtIndex:j]])
            {
                isNum = YES;
                break;
            }
        }
        if(!isNum)
        {
            flag = NO;
            break;
        }
    }
    return flag;
}

+(NSString *)replaceStrSource:(NSString *)sourceStr requestReplaceStr:(NSString *)requestReplaceStr replaceStr:(NSString *)replaceStr{
    NSRange range = [sourceStr rangeOfString:requestReplaceStr];
    if (range.length>0) {
        NSMutableString *resultStr = [[NSMutableString alloc] initWithString:sourceStr];
        [resultStr replaceCharactersInRange:range withString:replaceStr];
        return resultStr;
    }else{
        return sourceStr;
    }
}
+(NSString *)replaceCompanyInformation:(NSString *)souceStr{
    static NSString* str1 = @"和付";
    static NSString* str2 = @"和付公司";
    static NSString* replaceStr = @"湖南银联";
    
    NSString* result1 = [StringUtil replaceStrSource:souceStr requestReplaceStr:str1 replaceStr:replaceStr];
    NSString* result2 = [StringUtil replaceStrSource:result1 requestReplaceStr:str2 replaceStr:replaceStr];
    return result2;
}
+(NSString *)getUUID{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef = CFUUIDCreateString(NULL,uuidRef);
    NSString *retStr = [NSString stringWithFormat:@"%@",(__bridge NSString*)uuidStrRef];
    return retStr;
}
/*获取分段颜色文字*/
+(NSMutableAttributedString *)getAttributeString:(NSString *)content colors:(NSArray *)colors indexs:(NSArray*)indexs{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc]initWithString:content];
    for (int i = 0; i < [colors count];i++) {
        Position* position = indexs[i];
        [str addAttribute:NSForegroundColorAttributeName value:colors[i] range:NSMakeRange(position.st,position.ed)];
    }
    return str;
}
/*计算字符串高度*/
+(CGFloat)getStringHeight:(NSString *)content font:(UIFont *)font size:(CGSize)size{
    CGSize resultSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return resultSize.height;
}
/*计算字符串宽度*/
+(CGFloat)getStringWidth:(NSString *)content font:(UIFont *)font size:(CGSize)size{
    CGSize resultSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return resultSize.width;
}

@end
