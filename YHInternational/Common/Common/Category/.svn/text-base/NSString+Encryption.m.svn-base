//
//  NSString+Encryption.m
//  Common
//
//  Created by Damon on 15/4/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "NSString+Encryption.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (Encryption)

//MD5
- (NSString *)md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}
@end
