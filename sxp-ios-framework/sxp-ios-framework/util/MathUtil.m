//
//  MathUtil.m
//  mqsystem
//
//  Created by shanxiaoping on 15-1-26.
//  Copyright (c) 2015年 yicai. All rights reserved.
//

#import "MathUtil.h"
#import <Foundation/Foundation.h>

@implementation MathUtil
+(NSString *)numberToString:(NSNumber *)number{
    NSNumberFormatter* numberFormatter = [NSNumberFormatter new];
    return [numberFormatter stringFromNumber:number];
}
+(NSNumber *)stringToNumber:(NSString *)str{
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    return [numberFormatter numberFromString:str];
}
+(BOOL)isNumber:(NSString *)str{
    NSString* string = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0){
        return NO;
    }
    return YES;
}
+(BOOL)isNumberforObject:(id)object{
    @try{
        [object doubleValue];
    }
    @catch(NSException *exception){
        return NO;
    }
    return YES;
}
@end
