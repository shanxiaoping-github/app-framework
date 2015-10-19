//
//  MD5Util.m
//  WMF
//
//  Created by 单小萍 on 15/6/15.
//  Copyright (c) 2015年 beijingwomaifang. All rights reserved.
//

#import "MD5Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5Util
+ (NSString*)encryp:(NSString *)str {

  const char *original_str = [str UTF8String];
  unsigned char digist[CC_MD5_DIGEST_LENGTH]; // CC_MD5_DIGEST_LENGTH = 16
  CC_MD5(original_str, strlen(original_str),digist);
  NSMutableString *outPutStr = [NSMutableString stringWithCapacity:10];
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [outPutStr
        appendFormat:
            @"%02x",
            digist[i]]; //小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
  }
  return [outPutStr lowercaseString];
}
@end
