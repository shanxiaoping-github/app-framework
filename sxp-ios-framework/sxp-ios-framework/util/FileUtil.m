//
//  FileUtil.m
//  apos-enterprise-ios
//
//  Created by shanxiaoping on 15-3-20.
//  Copyright (c) 2015年 cpz. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil
+(NSString *)getDocumentDir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}
+(void)saveFile:(NSData *)fileData fileName:(NSString *)fileName{
    [fileData writeToFile:fileName atomically:YES];
}

+(NSArray *)readText:(NSString *)sourceStr ofType:(NSString *)fileType fatherSeparated:(NSString *)fatherSeparated sonSeparated:(NSString *)sonSeparated{
    
    
    NSMutableArray* resultArray = [NSMutableArray new];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:sourceStr ofType:fileType];
    
    
    NSArray *fileData;
    NSError *error;
    
    //读取file文件并把内容根据换行符分割后赋值给NSArray
    fileData = [[NSString stringWithContentsOfFile:filePath
                                          encoding:NSUTF8StringEncoding
                                             error:&error]
                componentsSeparatedByString:fatherSeparated];
    
    
    //获取NSArray类型对象的迭代器
    NSEnumerator *arrayEnumerator = [fileData objectEnumerator];
    NSString *tempStr;
    
    while (tempStr = [arrayEnumerator nextObject]) {
        NSString *trimTempStr = [tempStr stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        NSArray* tempArray = [trimTempStr componentsSeparatedByString:sonSeparated];
        [resultArray addObject:tempArray];
       // [resultArray addObjectsFromArray:tempArray];
    }
    return resultArray;

}
@end
