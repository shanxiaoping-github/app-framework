//
//  BBGUserDataManager.m
//  Common
//
//  Created by calvin on 14-7-11.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGUserDataManager.h"
#import "BBGMacro.h"
#import <FMDB/FMDatabase.h>

@interface BBGUserDataManager ()

@property (nonatomic, strong) FMDatabase *database;

@end

@implementation BBGUserDataManager

DECLARE_SINGLETON(BBGUserDataManager)

- (id)init {
    self = [super init];
    if (self) {
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"userData.db"];
        _database = [[FMDatabase alloc] initWithPath:path];
        if ([_database open]) {
            [_database executeUpdate:@"CREATE TABLE IF NOT EXISTS USER(Username text,Usertoken text,Usersecret text)"];
            FMResultSet *user = [_database executeQuery:@"SELECT *FROM USER"];
            BOOL exist = NO;
            while ([user next]) {
                _username = [user stringForColumn:@"Username"];
                _usertoken = [user stringForColumn:@"Usertoken"];
                _usersecret = [user stringForColumn:@"Usersecret"];
                exist = YES;
            }
            if (!exist) {
                [_database executeUpdate:@"INSERT INTO USER(Username,Usertoken,Usersecret) VALUES(?,?,?)",nil,nil,nil];
            }
        }
        [_database close];
    }
    return self;
}

- (void)setUsername:(NSString *)username {
    if ([_database open]) {
        [_database executeUpdate:@"UPDATE USER SET Username=?",username];
    }
    [_database close];
    _username = username;
}

- (void)setUsertoken:(NSString *)usertoken {
    if ([_database open]) {
        [_database executeUpdate:@"UPDATE USER SET Usertoken=?",usertoken];
    }
    [_database close];
    _usertoken = usertoken;
}

- (void)setUsersecret:(NSString *)usersecret {
    if ([_database open]) {
        [_database executeUpdate:@"UPDATE USER SET Usersecret=?",usersecret];
    }
    [_database close];
    _usersecret = usersecret;
}

@end
