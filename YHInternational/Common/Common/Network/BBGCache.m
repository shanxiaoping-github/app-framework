#import "BBGCache.h"
#import <FMDB/FMDatabase.h>
#import "NSString+Utils.h"

@interface BBGCachePolicy()

@end

@implementation BBGCachePolicy

+(id)cachePolicyWithCacheType:(BBGCacheType)cacheType {
    return [[BBGCachePolicy alloc] initWithCacheType:cacheType];
}

-(id)initWithCacheType:(BBGCacheType)cacheType {
    self = [super init];
    if(self){
        _cacheType = cacheType;
        if(_cacheType==BBGCacheTypeImage){
            _useFileCache = YES;
        }
        else {
            _useFileCache = NO;
        }
    }
    return self;
}


-(id)copyWithZone:(NSZone *)zone {
    BBGCachePolicy* cachePolicy = [[BBGCachePolicy allocWithZone:zone] initWithCacheType:_cacheType];
    return cachePolicy;
}

@end

@implementation BBGCache

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

+ (void)initialize {
    @synchronized (self) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:[self dbPath]]) {
            //初始化数据文件和创建表结构
            FMDatabase *cacheDatabase = [FMDatabase databaseWithPath:[self dbPath]];
            [cacheDatabase open];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"cache" ofType:@"sql"];
            NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:path];
            NSData *data = [file readDataToEndOfFile];
            NSString *sqlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [cacheDatabase executeUpdate:sqlString];
            [file closeFile];
            [cacheDatabase close];
            [self addSkipBackupAttributeToItemAtPath:[self dbPath]];
        }
    }
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

+ (NSString *)dbPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"cache_2_1b.db"];
}

+ (NSString *)fileCachePath:(BBGCacheType)cacheType {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString* fileCacheName = [NSString stringWithFormat:@"fileCache_%d",cacheType];
    NSString *fileCacheDirectory = [documentDirectory stringByAppendingPathComponent:fileCacheName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:fileCacheDirectory isDirectory:nil]){
        [[NSFileManager defaultManager] createDirectoryAtPath:fileCacheDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return fileCacheDirectory;
}

//清除缓存
+ (void)clearCache {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString* fileCacheName = @"FileCache";
    NSString *fileCacheDirectory = [documentDirectory stringByAppendingPathComponent:fileCacheName];
    if([[NSFileManager defaultManager] fileExistsAtPath:fileCacheDirectory isDirectory:nil]){
        [[NSFileManager defaultManager] createDirectoryAtPath:fileCacheDirectory withIntermediateDirectories:NO attributes:nil error:nil];
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:fileCacheDirectory error:&error];
    }
}

+ (void)clearCacheWithMaxSize:(long)maxsize clearSize:(long)clearsize {
    if (clearsize<=maxsize) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString* fileCacheName = @"FileCache";
        NSString *fileCacheDirectory = [documentDirectory stringByAppendingPathComponent:fileCacheName];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:fileCacheDirectory isDirectory:nil]){
            NSArray* dicContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:fileCacheDirectory error:nil];
            long long length = 0;
            NSMutableArray *cacheArray = [[NSMutableArray alloc] init];
            for (int a = 0; a < [dicContents count]; a++) {
                NSString *cacheName = [dicContents objectAtIndex:a];
                NSString *cacheFile = [NSString stringWithFormat:@"%@/%@",fileCacheDirectory,cacheName];
                NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:cacheFile error:nil];
                //创建日期
                NSString *createDate = [fileAttributes objectForKey: NSFileCreationDate];
                //文件大小
                NSString *fileSize = [fileAttributes objectForKey:NSFileSize];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:createDate forKey:@"createDate"];
                [dic setObject:cacheFile forKey:@"cacheFile"];
                [dic setObject:fileSize forKey:@"fileSize"];
                [cacheArray addObject:dic];

                length = length + [fileSize longLongValue];
            }
            //当缓存量大于最大峰值
            if (length > maxsize) {
                //按创建日期先后顺序排序
                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"createDate" ascending:YES];
                NSArray *sortedArray = [cacheArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
                length = 0;
                for (int i = 0; i<[sortedArray count]; i++) {
                    NSMutableDictionary *sortDic = [sortedArray objectAtIndex:i];
                    NSString *fileSize = [sortDic objectForKey:@"fileSize"];
                    length += [fileSize longLongValue];
                    //当缓存量大于清除量
                    if (length > clearsize) {
                        for (int j = 0; j<i+1; j++) {
                            NSString *filePath = [[sortedArray objectAtIndex:j] objectForKey:@"cacheFile"];
                            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                        }
                        break;
                    }
                }
            }
        }
    }
}

//查询缓存
+ (id)queryCache:(NSString *)key {
    if(!key) return nil;
    id obj = nil;
    [[self dbLock] lock];
    FMDatabase *cacheDatabase = [FMDatabase databaseWithPath:[self dbPath]];
    [cacheDatabase open];
    NSNumber *nowNumber = [NSNumber numberWithInteger:(NSInteger) [[NSDate date] timeIntervalSince1970]];
    FMResultSet *rs = [cacheDatabase executeQuery:@"select * from `cache` where `key` = ? and (`expdate` > ? or `expdate` = 0)", key, nowNumber];
    if ([rs next]) {
        NSNumber *fileNumber = [rs objectForColumnName:@"file"];
        NSData* data;
        if(fileNumber.boolValue){
            NSString* filePath = [rs objectForColumnName:@"value"];
            data = [NSData dataWithContentsOfFile:filePath];
        }
        else {
            data = [rs objectForColumnName:@"value"];
        }
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    [rs close];
    [cacheDatabase close];
    [[self dbLock] unlock];
    return obj;
}

//查询缓存，返回某类型的所有数据
+ (NSArray *)queryCacheForType:(BBGCacheType)type {
    NSMutableArray *arr = [NSMutableArray array];
    [[self dbLock] lock];
    FMDatabase *cacheDatabase = [FMDatabase databaseWithPath:[self dbPath]];
    [cacheDatabase open];
    NSNumber *nowNumber = [NSNumber numberWithInteger:(NSInteger) [[NSDate date] timeIntervalSince1970]];
    NSNumber *typeNumber = [NSNumber numberWithInteger:type];
    FMResultSet *rs = [cacheDatabase executeQuery:@"select * from `cache` where `type` = ? and (`expdate` > ? or `expdate` = 0)", typeNumber, nowNumber];
    while ([rs next]) {
        NSNumber *fileNumber = [rs objectForColumnName:@"file"];
        NSData* data;
        if(fileNumber.boolValue){
            NSString* filePath = [rs objectForColumnName:@"value"];
            data = [NSData dataWithContentsOfFile:filePath];
        }
        else {
            data = [rs objectForColumnName:@"value"];
        }
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [arr addObject:obj];
    }
    [rs close];
    [cacheDatabase close];
    [[self dbLock] unlock];
    return arr;
}

+ (NSArray *)queryCacheForType:(BBGCacheType)type maxCount:(NSInteger)maxCount {
    NSMutableArray *arr = [NSMutableArray array];
    [[self dbLock] lock];
    FMDatabase *cacheDatabase = [FMDatabase databaseWithPath:[self dbPath]];
    [cacheDatabase open];
    NSNumber *nowNumber = [NSNumber numberWithInteger:(NSInteger) [[NSDate date] timeIntervalSince1970]];
    NSNumber *typeNumber = [NSNumber numberWithInteger:type];
    
    NSString* sqlCommand = [NSString stringWithFormat:@"select * from `cache` where `type` = ? and (`expdate` > ? or `expdate` = 0) order by `newdate` desc limit 0,%ld",(long)maxCount];
    FMResultSet *rs = [cacheDatabase executeQuery:sqlCommand, typeNumber, nowNumber];
    while ([rs next]) {
        NSNumber *fileNumber = [rs objectForColumnName:@"file"];
        NSData* data;
        if(fileNumber.boolValue){
            NSString* filePath = [rs objectForColumnName:@"value"];
            data = [NSData dataWithContentsOfFile:filePath];
        }
        else {
            data = [rs objectForColumnName:@"value"];
        }
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [arr addObject:obj];
    }
    [rs close];
    [cacheDatabase close];
    [[self dbLock] unlock];
    return arr;
}

//查询某类型数据条数
+ (NSInteger)queryCacheCountForType:(BBGCacheType)type {
    NSInteger count = 0;
    [[self dbLock] lock];
    FMDatabase *cacheDatabase = [FMDatabase databaseWithPath:[self dbPath]];
    [cacheDatabase open];
    NSNumber *nowNumber = [NSNumber numberWithInteger:(NSInteger) [[NSDate date] timeIntervalSince1970]];
    NSNumber *typeNumber = [NSNumber numberWithInteger:type];
    FMResultSet *rs = [cacheDatabase executeQuery:@"select count(*) from `cache` where `type` = ? and (`expdate` > ? or `expdate` = 0)", typeNumber, nowNumber];
    while ([rs next]) {
        count = [rs intForColumnIndex:0];
    }
    [rs close];
    [cacheDatabase close];
    [[self dbLock] unlock];
    return count;
}

//添加缓存
+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj {
    [self addCache:key obj:obj type:BBGCacheTypeNone];
}

+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj type:(BBGCacheType)type {
    [self addCache:key obj:obj type:type expDate:[NSDate dateWithTimeIntervalSince1970:0]];
}

+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj type:(BBGCacheType)type expDate:(NSDate *)expDate {
    BBGCachePolicy* policy = [[BBGCachePolicy alloc] initWithCacheType:type];
    policy.expDate = expDate;
    [self addCache:key obj:obj policy:policy];
}

+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj policy:(BBGCachePolicy*)policy {
    if(!key) return;
    if(!obj) return;
    if(!policy) [self addCache:key obj:obj];
    [[self dbLock] lock];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    id cacheValue = data;
    if(policy.useFileCache){
        NSString* guid = [NSString guid];
        NSString* filePath = [[self fileCachePath:policy.cacheType] stringByAppendingPathComponent:[guid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:nil]){
           [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        [data writeToFile:filePath atomically:YES];
        cacheValue = filePath;
    }
    FMDatabase *cacheDatabase = [FMDatabase databaseWithPath:[self dbPath]];
    [cacheDatabase open];
    NSNumber *fileNumber = [NSNumber numberWithBool:policy.useFileCache];
    NSNumber *nowNumber = [NSNumber numberWithInteger:(NSInteger) [[NSDate date] timeIntervalSince1970]];
    NSNumber *expNumber = [NSNumber numberWithInteger:(NSInteger) [policy.expDate timeIntervalSince1970]];
    NSNumber *typeNumber = [NSNumber numberWithInteger:policy.cacheType];
    [cacheDatabase executeUpdate:@"delete from `cache` where `key`=?", key];
    [cacheDatabase executeUpdate:@"insert into `cache` values (?,?,?,?,?,?)", key, cacheValue, fileNumber, typeNumber, nowNumber, expNumber];
    [cacheDatabase close];
    [[self dbLock] unlock];
}

//删除指定key缓存
+ (void)removeCacheForKey:(NSString *)key {
    [[self dbLock] lock];
    FMDatabase *cacheDatabase = [FMDatabase databaseWithPath:[self dbPath]];
    [cacheDatabase open];
    [cacheDatabase executeUpdate:@"delete from `cache` where `key` = ?", key];
    [cacheDatabase close];
    [[self dbLock] unlock];
}

//删除指定type缓存
+ (void)removeCacheForType:(BBGCacheType)type {
    [[self dbLock] lock];
    FMDatabase *cacheDatabase = [FMDatabase databaseWithPath:[self dbPath]];
    NSNumber *typeNumber = [NSNumber numberWithInteger:type];
    [cacheDatabase open];
    [cacheDatabase executeUpdate:@"delete from `cache` where `type` = ?", typeNumber];
    [cacheDatabase close];
    [[self dbLock] unlock];
    NSString* fileCachePath = [self fileCachePath:type];
    if([[NSFileManager defaultManager] fileExistsAtPath:fileCachePath isDirectory:nil]){
        [[NSFileManager defaultManager] removeItemAtPath:fileCachePath error:nil];
    }
}

//删除所有缓存
+ (void)removeAllCache {
    [[self dbLock] lock];
    FMDatabase *cacheDatabase = [FMDatabase databaseWithPath:[self dbPath]];
    [cacheDatabase open];
    [cacheDatabase executeUpdate:@"delete from `cache`"];
    [cacheDatabase close];
    [[self dbLock] unlock];
}

@end