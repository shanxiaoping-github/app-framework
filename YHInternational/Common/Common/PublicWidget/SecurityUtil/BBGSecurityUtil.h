//
//  BBGSecurityUtil.h
//  Common
//
//  Created by yangjie on 15/10/23.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBGSecurityUtil : NSObject

//RC4 编码
+(NSString*)rc4EncryptWithText:(NSString*)sText theKey:(NSString*)aKey;
+(NSString*)rc4DecryptWithText:(NSString*)sText theKey:(NSString*)aKey;

@end
