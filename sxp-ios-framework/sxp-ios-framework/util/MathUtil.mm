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
+(BOOL)isNumber:(NSString *)str lastNumber:(NSInteger)lastNumber{
	if (!str) {
		return NO;
	}
	if ([str isEqualToString:@""]||[str isEqualToString:@" "]) {
		return NO;
	}
	int count = 0;
	for (int i = 0; i < str.length;i++) {
		char ch = [str characterAtIndex:i];
		if (!(ch >= 48&&ch <= 57)) {
			if (ch!='.') {
				return NO;
			}else{
				count++;
				if (count > 1||i == str.length-1||i == 0||i < str.length-lastNumber-1) {
					return NO;
				}
			}
		}
	}
	return YES;

}

+(id)getObjectForNSDictionary:(NSDictionary*)dic index:(NSInteger)index{
    NSEnumerator * enumeratorValue = [dic objectEnumerator];
    int i = 0;
    for (NSObject *object in enumeratorValue) {
        if ((i++) == index&&object) {
            return object;
        }
    }
    return nil;
}
+(NSString *)getKeyForNSDictionary:(NSDictionary *)dic index:(NSInteger)index{
    NSEnumerator * enumeratorKey = [dic keyEnumerator];
    int i = 0;
    for (NSString *key in enumeratorKey) {
        if ((i++) == index&&key) {
            return key;
        }
    }
    return @"";
}
+(NSString*)decimalNumberMutiplyWithString:(NSString*)multiplierValue value2:(NSString*)multiplicandValue{
	NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
	NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
	NSDecimalNumber *product = [multiplicandNumber decimalNumberByMultiplyingBy:multiplierNumber];
	return [product stringValue];
}
+(NSString *)decimalNumberMutiplyWithStringKeepDigit:(NSString *)multiplierValue value2:(NSString *)multiplicandValue keepCount:(short)keepCount{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:keepCount raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *product = [multiplierNumber decimalNumberByMultiplyingBy:multiplicandNumber withBehavior:roundingBehavior];
    return [product stringValue];
}

+(NSString*)decimalNumberDividingWithString:(NSString*)divtiplierValue value2:(NSString*)divtiplicandValue{
	NSDecimalNumber *divtiplierNumber = [NSDecimalNumber decimalNumberWithString:divtiplierValue];
	NSDecimalNumber *divtiplicandNumber = [NSDecimalNumber decimalNumberWithString:divtiplicandValue];
	NSDecimalNumber *product = [divtiplierNumber decimalNumberByDividingBy:divtiplicandNumber];
	return [product stringValue];
}
+(NSString *)decimalNumberDividingWithStringKeepDigit:(NSString *)divtiplierValue value2:(NSString *)divtiplicandValue keepCount:(short)keepCount{
    NSDecimalNumber *divtiplierNumber = [NSDecimalNumber decimalNumberWithString:divtiplierValue];
    NSDecimalNumber *divtiplicandNumber = [NSDecimalNumber decimalNumberWithString:divtiplicandValue];
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:keepCount raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *product = [divtiplierNumber decimalNumberByDividingBy:divtiplicandNumber withBehavior:roundingBehavior];
    return [product stringValue];
}

+(NSString *)decimalNumberAddWithString:(NSString *)addtiplierValue value2:(NSString *)addtiplicandValue{
    NSDecimalNumber *addtiplierNumber = [NSDecimalNumber decimalNumberWithString:addtiplierValue];
    NSDecimalNumber *addtiplicandNumber = [NSDecimalNumber decimalNumberWithString:addtiplicandValue];
    NSDecimalNumber *product = [addtiplierNumber decimalNumberByDividingBy:addtiplicandNumber];
    return [product stringValue];
}
+(NSString *)decimalNumberAddWithStringKeepDigit:(NSString *)addtiplierValue value2:(NSString *)addtiplicandValue keepCount:(short)keepCount{
    NSDecimalNumber *addtiplierNumber = [NSDecimalNumber decimalNumberWithString:addtiplierValue];
    NSDecimalNumber *addtiplicandNumber = [NSDecimalNumber decimalNumberWithString:addtiplicandValue];
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:keepCount raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *product = [addtiplierNumber decimalNumberByDividingBy:addtiplicandNumber withBehavior:roundingBehavior];
    return [product stringValue];

}

+(NSString *)decimalNumberSubWithString:(NSString *)subtiplierValue value2:(NSString *)subtiplicandValue{
    NSDecimalNumber *subtiplierNumber = [NSDecimalNumber decimalNumberWithString:subtiplierValue];
    NSDecimalNumber *subtiplicandNumber = [NSDecimalNumber decimalNumberWithString:subtiplicandValue];
    NSDecimalNumber *product = [subtiplierNumber decimalNumberBySubtracting:subtiplicandNumber];
    return [product stringValue];
}
+(NSString *)decimalNumberSubWithStringKeepDigit:(NSString *)subtiplierValue value2:(NSString *)subtiplicandValue keepCount:(short)keepCount{
    NSDecimalNumber *subtiplierNumber = [NSDecimalNumber decimalNumberWithString:subtiplierValue];
    NSDecimalNumber *subtiplicandNumber = [NSDecimalNumber decimalNumberWithString:subtiplicandValue];
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:keepCount raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *product = [subtiplierNumber decimalNumberBySubtracting:subtiplicandNumber withBehavior:roundingBehavior];
    return [product stringValue];
}
@end
