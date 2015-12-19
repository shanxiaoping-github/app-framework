//
//  BBGRegionCache.m
//  Common
//
//  Created by Damon on 15/6/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegionCache.h"
#import <FMDB/FMDB.h>
#import "BBGRegion.h"
#import "BBGMacro.h"

@interface BBGRegionCache ()
@end

@implementation BBGRegionCache
DECLARE_SINGLETON(BBGRegionCache)

+ (void)initialize {
    @synchronized (self) {
        NSFileManager * fileManager = [NSFileManager defaultManager];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        
        NSError *error;

        NSString*dbPath =[documentDirectory stringByAppendingPathComponent:@"regionCache.db"];
        
        if([fileManager fileExistsAtPath:dbPath]== NO){
            NSString * path = [[NSBundle mainBundle] pathForResource:@"regionCache" ofType:@"db"];
            [fileManager copyItemAtPath:path toPath:dbPath error:&error];
            [BBGRegionCache addSkipBackupAttributeToItemAtPath:dbPath];
        }
    }
}

+ (NSString *)dbPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString * path = [documentDirectory stringByAppendingPathComponent:@"regionCache.db"];
    return path;
}

/**
 *  @author Damon, 15-03-28 12:03:28
 *
 *  跳过iCloud备份
 *
 *  @param URL 文件地址
 *
 *  @return 是否跳过成功
 */
+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString
{
    NSURL* URL= [NSURL fileURLWithPath: filePathString];
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (NSLock *)dbLock {
    static NSLock *lock = nil;
    @synchronized (self) {
        if(lock==nil){
            lock = [[NSLock alloc] init];
        }
    }
    return lock;
}

+ (BOOL)updateDB:(NSArray *)array{
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString*dbPath =[documentDirectory stringByAppendingPathComponent:@"regionCache.db"];
    
    if (![fileManager fileExistsAtPath:dbPath]) {
        [BBGRegionCache initialize];
    }
    FMDatabase *database = [FMDatabase databaseWithPath:[self dbPath]];
    BOOL isRollBack = NO;
//    [[BBGRegionCache dbLock] lock];
    [database open];
    [database beginTransaction];
    
    @try {
        for (NSString * sqlStr in array) {
            if (![database executeUpdate:sqlStr]) {
                NSLog(@"%@失败",sqlStr);
                [database rollback];
                isRollBack = YES;
                break;
            };
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        NSLog(@"任务失败");
        [database rollback];
        
    }
    @finally {
        if (!isRollBack) {
            NSLog(@"更新数据库任务完成");
            [database commit];
        }
    }
    
    [database close];
    database = nil;
    return !isRollBack;
//    [[BBGRegionCache dbLock] unlock];
}

+ (NSMutableArray *)queryData{
    NSFileManager * fileManager = [NSFileManager defaultManager];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString*dbPath =[documentDirectory stringByAppendingPathComponent:@"regionCache.db"];
    
    if (![fileManager fileExistsAtPath:dbPath]) {
        [BBGRegionCache initialize];
    }
    FMDatabase *database = [FMDatabase databaseWithPath:[self dbPath]];
//    [[BBGRegionCache dbLock] lock];
    [database open];
    [database beginTransaction];
    BOOL isRollBack = NO;
    NSMutableArray * provinceArray = [NSMutableArray array];
    NSMutableArray * cityArray = [NSMutableArray array];
    NSMutableArray * distrctArray = [NSMutableArray array];
    NSMutableArray * streetArray = [NSMutableArray array];
    
    BBGRegion * provinceRegion = [[BBGRegion alloc]init];
    BBGRegion * cityRegion = [[BBGRegion alloc]init];
    BBGRegion * distrctRegion = [[BBGRegion alloc]init];
    BBGRegion * streetRegion = [[BBGRegion alloc]init];
    
    NSString * currentProvince;
    NSString * currentCity;
    NSString * currentDistrct;
    
    @try {
        
        FMResultSet * result = [database executeQuery:@"SELECT * FROM RegionCache ORDER BY id ASC"];
        
        while ([result next]) {
            NSString * selfId = [result stringForColumn:@"id"];
            
            NSString * name = [result stringForColumn:@"name"];
            
            NSString * parentId = [result stringForColumn:@"parentId"];
            
            if (parentId.intValue < 1) {
                /**
                 *  省
                 */
                provinceRegion = nil;
                provinceRegion = [[BBGRegion alloc] init];
                provinceRegion.regionId = selfId;
                provinceRegion.name = name;
                provinceRegion.parentId = parentId;
                [provinceArray addObject:provinceRegion];
                
                if (![selfId isEqualToString:currentProvince]) {
                    [cityArray removeAllObjects];
                    [distrctArray removeAllObjects];
                    [streetArray removeAllObjects];
                }
                
                currentProvince = selfId;
            }
            
            if (parentId.intValue == currentProvince.intValue  && parentId.intValue > 0) {
                /**
                 *  市
                 */
                cityRegion = nil;
                cityRegion = [[BBGRegion alloc] init];
                cityRegion.regionId = selfId;
                cityRegion.name = name;
                cityRegion.parentId = parentId;
                [cityArray addObject:cityRegion];
                
                //省加入市
                BBGRegion * region = [provinceArray lastObject];
                region.regionChildren = nil;
                region.regionChildren = [NSMutableArray arrayWithArray:cityArray];
                [provinceArray replaceObjectAtIndex:(provinceArray.count - 1) withObject:region];
                
                
                if (![selfId isEqualToString:currentCity]) {
                    [distrctArray removeAllObjects];
                    [streetArray removeAllObjects];
                }
                
                currentCity = selfId;
            }
            
            if ([parentId isEqualToString:currentCity] && parentId.intValue > 0) {
                /**
                 *  区、县
                 */
                distrctRegion = nil;
                distrctRegion = [[BBGRegion alloc] init];
                distrctRegion.regionId = selfId;
                distrctRegion.name = name;
                distrctRegion.parentId = parentId;
                [distrctArray addObject:distrctRegion];
                
                //市加入区
                BBGRegion * region = [cityArray lastObject];
                [region.regionChildren removeAllObjects];
                region.regionChildren = nil;
                region.regionChildren = [NSMutableArray arrayWithArray:distrctArray];
                [cityArray replaceObjectAtIndex:(cityArray.count - 1) withObject:region];
                
                
                if (![selfId isEqualToString:currentDistrct]) {
                    [streetArray removeAllObjects];
                }
                
                currentDistrct = selfId;
            }
            
            if ([parentId isEqualToString:currentDistrct]  && parentId.intValue > 0) {
                /**
                 *  街道、县城
                 */
                streetRegion = nil;
                streetRegion = [[BBGRegion alloc] init];
                streetRegion.regionId = selfId;
                streetRegion.name = name;
                streetRegion.parentId = parentId;
                
                [streetArray addObject:streetRegion];
                
                //区加入街道操作
                BBGRegion * region = [distrctArray lastObject];
                [region.regionChildren removeAllObjects];
                region.regionChildren = nil;
                region.regionChildren = [NSMutableArray arrayWithArray:streetArray];
                [distrctArray replaceObjectAtIndex:(distrctArray.count - 1) withObject:region];
                
                
                //                currentStreet = selfId;
            }
            
            
        }
        [result close];
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        NSLog(@"任务失败");
        [database rollback];
        
        return nil;
    }
    @finally {
        if (!isRollBack) {
            NSLog(@"任务完成");
            [database commit];
        }
        
        [streetArray removeAllObjects];
        streetArray = nil;
        [cityArray removeAllObjects];
        cityArray = nil;
        [distrctArray removeAllObjects];
        distrctArray = nil;
        
        currentCity = nil;
        currentDistrct = nil;
        currentProvince = nil;
        
        return provinceArray;
    }
    
    [database close];
    database = nil;
//    [[BBGRegionCache dbLock] unlock];
    
}

@end
