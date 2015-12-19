//
//  BBGUserDataManager.h
//  Common
//
//  Created by calvin on 14-7-11.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBGUserDataManager : NSObject

+ (BBGUserDataManager *)sharedInstance;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *usertoken;
@property (nonatomic, strong) NSString *usersecret;

@end
