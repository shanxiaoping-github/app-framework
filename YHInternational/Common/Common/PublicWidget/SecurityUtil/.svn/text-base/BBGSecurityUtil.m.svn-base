//
//  BBGSecurityUtil.m
//  Common
//
//  Created by yangjie on 15/10/23.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGSecurityUtil.h"
#import "RC4.h"

@implementation BBGSecurityUtil

+(NSString*)rc4EncryptWithText:(NSString*)sText theKey:(NSString*)aKey{
    RC4* rc4Obj = [[RC4 alloc] initWithKey:aKey];
    NSString* encryptStr = [rc4Obj encryptString:sText];
    return [encryptStr lowercaseString];
}
+(NSString*)rc4DecryptWithText:(NSString*)sText theKey:(NSString*)aKey{
    RC4* rc4Obj = [[RC4 alloc] initWithKey:aKey];
    NSString* decryptStr = [rc4Obj decryptString:sText];
    return decryptStr;
}


@end
