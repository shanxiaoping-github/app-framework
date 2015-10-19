//
//  FileUtil.h
//  apos-enterprise-ios
//
//  Created by shanxiaoping on 15-3-20.
//  Copyright (c) 2015年 cpz. All rights reserved.
//
/*文件操作类｀*/
#import <Foundation/Foundation.h>
@interface FileUtil : NSObject
/*获得沙盒的document地址*/
+(NSString*)getDocumentDir;
/*保存数据*/
+(void)saveFile:(NSData*)fileData fileName:(NSString*)fileName;
/*读取文本文件并解析*/
+(NSArray *)readText:(NSString *)sourceStr ofType:(NSString*)fileType fatherSeparated:(NSString*)fatherSeparated sonSeparated:(NSString *)sonSeparated;
@end
